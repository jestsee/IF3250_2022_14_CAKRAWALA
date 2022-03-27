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

// func RewardController(c *gin.Context) {
// 	// get user
// 	user := c.MustGet("user").(models.User)
// 	var body AddRewardBody
// 	if err := c.BindJSON(&body); err != nil {
// 		c.AbortWithError(400, err)
// 		return
// 	}

// 	// cek point cukup ga
// 	if user.Point < body.Point {
// 		c.AbortWithStatusJSON(400, gin.H{
// 			"message": "insufficient points",
// 		})
// 		return
// 	}

// 	reward := models.Reward {
// 		Name: 	body.Name,
// 		Price:	body.Point,
// 		Stock:	body.Stock,
// 	}

// 	user.Point -= body.Point
// 	println(user.Point)
// 	err := models.DB.Transaction(func(tx *gorm.DB) error {
// 		if e:= tx.Save(&reward).Error; e != nil {
// 			return e
// 		}
// 		if e:= tx.Updates(&user).Error; e != nil {
// 			return e
// 		}
// 		return nil
// 	})

// 	if err == nil {
// 		c.JSON(http.StatusOK, gin.H{
// 			"message": "berhasil  menukarkan point",
// 			"data":    reward,
// 		})
// 	} else {
// 		_ = c.AbortWithError(500, err)
// 	}

// }