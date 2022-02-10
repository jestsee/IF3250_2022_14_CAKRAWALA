package main

import (
	"net/http"

	"cakrawala.id/m/controllers"
	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/", func(context *gin.Context) {
		context.JSON(http.StatusOK, gin.H{
			"test": "oke boskuh",
		})
	})

	r.POST("/register", controllers.Register)

	models.ConnectDatabase()

	err := r.Run()
	if err != nil {
		panic("oiii gabisa jalan aplikasinyaa")
	}
}
