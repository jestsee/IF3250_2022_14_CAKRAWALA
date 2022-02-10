package controllers

import (
	"net/http"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
)

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}

func Register(c *gin.Context) {
	var data map[string]string

	if err := c.ShouldBindJSON(&data); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
	}

	user := models.User{
		Email:    data["email"],
		Password: data["password"],
		Name:     data["name"],
		Phone:    data["phone"],
	}

	models.DB.Create(&user)

	c.JSON(http.StatusOK, data)
}

// func Register(c *gin.Context) {
// 	var data map[string]string

// 	if err := c.ShouldBindJSON(&data); err != nil {
// 		c.JSON(http.StatusBadRequest, errorResponse(err))
// 	}

// 	// TODO
// 	// password, _ := bcrypt.GenerateFromPassword([]byte(data["password"]), 14)

// 	user := models.User{
// 		Email:    data["email"],
// 		Password: data["password"],
// 		Name:     data["name"],
// 		Phone:    data["phone"],
// 	}

// 	models.DB.Create(&user)

// 	c.JSON(http.StatusOK, data)
// }
