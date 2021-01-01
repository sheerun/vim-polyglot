if polyglot#init#is_disabled(expand('<sfile>:p'), 'jsonc', 'syntax/jsonc.vim')
  finish
endif

" Syntax setup {{{1
if exists('b:current_syntax') && b:current_syntax == 'jsonc'
  finish
endif

" Syntax: Strings {{{1
syn region  jsoncString    start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=jsoncEscape
syn region  jsoncString    start=+'+  skip=+\\\\\|\\'+  end=+'+  contains=jsoncEscape

" Syntax: JSON Keywords {{{1
" Separated into a match and region because a region by itself is always greedy
syn match  jsoncKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonKeyword

" Syntax: Escape sequences
syn match   jsoncEscape    "\\["\\/bfnrt]" contained
syn match   jsoncEscape    "\\u\x\{4}" contained

" Syntax: Numbers {{{1
syn match   jsoncNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
syn keyword jsoncNumber    Infinity -Infinity

" Syntax: An integer part of 0 followed by other digits is not allowed.
syn match   jsoncNumError  "-\=\<0\d\.\d*\>"

" Syntax: Boolean {{{1
syn keyword jsoncBoolean   true false

" Syntax: Null {{{1
syn keyword jsoncNull      null

" Syntax: Braces {{{1
syn match   jsoncBraces	   "[{}\[\]]"
syn match   jsoncObjAssign /@\?\%(\I\|\$\)\%(\i\|\$\)*\s*\ze::\@!/

" Syntax: Comment {{{1
syn region  jsoncLineComment    start=+\/\/+ end=+$+ keepend
syn region  jsoncLineComment    start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ keepend fold
syn region  jsoncComment        start="/\*"  end="\*/" fold

" Define the default highlighting. {{{1
hi def link jsoncString             String
hi def link jsoncObjAssign          Identifier
hi def link jsoncEscape             Special
hi def link jsoncNumber             Number
hi def link jsoncBraces             Operator
hi def link jsoncNull               Function
hi def link jsoncBoolean            Boolean
hi def link jsoncLineComment        Comment
hi def link jsoncComment            Comment
hi def link jsoncNumError           Error
hi def link jsoncKeywordMatch       Label

if !exists('b:current_syntax')
  let b:current_syntax = 'jsonc'
endif

" vim: fdm=marker
