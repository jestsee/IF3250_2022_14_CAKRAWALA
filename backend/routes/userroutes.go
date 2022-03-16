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
		gr.POST("/register", controllers.Register)
		gr.POST("/login", controllers.Login)
		gr.GET("/test", middleware.IsAuthrorized(), func(context *gin.Context) {
			context.JSON(200, gin.H{
				"message": "tampan dan pemberani",
			})
		})
		gr.GET("/self", middleware.IsAuthrorized(), controllers.UserInfo)

		gr.POST("/top-up", middleware.IsAuthrorized(), transactions.TopUpRequest)

		gr.GET("/merchant", middleware.IsAuthrorized(), transactions.GetAllMerchant)
	}
}
