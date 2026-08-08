module telephone

go 1.25

require (
	github.com/ivov/lisette/prelude v0.11.1
	github.com/telephone/ts-shim v0.0.0
	github.com/telephone/tsgrammar v0.0.0
	github.com/tree-sitter/go-tree-sitter v0.25.0
)

require github.com/mattn/go-pointer v0.0.1 // indirect

replace github.com/telephone/ts-shim => /home/ben/Code/telephone/vendor/ts-shim

replace github.com/telephone/tsgrammar => /home/ben/Code/telephone/vendor/tsgrammar
