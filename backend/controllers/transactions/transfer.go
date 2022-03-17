package transactions

// import (
// 	"net/http"

// 	"cakrawala.id/m/models"
// 	"cakrawala.id/m/service"
// 	"cakrawala.id/m/utils"
// 	"github.com/gin-gonic/gin"
// )


// type TransferBody struct {
// 	Amount 		uint64 	`json:"amount`
// 	Exp 		uint32 	`json:"exp"`
// 	Status 		string 	`json:"status"`
// 	Cashback 	uint32 	`json:"cashback"`
// 	UserID 		uint 	`json:"user_id"`
// 	FriendID 	uint 	`json:"friend_id"`
// }

// func Transfer(c *gin.Context)  {
// 	user := c.MustGet("user").(models.User)
// 	data := new(PayMerchantBody)

// 	if err := c.ShouldBind(data); err != nil {
// 		c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
// 		return
// 	}

// 	bonus := service.TransferBonus(user, int64(data.Amount))
// 	transaction := models.Transaksi{
// 		Amount: data.Amount,
// 		Exp: uint32(bonus),
// 		Cashback: uint32(5),
// 		UserID: data.UserID,
// 		MerchantID: nil,
// 		FriendID: &data.UserID,
// 	}

// 	err := models.DB.Create(&transaction).Error
// 	if err != nil {
// 		_ = c.AbortWithError(500, err)
// 		return
// 	}

// 	c.JSON(http.StatusOK, gin.H{
// 		"message": "berhasil transfer",
// 		"data":    transaction,
// 	})
// }