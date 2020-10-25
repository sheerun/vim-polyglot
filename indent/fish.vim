if !polyglot#util#IsEnabled('fish', expand('<sfile>:p'))
  finish
endif

setlocal indentexpr=fish#Indent()
setlocal indentkeys+==end,=else,=case
