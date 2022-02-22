package main

import (
	_ "cakrawala.id/m/docs"
	"cakrawala.id/m/models"
	"cakrawala.id/m/routes"
	"github.com/gin-gonic/gin"
	ginSwagger "github.com/swaggo/gin-swagger"
	"github.com/swaggo/gin-swagger/swaggerFiles"
	"net/http"
)

// @title Cakrawala API
// @version 1.0
// @description This is a API for cakrawala.
// @termsOfService http://swagger.io/terms/

// @contact.name Kelompok 14

// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html

// @host localhost:8080
// @BasePath /
// @schemes http
func main() {
	r := gin.Default()

	routes.GetRoutes(r)
	r.GET("/", func(context *gin.Context) {
		context.JSON(http.StatusOK, gin.H{
			"test": "oke boskuh",
		})
	})
	swg := ginSwagger.URL("http://localhost:8080/swagger/doc.json")
	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler, swg))
	models.ConnectDatabase()

	err := r.Run()
	if err != nil {
		panic("oiii gabisa jalan aplikasinyaa")
	}
}
