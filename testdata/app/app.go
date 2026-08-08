package app

import "fmt"

func Boot() {
	fmt.Println("boot")
	worker()
	s := Server{}
	s.Start()
}

type Server struct {
	name string
}

func (s Server) Start() {
	fmt.Println("start")
	processItem()
}

func (s Server) Name() string {
	return s.name
}
