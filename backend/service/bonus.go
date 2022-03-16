package service

import (
	"cakrawala.id/m/models"
)

func TopUpBonusService(userData models.User, topUpAmount int64) int {
	initBonus := int(topUpAmount / 5000)
	return initBonus + (GetUserLevelService(userData) * 2)
}

func GetUserLevelService(userData models.User) int {
	if userData.Exp > 2500 {
		return 6
	} else if userData.Exp > 1800 {
		return 5
	} else if userData.Exp > 1000 {
		return 4
	} else if userData.Exp > 600 {
		return 3
	} else if userData.Exp > 300 {
		return 2
	} else if userData.Exp > 90 {
		return 1
	} else {
		return 0
	}
}

func TransferBonus() {

}

func PaymentBonusService(userData models.User, paymentAmount uint64) int {
	initBonus := int(paymentAmount / 10000)
	return initBonus + (GetUserLevelService(userData) * 2)
}
