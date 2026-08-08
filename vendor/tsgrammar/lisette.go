package tsgrammar

// #cgo CFLAGS: -std=c11 -fPIC
// #include "src/lisette_parser.c"
// #include "src/lisette_scanner.c"
import "C"

import "unsafe"

func LisetteLanguage() unsafe.Pointer {
	return unsafe.Pointer(C.tree_sitter_lisette())
}
