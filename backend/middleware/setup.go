package middleware

import (
	"cakrawala.id/m/models"
	"cakrawala.id/m/utils"
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

func IsAuthrorized() gin.HandlerFunc {
	return func(c *gin.Context) {
		token := c.GetHeader("Authorization")
		println(token)
		if token == "" {
			c.AbortWithStatusJSON(400, gin.H{
				"message": "tidak ada authorization header",
			})
			return
		}
		var auth models.Auth
		err := models.DB.Preload("User").Where("token = ?", token).First(&auth)
		println(auth.ID)
		if err == nil {
			c.AbortWithStatusJSON(401, gin.H{
				"message": "Token tidak ada",
			})
			return
		}

		if time.Now().Before(auth.ExpiredAt) == false {
			c.AbortWithStatusJSON(402, gin.H{
				"message": "Token Expire",
			})
			return
		}
		c.Set("user", auth.User)
		c.Next()
	}
}

func CheckRegister() gin.HandlerFunc {
	return func(c *gin.Context) {
		var data map[string]string
		if err := c.ShouldBindJSON(&data); err != nil {
			c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
			return
		}
		var cols = [4]string{"email", "password", "name", "phone"}
		for i := range cols {
			if val, ok := data[cols[i]]; !ok {
				c.JSON(http.StatusBadRequest, utils.ExceptionResponse(fmt.Sprint("col %s has no value, val: %s", cols[i], val)))
				return
			}
		}
		var user models.User
		err := models.DB.Where("email = ?", data["email"]).First(&user).Error
		if err == nil {
			c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
				"message": "email sudah pernah dipakai",
			})
		}
		c.Next()
	}
}
