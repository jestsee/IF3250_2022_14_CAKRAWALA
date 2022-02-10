package models

import (
	"fmt"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
	dbUsn := os.Getenv("DBUSN")
	dbPass := os.Getenv("DBPASS")
	dbHost := os.Getenv("DBHOST")
	dbPort := os.Getenv("DBPORT")
	dbName := os.Getenv("DBNAME")

	dbUrl := fmt.Sprintf("postgres://%s:%s@%s:%s/%s",
		dbUsn,
		dbPass,
		dbHost,
		dbPort,
		dbName)

	database, err := gorm.Open(postgres.Open(dbUrl), &gorm.Config{})

	if err != nil {
		fmt.Println(err)
		panic("Failed to connect to database!")
	}

	database.AutoMigrate(&User{}, &Auth{}, &Merchant{}, &Reward{}, &Transaksi{}, &HistoryReward{})

	DB = database
}
