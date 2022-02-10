package models

import "time"

type User struct {
	ID        uint            `gorm:"primary_key;auto_increment" json:"id"`
	Email     string          `gorm: "not_null;unique" json:"email"`
	Password  string          `gorm: "not_null" json:"-"`
	Name      string          `gorm: "not_null"  json:"name"`
	Phone     string          `gorm: "not_null"  json:"phone"`
	Balance   uint64          `gorm:"default:0"  json:"balance"`
	Admin     bool            `gorm:"default:false"  json:"-"`
	Point     uint32          `gorm:"default:0"  json:"point"`
	Exp       uint32          `gorm:"default:0"  json:"exp"`
	CreatedAt time.Time       `json:"createdAt"`
	UpdatedAt time.Time       `json:"updatedAt"`
	Token     []Auth          `gorm:"ForeignKey:UserID"`
	Transaksi []Transaksi     `gorm:"ForeignKey:UserID"`
	Reward    []HistoryReward `gorm:"ForeignKey:UserID"`
}
