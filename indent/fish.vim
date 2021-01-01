if polyglot#init#is_disabled(expand('<sfile>:p'), 'fish', 'indent/fish.vim')
  finish
endif

setlocal indentexpr=fish#Indent()
setlocal indentkeys=!^F,o,O
setlocal indentkeys+==end,=else,=case
