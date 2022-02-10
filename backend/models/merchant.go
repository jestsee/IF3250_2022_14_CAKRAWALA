package models

import "time"

type Merchant struct {
	ID        uint      `gorm:"primary_key;auto_increment" json:"id"`
	Name      string    `gorm: "not_null"`
	Address   string    `gorm: "default:Bandung"`
	AccountId string    `gorm: "default:asdf1234"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`

	Transaksi []Transaksi `gorm:"ForeignKey:MerchantID"`
}
