package main

import (
	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	r := gin.Default()
	r.GET("/", func(context *gin.Context) {
		context.JSON(http.StatusOK, gin.H{
			"test": "oke boskuh",
		})
	})

	models.ConnectDatabase()

	err := r.Run()
	if err != nil {
		panic("oiii gabisa jalan aplikasinyaa")
	}
}
