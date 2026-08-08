package main

import (
	"fmt"

	"example.com/callgraph/app"
)

func main() {
	fmt.Println("booting")
	app.Boot()
	helper()
}

func helper() {
	fmt.Println("helping")
}
