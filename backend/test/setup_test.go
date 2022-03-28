package test

import (
	"bytes"
	"cakrawala.id/m/controllers"
	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/suite"
	"gorm.io/gorm"
	"net/http"
	"testing"
)

type TestSuiteEnv struct {
	suite.Suite
	db *gorm.DB
}

// Tests are run before they start
func (suite *TestSuiteEnv) SetupSuite() {
	models.ConnectDatabase()
	suite.db = models.DB
}

// Running after each test
func (suite *TestSuiteEnv) TearDownTest() {
	models.ClearTable()
}

// Running after all tests are completed
func (suite *TestSuiteEnv) TearDownSuite() {
	//suite.db.Close()
}

// This gets run automatically by `go test` so we call `suite.Run` inside it
func TestSuite(t *testing.T) {
	// This is what actually runs our suite
	suite.Run(t, new(TestSuiteEnv))
}

func (suite *TestSuiteEnv) TestLoginRegister() {
	r := gin.New()
	r.POST("/register", controllers.Register)
	var jstr = []byte(`{
    "email" : "13519002@std.stei.itb.ac.id",
    "name" : "robert alfonsius",
    "phone" : "085257560828",
    "password" : "asdf12345"
	}`)
	req, err := http.NewRequest(http.MethodPost, "/register", bytes.NewBuffer(jstr))
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	a := suite.Assert()
	a.Equal(resp.StatusCode, 200)

	req, err = http.NewRequest(http.MethodPost, "/register", bytes.NewBuffer(jstr))
	req.Header.Set("Content-Type", "application/json")

	resp, err = client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	a.Equal(resp.StatusCode, 400)

}

func (suite *TestSuiteEnv) TestMiddleware() {
	r := gin.New()
	r.POST("/register", controllers.Register)
	var jstr = []byte(`{
    "email" : "13519002@std.stei.itb.ac.id",
    "name" : "robert alfonsius",
    "phone" : "085257560828",
    "password" : "asdf12345"
	}`)
	req, err := http.NewRequest(http.MethodPost, "/register", bytes.NewBuffer(jstr))
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	a := suite.Assert()
	a.Equal(resp.StatusCode, 200)

	req, err = http.NewRequest(http.MethodPost, "/register", bytes.NewBuffer(jstr))
	req.Header.Set("Content-Type", "application/json")

	resp, err = client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	a.Equal(resp.StatusCode, 400)
}
