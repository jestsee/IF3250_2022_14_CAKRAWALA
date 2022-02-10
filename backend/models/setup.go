package models

import (
	"fmt"
	"net/url"
	"os"

	"github.com/jinzhu/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
	dbUsn := os.Getenv("DBUSN")
	dbPass := os.Getenv("DBPASS")
	dbHost := os.Getenv("DBHOST")
	dbPort := os.Getenv("DBPORT")
	dbName := os.Getenv("DBNAME")

	dbdata := url.URL{
		User:   url.UserPassword(dbUsn, dbPass),
		Scheme: "postgres",
		Host:   fmt.Sprintf("%s:%d", dbHost, dbPort),
		Path:   dbName,
		RawQuery: (&url.Values{
			"sslmode":  []string{"disable"},
			"TimeZone": []string{"Asia/Jakarta"},
		}).Encode(),
	}
	database, err := gorm.Open("postgres", dbdata.String())

	if err != nil {
		panic("Failed to connect to database!")
	}

	//database.AutoMigrate(&Book{})

	DB = database
}
