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

	// get reward as struct
	var reward models.Reward
	err0 := models.DB.Where("id = ?", body.RewardID).First(&reward).Error
	if err0 != nil {
		c.JSON(400, gin.H{
			"message": "id reward tidak ditemukan",
		})
		c.Abort()
		return
	}

	// cek stok reward cukup ga
	if reward.Stock < body.Quantity {
		c.AbortWithStatusJSON(400, gin.H{
			"message": "stok tidak mencukupi",
		})
		return
	}

	// calculate points needed
	var pointsNeeded = body.Quantity * uint16(reward.Price)

	// cek point cukup ga
	if user.Point < uint32(pointsNeeded) {
		c.AbortWithStatusJSON(400, gin.H{
			"message": "point tidak mencukupi",
		})
		return
	}
	
	// kurangin point user
	user.Point -= uint32(pointsNeeded)

	// kurangin stock reward
	reward.Stock -= body.Quantity

	// masukin ke db
	reward_history := models.HistoryReward {
		Quantity: 	body.Quantity,
		PointsPaid: uint32(pointsNeeded), // perhitungan di frontend price * qty
		UserID: 	user.ID,
		RewardID:	body.RewardID,
	}

	err := models.DB.Transaction(func(tx *gorm.DB) error {
		// add row baru di history
		if e:= tx.Create(&reward_history).Error; e != nil {
			return e
		}
		// update point user
		if e:= tx.Updates(&user).Error; e != nil {
			return e
		}
		// update stock reward
		if e:= tx.Updates(&reward).Error; e != nil {
			return e
		}
		return nil
	})

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"message"		:	"berhasil  menukarkan point",
			"data"			:    reward_history,
			"current_point"	:	user.Point,	
		})
	} else {
		_ = c.AbortWithError(500, err)
	}
}