package transactions

import (
	"net/http"

	"cakrawala.id/m/utils"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
)

type AddMerchantBody struct {
	Name      string `json:"name"`
	Address   string `json:"address"`
	AccountId string `json:"account_id"`
}

func AddMerchant(c *gin.Context) {
	var data AddMerchantBody

	if err := c.ShouldBindJSON(&data); err != nil {
		c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
		return
	}

	var merchant models.Merchant

	err := models.DB.Where("account_id = ?", data.AccountId).First(&merchant).Error
	if err == nil {
		c.JSON(400, gin.H{
			"message": "account id sudah pernah dipakai",
		})
		c.Abort()
		return
	}

	merchant_add := models.Merchant{
		Name:      data.Name,
		Address:   data.Address,
		AccountId: data.AccountId,
	}

	er := models.DB.Create(&merchant_add).Error
	if er != nil {
		_ = c.AbortWithError(500, er)
		return
	}
}
