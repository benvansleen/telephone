package tsshim

import tree_sitter "github.com/tree-sitter/go-tree-sitter"

func NewEmptyTree() *tree_sitter.Tree {
	return &tree_sitter.Tree{}
}
