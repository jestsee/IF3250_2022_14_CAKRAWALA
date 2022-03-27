package transactions

import (
	"net/http"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type AddRewardBody struct {
	Name 	string 	`json:"name"`
	Price 	uint32 	`json:"price"`
	Stock	uint16	`json:"stock"`
}

type ExchangeRewardBody struct {
	RewardID	uint	`json:"reward_id"`
	Quantity	uint16 	`json:"qty"`
	PointsPaid	uint32	`json:"paid"`
}

func AddReward(c *gin.Context) {
	var body AddRewardBody
	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}

	new_reward := models.Reward {
		Name: 	body.Name,
		Price:	body.Price,
		Stock:	body.Stock,
	}

	err := models.DB.Transaction(func(tx *gorm.DB) error {
		if e:= tx.Save(&new_reward).Error; e != nil {
			return e
		}
		return nil
	})

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"message": "berhasil  menambahkan reward",
			"data":    new_reward,
		})
	} else {
		_ = c.AbortWithError(500, err)
	}
}

func ExchangeReward(c *gin.Context) {
	// get user
	user := c.MustGet("user").(models.User)
	var body ExchangeRewardBody
	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}

	// cek point cukup ga
	if user.Point < body.PointsPaid {
		c.AbortWithStatusJSON(400, gin.H{
			"message": "insufficient points",
		})
		return
	}

	reward_history := models.HistoryReward {
		Quantity: 	body.Quantity,
		PointsPaid: body.PointsPaid,
		UserID: 	user.ID,
		RewardID:	body.RewardID,
	}

	// kurangin point user
	user.Point -= body.PointsPaid

	// kurangin stock reward


	err := models.DB.Transaction(func(tx *gorm.DB) error {
		// add row baru di history
		if e:= tx.Save(&reward_history).Error; e != nil {
			return e
		}
		// update point user
		if e:= tx.Updates(&user).Error; e != nil {
			return e
		}
		// update stock reward
		// if e:= tx.Update()
		return nil
	})

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"message": "berhasil  menukarkan point",
			"data":    reward_history,
		})
	} else {
		_ = c.AbortWithError(500, err)
	}

}