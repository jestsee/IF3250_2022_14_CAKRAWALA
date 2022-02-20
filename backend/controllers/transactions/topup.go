package transactions

import (
	"cakrawala.id/m/models"
	"cakrawala.id/m/service"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"net/http"
)

type TopUpBody struct {
	Amount uint64 `json:"amount"`
}

func TopUpRequest(c *gin.Context) {
	user := c.MustGet("user").(models.User)
	body := TopUpBody{}
	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}
	bonus := service.TopUpBonusService(user, int64(body.Amount))
	transaksi := models.Transaksi{
		Amount:     body.Amount,
		Exp:        uint32(bonus),
		Cashback:   0,
		UserID:     user.ID,
		MerchantID: nil,
		FriendID:   nil,
		Status:     "pending",
	}
	e := models.DB.Create(&transaksi)
	if e != nil {
		c.AbortWithStatus(500)
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil request topup",
		"data":    transaksi,
	})

}

func ApproveTopUp(c *gin.Context) {
	//Cek apakah ada topup dengan id itu
	var transaksi models.Transaksi
	e := models.DB.Preload("User").Where("id = ?", c.Param("id")).First(&transaksi).Error
	if e != nil {
		c.AbortWithError(500, e)
		return
	}
	//Ubah Status
	transaksi.Status = "completed"
	//Jika di terima maka masukkan saldo ke user
	transaksi.User.Balance += transaksi.Amount
	transaksi.User.Exp += transaksi.Exp
	transaksi.User.Point += transaksi.Exp

	err := models.DB.Transaction(func(tx *gorm.DB) error {
		if e := tx.Updates(&transaksi).Error; e != nil {
			return e
		}
		if e := tx.Updates(&transaksi.User).Error; e != nil {
			return e
		}
		return nil
	})

	if err != nil {
		c.AbortWithError(500, e)
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Berhasil accept saldo",
		"data":    transaksi,
	})
}

func GetTopUpRequest(c *gin.Context) {
	var topupReq []models.Transaksi
	err := models.DB.Where("merchant_id IS NULL AND friend_id IS NULL AND status != 'completed'").Find(&topupReq).Error
	if err != nil {
		c.AbortWithError(500, err)
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil get top up requests",
		"data":    topupReq,
	})
}
