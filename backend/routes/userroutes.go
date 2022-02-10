package routes

import (
	"cakrawala.id/m/controllers"
	"github.com/gin-gonic/gin"
)

func userRoutes(e *gin.Engine) {
	gr := e.Group("/v1")
	{
		gr.POST("/register", controllers.Register)
		gr.POST("/login", controllers.Login)
	}
}
