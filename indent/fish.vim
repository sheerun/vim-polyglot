if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'fish') != -1
  finish
endif

setlocal indentexpr=fish#Indent()
setlocal indentkeys+==end,=else,=case
