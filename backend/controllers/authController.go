package controllers

import (
	"net/http"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
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

	c.JSON(http.StatusOK, user)
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
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "incorrect password",
		})
		return
	}

	c.JSON(http.StatusOK, user)

}
