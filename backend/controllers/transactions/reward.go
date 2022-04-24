package transactions

import (
	"net/http"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type AddRewardBody struct {
	Name  string `json:"name"`
	Price uint32 `json:"price"`
	Stock int16  `json:"stock"`
	Image string `json:"image"`
}

type ExchangeRewardBody struct {
	RewardID uint  `json:"reward_id"`
	Quantity int16 `json:"qty"`
}

type UpdateStockBody struct {
	Stock int16 `json:"stock"`
}

// AddReward godoc
// @Summary AddReward.
// @Description Add New Reward.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body AddRewardBody true "Inputan yang benar"
// @Success 200 {string} AddReward
// @Router /admin/add-reward [post]
func AddReward(c *gin.Context) {
	var body AddRewardBody
	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}

	new_reward := models.Reward{
		Name:  body.Name,
		Price: body.Price,
		Stock: body.Stock,
		Image: body.Image,
	}

	err := models.DB.Transaction(func(tx *gorm.DB) error {
		if e := tx.Save(&new_reward).Error; e != nil {
			return e
		}
		return nil
	})

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"message": "Successfully added new reward",
			"data":    new_reward,
		})
	} else {
		_ = c.AbortWithError(500, err)
	}
}

// ExchangeReward godoc
// @Summary ExchangeReward.
// @Description Exchange Reward with Points.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body ExchangeRewardBody true "Inputan yang benar"
// @Success 200 {string} ExchangeReward
// @Router /v1/exchange-reward [post]
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
			"message": "Reward id not found",
		})
		c.Abort()
		return
	}

	// cek stok reward cukup ga
	if reward.Stock < body.Quantity {
		c.AbortWithStatusJSON(400, gin.H{
			"message": "Insufficient reward stock",
		})
		return
	}

	// calculate points needed
	var pointsNeeded = body.Quantity * int16(reward.Price)

	// cek point cukup ga
	if user.Point < uint32(pointsNeeded) {
		c.AbortWithStatusJSON(400, gin.H{
			"message": "Insufficient point",
		})
		return
	}

	// kurangin point user
	user.Point -= uint32(pointsNeeded)

	if reward.Stock == 1 {
		println("asdfasdf")
		reward.Stock = 0
	} else {
		reward.Stock -= body.Quantity
	}

	// masukin ke db
	reward_history := models.HistoryReward{
		Quantity:   uint16(body.Quantity),
		PointsPaid: uint32(pointsNeeded), // perhitungan di frontend price * qty
		UserID:     user.ID,
		RewardID:   body.RewardID,
	}
	println(reward.Stock)
	err := models.DB.Transaction(func(tx *gorm.DB) error {
		// add row baru di history
		if e := tx.Create(&reward_history).Error; e != nil {
			return e
		}
		// update point user
		if e := tx.Updates(&user).Error; e != nil {
			return e
		}
		// update stock reward
		if e := tx.Updates(&reward).Error; e != nil {
			return e
		}
		if e := tx.Exec("UPDATE rewards SET stock = ? WHERE id = ?", reward.Stock, reward.ID).Error; e != nil {
			return e
		}
		if e := tx.Exec("UPDATE users SET point = ? WHERE id = ?", user.Point, user.ID).Error; e != nil {
			return e
		}
		return nil
	})

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"message":       "Successfully redeemed point",
			"data":          reward_history,
			"current_point": user.Point,
		})
	} else {
		_ = c.AbortWithError(500, err)
	}
}

// GetAllRewards godoc
// @Summary GetAllRewards.
// @Description Show All Rewards for User.
// @Tags authentication
// @Accept */*
// @Produce json
// @Success 200 {string} GetAllRewards
// @Router /v1/get-rewards [get]
func GetAllRewards(c *gin.Context) {
	var rewards []models.Reward
	err := models.DB.Find(&rewards).Error

	if err != nil {
		c.AbortWithError(500, err)
		return
	}

	data := rewards
	c.JSON(http.StatusOK, gin.H{
		"message": "Get all rewards",
		"data":    data,
	})
}

func UpdateStock(c *gin.Context) {
	var body UpdateStockBody
	var data models.Reward
	if err := c.BindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Failed to binding",
		})
		return
	}
	if err := models.DB.Where("id = ?", c.Param("id")).First(&data).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"message": "Reward not found",
		})
		return
	}

	data.Stock = body.Stock
	err := models.DB.Transaction(func(tx *gorm.DB) error {
		if e := tx.Updates(&data).Error; e != nil {
			return e
		}
		return nil
	})

	if err != nil {
		c.AbortWithError(500, err)
	} else {
		c.JSON(200, gin.H{
			"message": "Successfully updated reward",
			"data":    data,
		})
	}
}
