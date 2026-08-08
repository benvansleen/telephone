package app

import "fmt"

type Handler struct {
	db *DB
}

func (h *Handler) Run() {
	fmt.Println(h.db.Query())
}

func (h *Handler) Stop() {
	h.db.Close()
}
