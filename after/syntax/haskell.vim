if polyglot#init#is_disabled(expand('<sfile>:p'), 'dhall', 'after/syntax/haskell.vim')
  finish
endif

" store and remove current syntax value
let old_syntax = b:current_syntax
unlet b:current_syntax

syn include @dhall syntax/dhall.vim
unlet b:current_syntax

syn region dhallBlock matchgroup=quasiQuote start=/\[\$\?staticDhallExpression|/       end=/|\]/ contains=@dhall

hi def link quasiQuote Underlined

" restore current syntax value
let b:current_syntax = old_syntax
