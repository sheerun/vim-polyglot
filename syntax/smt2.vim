if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'smt2') == -1

" Vim syntax file
" " Language:     SMT-LIB2 with Z3's extensions
" " Maintainer:   Dimitri Bohlender <bohlender@embedded.rwth-aachen.de>

" Quit if a syntax file is already loaded
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "smt2"

" Comments
syntax match smt2Comment ";.*$"

" Keywords
syntax keyword smt2Keyword
      \ apply
      \ as
      \ assert
      \ assert
      \ assert-soft
      \ check-sat
      \ check-sat-using
      \ declare-const
      \ declare-datatype
      \ declare-datatypes
      \ declare-fun
      \ declare-map
      \ declare-rel
      \ declare-sort
      \ declare-var
      \ define-const
      \ define-fun
      \ define-sort
      \ display
      \ echo
      \ elim-quantifiers
      \ eval
      \ exists
      \ exit
      \ forall
      \ get-assignment
      \ get-info
      \ get-model
      \ get-option
      \ get-proof
      \ get-unsat-core
      \ get-user-tactics
      \ get-value
      \ help
      \ let
      \ match
      \ maximize
      \ minimize
      \ pop
      \ push
      \ query
      \ reset
      \ rule
      \ set-info
      \ set-logic
      \ set-option
      \ simplify
syntax match smt2Keyword "!"

" Operators
syntax match smt2Operator "[=\|>\|<\|<=\|>=\|=>\|+\|\-\|*\|/]"

" Builtins
syntax keyword smt2Builtin
      \ and
      \ bit0
      \ bit1
      \ bvadd
      \ bvand
      \ bvashr
      \ bvcomp
      \ bvlshr
      \ bvmul
      \ bvnand
      \ bvneg
      \ bvnor
      \ bvnot
      \ bvor
      \ bvredand
      \ bvredor
      \ bvsdiv
      \ bvsge
      \ bvsgt
      \ bvshl
      \ bvsle
      \ bvslt
      \ bvsmod
      \ bvsrem
      \ bvsub
      \ bvudiv
      \ bvuge
      \ bvugt
      \ bvule
      \ bvult
      \ bvurem
      \ bvxnor
      \ bvxor
      \ concat
      \ const
      \ distinct
      \ div
      \ extract
      \ false
      \ get-assertions
      \ if
      \ is_int
      \ ite
      \ map
      \ mod
      \ not
      \ or
      \ rem
      \ repeat
      \ root-obj
      \ rotate_left
      \ rotate_right
      \ sat
      \ sat
      \ select
      \ sign_extend
      \ store
      \ to_int
      \ to_real
      \ true
      \ unsat
      \ unsat
      \ xor
      \ zero_extend
syntax match smt2Builtin "[\^\~]"

" Identifier
syntax match smt2Identifier "\<[a-z_][a-zA-Z0-9_\-\.']*\>"

" Types
syntax match smt2Type "\<[A-Z][a-zA-Z0-9_\-\.']*\>"

" Strings
syntax region smt2String start=+"+ skip=+\\\\\|\\"+ end=+"+
syntax match smt2Option "\<:[a-zA-Z0-9_\-\.']*\>"

" Constructors
syntax match smt2Constructor "\<\$[a-zA-Z0-9_\-\.']*\>"

" Number
syntax match smt2Int "\<[0-9]\+\>"
syntax match smt2Hex "\<[0#][xX][0-9a-fA-F]\+\>"
syntax match smt2Binary "\<#b[01]\+\>"
syntax match smt2Float "\<[0-9]\+\.[0-9]\+\([eE][\-+]\=[0-9]\+\)\=\>"

" Delimiter
syntax match smt2Delimiter "[()]"

" Error
syntax keyword smt2Error error

highlight def link smt2Comment     Comment
highlight def link smt2Keyword     Function
highlight def link smt2Operator    Operator
highlight def link smt2Builtin     Operator
highlight def link smt2Identifier  Normal
highlight def link smt2Type        Type
highlight def link smt2String      String
highlight def link smt2Option      PreProc
highlight def link smt2Constructor Function
highlight def link smt2Float       Float
highlight def link smt2Hex         Number
highlight def link smt2Binary      Number
highlight def link smt2Int         Number
highlight def link smt2Delimiter   Delimiter
highlight def link smt2Error       Error

endif
