if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elm') == -1
  
" Vim syntax file
" Language: Elm (http://elm-lang.org/)
" Maintainer: Alexander Noriega
" Latest Revision: 19 April 2015

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword elmKeyword alias as case else exposing if import in let module of port then type where

" Builtin operators
syn match elmBuiltinOp "\~"
syn match elmBuiltinOp "||"
syn match elmBuiltinOp "|>"
syn match elmBuiltinOp "|"
syn match elmBuiltinOp "`"
syn match elmBuiltinOp "\^"
syn match elmBuiltinOp "\\"
syn match elmBuiltinOp ">>"
syn match elmBuiltinOp ">="
syn match elmBuiltinOp ">"
syn match elmBuiltinOp "=="
syn match elmBuiltinOp "="
syn match elmBuiltinOp "<\~"
syn match elmBuiltinOp "<|"
syn match elmBuiltinOp "<="
syn match elmBuiltinOp "<<"
syn match elmBuiltinOp "<-"
syn match elmBuiltinOp "<"
syn match elmBuiltinOp "::"
syn match elmBuiltinOp ":"
syn match elmBuiltinOp "/="
syn match elmBuiltinOp "//"
syn match elmBuiltinOp "/"
syn match elmBuiltinOp "\.\."
syn match elmBuiltinOp "\."
syn match elmBuiltinOp "->"
syn match elmBuiltinOp "-"
syn match elmBuiltinOp "++"
syn match elmBuiltinOp "+"
syn match elmBuiltinOp "*"
syn match elmBuiltinOp "&&"
syn match elmBuiltinOp "%"

" Special names
syntax match specialName "^main "

" Comments
syn match elmTodo "[tT][oO][dD][oO]\|FIXME\|XXX" contained
syn match elmLineComment "--.*" contains=elmTodo,@spell
syn region elmComment matchgroup=elmComment start="{-|\=" end="-}" contains=elmTodo,elmComment,@spell

" String literals
syn region elmString start="\"" skip="\\\"" end="\"" contains=elmStringEscape
syn match elmStringEscape "\\u[0-9a-fA-F]\{4}" contained
syn match elmStringEscape "\\[nrfvbt\\\"]" contained

" Number literals
syn match elmNumber "\(\<\d\+\>\)"
syn match elmNumber "\(\<\d\+\.\d\+\>\)"

" Types
syn match elmType "\<[A-Z][0-9A-Za-z_'-]*"

let b:current_syntax = "elm"

hi def link elmKeyword            Keyword
hi def link elmBuiltinOp          Special
hi def link elmType               Type
hi def link elmTodo               Todo
hi def link elmLineComment        Comment
hi def link elmComment            Comment
hi def link elmString             String
hi def link elmNumber             Number
hi def link specialName           Special

endif
