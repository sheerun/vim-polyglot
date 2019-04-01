" Vim syntax file
" Language:		Portugol
" Maintainer:		Jeovane Santos <JunioJsv@gmail.com>
" URL:			https://github.com/JunioJsv/portugol-vim-syntax
" Release Coordinator:	Jeovane Santos <JunioJsv@gmail.com>
" ----------------------------------------------------------------------------

if exists("b:current_syntax")
  finish
endif

syn match portugolCommentKey "^\s*\*\s*\zs@\w*\ze\s" 
syn match portugolComment "//.*$" containedin=portugolMathOperator contained
syn region portugolComment start="\/\*" end="\*\/" contains=portugolCommentKey containedin=portugolMathOperator contained

syn keyword portugolKeyword programa funcao retorne const se senao enquanto para
syn keyword portugolInclude inclua biblioteca
syn keyword portugolType inteiro real caracter cadeia logico vetor 
syn keyword portugolBoolean falso verdadeiro
syn keyword portugolOperator e ou nao
syn match portugolMathOperator "=\|!=\|<\|>\|*\|-\|+\|/\|%"
syn match portugolNumber "\<\-\?\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lLst]\=\>"
syn match portugolNumber "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match portugolNumber "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match portugolNumber "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"
syn region portugolString start='"' end='"'
syn keyword portugolEscrevaLeia escreva leia

hi def link portugolComment Comment
hi def link portugolKeyword Keyword
hi def link portugolInclude Include
hi def link portugolType Type
hi def link portugolBoolean Boolean
hi def link portugolOperator Operator
hi def link portugolMathOperator Operator
hi def link portugolNumber Number
hi def link portugolString String
hi portugolEscrevaLeia guifg=Orange gui=italic

let b:current_syntax = "portugol"
