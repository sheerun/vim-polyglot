if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'json5') == -1
  
" Syntax setup {{{1
if exists('b:current_syntax') && b:current_syntax == 'json5'
  finish
endif

" Syntax: Strings {{{1
syn region  json5String    start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=json5Escape
syn region  json5String    start=+'+  skip=+\\\\\|\\'+  end=+'+  contains=json5Escape

" Syntax: Escape sequences
syn match   json5Escape    "\\["\\/bfnrt]" contained
syn match   json5Escape    "\\u\x\{4}" contained

" Syntax: Numbers {{{1
syn match   json5Number    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
syn keyword json5Number    Infinity -Infinity

" Syntax: An integer part of 0 followed by other digits is not allowed.
syn match   json5NumError  "-\=\<0\d\.\d*\>"

" Syntax: Boolean {{{1
syn keyword json5Boolean   true false

" Syntax: Null {{{1
syn keyword json5Null      null

" Syntax: Braces {{{1
syn match   json5Braces	   "[{}\[\]]"
syn match   json5ObjAssign /@\?\%(\I\|\$\)\%(\i\|\$\)*\s*\ze::\@!/

" Syntax: Comment {{{1
syn region  json5LineComment    start=+\/\/+ end=+$+ keepend
syn region  json5LineComment    start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ keepend fold
syn region  json5Comment        start="/\*"  end="\*/" fold

" Define the default highlighting. {{{1
hi def link json5String             String
hi def link json5ObjAssign          Identifier
hi def link json5Escape             Special
hi def link json5Number             Number
hi def link json5Braces             Operator
hi def link json5Null               Function
hi def link json5Boolean            Boolean
hi def link json5LineComment        Comment
hi def link json5Comment            Comment
hi def link json5NumError           Error

if !exists('b:current_syntax')
  let b:current_syntax = 'json5'
endif

" vim: fdm=marker

endif
