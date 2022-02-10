package routes

import (
	"cakrawala.id/m/controllers"
	"github.com/gin-gonic/gin"
)

func adminRoutes(e *gin.Engine) {
	gr := e.Group("/admin")
	{
		gr.POST("/register", controllers.Register)
		gr.POST("/login", controllers.Login)
	}
}
