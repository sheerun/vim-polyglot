if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fish') == -1

setlocal indentexpr=fish#Indent()
setlocal indentkeys+==end,=else,=case

endif
