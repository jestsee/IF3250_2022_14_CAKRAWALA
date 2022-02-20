package routes

import (
	"cakrawala.id/m/controllers"
	"cakrawala.id/m/controllers/transactions"
	"cakrawala.id/m/middleware"
	"github.com/gin-gonic/gin"
)

func userRoutes(e *gin.Engine) {
	gr := e.Group("/v1")
	{
		gr.POST("/register", middleware.CheckRegister(), controllers.Register)
		gr.POST("/login", controllers.Login)
		gr.GET("/test", middleware.IsAuthrorized(), func(context *gin.Context) {
			context.JSON(200, gin.H{
				"message": "tampan dan pemberani",
			})
		})

		gr.POST("/top-up", middleware.IsAuthrorized(), transactions.TopUpRequest)
	}
}
