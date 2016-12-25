package main

import "github.com/kataras/iris"

func main() {
	iris.Get("/", func(ctx *iris.Context) {
		ctx.Text(iris.StatusOK, "Hello Iris World")
	})

	iris.Listen("localhost:3003")
}
