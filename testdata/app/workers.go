package app

import "fmt"

func worker() {
	fmt.Println("work")
}

func processItem() {
	worker()
}

func fetch() string {
	return "data"
}

func shutdown() {
	fmt.Println("bye")
}
