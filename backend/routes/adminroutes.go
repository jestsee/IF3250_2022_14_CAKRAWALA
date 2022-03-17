package routes

import (
	"cakrawala.id/m/controllers"
	"cakrawala.id/m/controllers/transactions"
	"github.com/gin-gonic/gin"
)

func adminRoutes(e *gin.Engine) {
	gr := e.Group("/admin")
	{
		gr.POST("/login", controllers.Login)

		gr.PATCH("/top-up/:id", transactions.ApproveTopUp)
		gr.GET("/top-up/request", transactions.GetTopUpRequest)

		gr.GET("/transaction-history-admin", transactions.GetTransactionHistoryAdmin)

		// gr.POST("/transfer", transactions.Transfer)
		// gr.POST("/pay-merchant", transactions.PayMerchant)
		gr.POST("/merchant/add", transactions.AddMerchant)
		gr.GET("/merchant", transactions.GetAllMerchantsAdmin)
	}
}
