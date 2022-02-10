package models

import "time"

type Transaksi struct {
	ID        uint      `gorm:"primary_key;auto_increment" json:"id"`
	amount    uint64    `gorm: "not_null"`
	exp       uint32    `gorm:"default:0"`
	status    string    `gorm:"default:completed"`
	cashback  uint32    `gorm:"default:0"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`

	UserID uint `gorm:"column:user_id"`
	User   User

	MerchantID *uint `gorm:"column:merchant_id"`
	Merchant   *Merchant

	FriendID *uint `gorm:"column:friend_id"`
	Friend   *User
}
