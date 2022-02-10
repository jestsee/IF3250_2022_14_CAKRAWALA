package models

import (
	"time"
)

type Reward struct {
	ID        uint      `gorm:"primary_key;auto_increment" json:"id"`
	name      string    `gorm: "not_null"`
	price     uint32    `gorm: "not_null"`
	stock     uint16    `gorm: "not_null"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`

	Claims []HistoryReward `gorm:"ForeignKey:RewardID"`
}
