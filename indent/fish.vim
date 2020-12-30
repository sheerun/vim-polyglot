if has_key(g:polyglot_is_disabled, 'fish')
  finish
endif

setlocal indentexpr=fish#Indent()
setlocal indentkeys=!^F,o,O
setlocal indentkeys+==end,=else,=case
