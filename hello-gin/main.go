package main

import "gopkg.in/gin-gonic/gin.v1"

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.String(200, "Hello Gin World")
	})
	r.Run("localhost:3002")
}
