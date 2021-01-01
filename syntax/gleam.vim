if polyglot#init#is_disabled(expand('<sfile>:p'), 'gleam', 'syntax/gleam.vim')
  finish
endif

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

let b:current_syntax = "gleam"

" Keywords
syntax keyword gleamKeyword
  \ module import pub external
  \ type let as if else todo const
  \ case assert tuple try opaque
highlight link gleamKeyword Keyword

" Function definition
syntax keyword gleamDef fn nextgroup=gleamFunctionDef skipwhite skipempty
highlight link gleamDef Keyword

syntax match gleamFunctionDef "[a-z_-][0-9a-z_-]*" contained skipwhite skipnl
highlight link gleamFunctionDef Function

" Int
syntax match gleamInt '\<[0-9][0-9_]*\>'
highlight link gleamInt Number

" Float
syntax match gleamFloat '\<[0-9][0-9_]*\.[0-9_]*\>'
highlight link gleamFloat Float

" Operators
syntax match gleamOperator "\([-!#$%`&\*\+./<=>@\\^|~:]\|\<\>\)"
highlight link gleamOperator Operator

" Type
syntax match gleamType "\([a-z]\)\@<![A-Z]\w*"
highlight link gleamType Identifier

" Comments
syntax region gleamCommentLine start="//" end="$" contains=gleamTodo
highlight link gleamCommentLine Comment

syntax keyword gleamTodo contained TODO FIXME XXX NB NOTE
highlight def link gleamTodo Todo

" String
syntax region gleamString start=/"/ end=/"/ contains=gleamStringModifier
syntax match gleamStringModifier '\\.' contained
highlight link gleamString String
highlight link gleamStringModifier Special

" Attribute
syntax match gleamAttribute "#[a-z][a-z_]*"
highlight link gleamAttribute PreProc
