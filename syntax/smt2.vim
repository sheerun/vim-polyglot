if polyglot#init#is_disabled(expand('<sfile>:p'), 'smt2', 'syntax/smt2.vim')
  finish
endif

" Vim syntax file
" " Language:     SMT-LIB2 with Z3's extensions
" " Maintainer:   Dimitri Bohlender <bohlender@embedded.rwth-aachen.de>

" Quit if a syntax file is already loaded
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "smt2"

" Comments
syntax match smt2Comment "\m\C;.*$"

" Commands
syntax keyword smt2Commands
      \ apply
      \ assert
      \ assert-soft
      \ check-sat
      \ check-sat-assuming
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
      \ define-fun-rec
      \ define-funs-rec
      \ define-sort
      \ display
      \ echo
      \ elim-quantifiers
      \ eval
      \ exit
      \ get-assertions
      \ get-assignment
      \ get-info
      \ get-model
      \ get-option
      \ get-proof
      \ get-unsat-assumptions
      \ get-unsat-core
      \ get-user-tactics
      \ get-value
      \ help
      \ maximize
      \ minimize
      \ pop
      \ push
      \ query
      \ reset
      \ reset-assertions
      \ rule
      \ set-info
      \ set-logic
      \ set-option
      \ simplify
syntax match smt2Commands "\m\C!"

" Operators
syntax match smt2Operator "\m\C[=\|>\|<\|<=\|>=\|=>\|+\|\-\|*\|/\|!]"

" Builtins
syntax keyword smt2Builtin
      \ and
      \ as
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
      \ exists
      \ extract
      \ false
      \ forall
      \ if
      \ is_int
      \ ite
      \ let
      \ map
      \ match
      \ mod
      \ not
      \ or
      \ par
      \ rem
      \ repeat
      \ root-obj
      \ rotate_left
      \ rotate_right
      \ sat
      \ select
      \ sign_extend
      \ store
      \ to_int
      \ to_real
      \ true
      \ unsat
      \ xor
      \ zero_extend
syntax match smt2Builtin "\m\C[\^\~]"

" Identifier
syntax match smt2Identifier "\m\C\<[a-z_][a-zA-Z0-9_\-\.']*\>"

" Types
syntax match smt2Type "\m\C\<[A-Z][a-zA-Z0-9_\-\.']*\>"

" Strings
syntax region smt2String start=+"+ skip=+\\\\\|\\"+ end=+"+
syntax match smt2Option "\m\C\<:[a-zA-Z0-9_\-\.']*\>"

" Constructors
syntax match smt2Constructor "\m\C\<\$[a-zA-Z0-9_\-\.']*\>"

" Number
syntax match smt2Int "\m\C\<[0-9]\+\>"
syntax match smt2Hex "\m\C\<[0#][xX][0-9a-fA-F]\+\>"
syntax match smt2Binary "\m\C\<#b[01]\+\>"
syntax match smt2Float "\m\C\<[0-9]\+\.[0-9]\+\([eE][\-+]\=[0-9]\+\)\=\>"

" Delimiter
syntax match smt2Delimiter "\m\C[()]"

" Error
syntax keyword smt2Error error

highlight def link smt2Comment     Comment
highlight def link smt2Commands    Function
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
