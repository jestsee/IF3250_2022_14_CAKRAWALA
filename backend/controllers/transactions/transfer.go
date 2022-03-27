package transactions

import (
	"log"
	"net/http"

	"cakrawala.id/m/models"
	"cakrawala.id/m/utils"
	"github.com/gin-gonic/gin"
)


type TransferBody struct {
	Amount 		uint64 	`json:"amount"`
	Exp 		uint32 	`json:"exp"`
	Status 		string 	`json:"status"`
	Cashback 	uint32 	`json:"cashback"`
	UserID 		uint 	`json:"user_id"`
	FriendID 	uint 	`json:"friend_id"`
}

func Transfer(c *gin.Context)  {
	user := c.MustGet("user").(models.User)
	var data = new(TransferBody)
	// var sender_phone = "081219083250"
	var receiver_phone = "081219083251"
	var receiver models.User

	if err := c.ShouldBind(data); err != nil {
		c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
		return
	}

	// check receiver's phone
	err := models.DB.Where("phone = ?", receiver_phone).First(&receiver).Error
	if err != nil {
		c.JSON(400, gin.H{
			"message": "no ponsel tidak ada",
		})
		c.Abort()
		return
	}

	// check sender's balance
	if user.Balance < data.Amount {
		c.JSON(400, gin.H{
			"message": "saldo kurang",
		})
		c.Abort()
		return
	}

	user.Balance -= uint64(data.Amount)
	receiver.Balance += uint64(data.Amount)

	models.DB.Updates(&user)
	models.DB.Updates(&receiver)
	




	// bonus := service.TransferBonus(user, int64(data.Amount))
	transaction := models.Transaksi{
		Amount: data.Amount,
		Exp: uint32(10),
		Cashback: uint32(5),
		UserID: data.UserID,
		MerchantID: nil,
		FriendID: &data.UserID,
	}
	log.Println(transaction)

	// err := models.DB.Create(&transaction).Error
	// if err != nil {
	// 	_ = c.AbortWithError(500, err)
	// 	return
	// }

	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil transfer",
	})
}