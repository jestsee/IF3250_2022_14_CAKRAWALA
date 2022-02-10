package controllers

import (
	"github.com/golang-jwt/jwt/v4"
	"github.com/joho/godotenv"
	"net/http"
	"os"
	"time"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}

func getenv(key string) string {
	err := godotenv.Load(".env")

	if err != nil {
		panic("gawatt, env tidak terdeteksii")
	}

	return os.Getenv(key)
}

func Register(c *gin.Context) {
	var data map[string]string

	if err := c.ShouldBindJSON(&data); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	password, _ := bcrypt.GenerateFromPassword([]byte(data["password"]), 14)

	user := models.User{
		Email:    data["email"],
		Password: string(password),
		Name:     data["name"],
		Phone:    data["phone"],
	}

	models.DB.Create(&user)

	expiryDate := time.Now().AddDate(0, 0, 10)
	jwtToken := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"expire":    expiryDate,
		"userId":    user.ID,
		"userEmail": user.Email,
		"userPhone": user.Phone,
		"userName":  user.Name,
	})
	tokenStr, e := jwtToken.SignedString([]byte(getenv("JWTKEY")))
	if e != nil {
		c.JSON(500, gin.H{
			"message": "something wrong happened while create jwt",
		})
	}
	authToken := models.Auth{
		ExpiredAt: expiryDate,
		UserID:    user.ID,
		Token:     tokenStr,
	}
	models.DB.Create(&authToken)
	c.JSON(http.StatusOK, gin.H{
		"user":  user,
		"token": tokenStr,
	})
}

func Login(c *gin.Context) {
	var data map[string]string

	if err := c.ShouldBindJSON(&data); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	var user models.User

	models.DB.Where("email = ?", data["email"]).First(&user)

	if user.ID == 0 {
		c.JSON(http.StatusNotFound, gin.H{
			"message": "user not found",
		})
		return
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(data["password"])); err != nil {
		c.JSON(http.StatusForbidden, gin.H{
			"message": "incorrect password",
		})
		return
	}

	var token models.Auth
	err := models.DB.Where("user_id = ?", user.ID).First(&token)
	expiryDate := time.Now().AddDate(0, 0, 10)
	jwtToken := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"expire":    expiryDate,
		"userId":    user.ID,
		"userEmail": user.Email,
		"userPhone": user.Phone,
		"userName":  user.Name,
	})
	tokenStr, e := jwtToken.SignedString([]byte(getenv("JWTKEY")))
	if e != nil {
		c.JSON(500, gin.H{
			"message": "something wrong happened while create jwt",
		})
	}

	if err != nil {
		token.ExpiredAt = expiryDate
		token.Token = tokenStr
		models.DB.Updates(&token)
	} else {
		authToken := models.Auth{
			ExpiredAt: expiryDate,
			UserID:    user.ID,
			Token:     tokenStr,
		}
		models.DB.Create(&authToken)
	}

	c.JSON(http.StatusOK, gin.H{
		"user":   user,
		"token":  tokenStr,
		"expire": expiryDate,
	})

}
