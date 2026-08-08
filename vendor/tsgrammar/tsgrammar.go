package tsgrammar

// #cgo CFLAGS: -std=c11 -fPIC
// #include "src/parser.c"
// #if __has_include("src/scanner.c")
// #include "src/scanner.c"
// #endif
import "C"

import "unsafe"

func GoLanguage() unsafe.Pointer {
	return unsafe.Pointer(C.tree_sitter_go())
}
