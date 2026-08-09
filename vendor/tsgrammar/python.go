package tsgrammar

// #cgo CFLAGS: -std=c11 -fPIC
// #include "src/python_parser.c"
// #include "src/python_scanner.c"
import "C"

import "unsafe"

func PythonLanguage() unsafe.Pointer {
	return unsafe.Pointer(C.tree_sitter_python())
}
