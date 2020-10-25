if has_key(g:polyglot_is_disabled, 'fish')
  finish
endif

setlocal indentexpr=fish#Indent()
setlocal indentkeys+==end,=else,=case
