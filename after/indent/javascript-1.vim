if !exists('g:polyglot_disabled') || (index(g:polyglot_disabled, 'javascript') == -1 && index(g:polyglot_disabled, 'jsx') == -1)

if get(g:, 'vim_jsx_pretty_disable_js', 0)
  finish
endif

source <sfile>:h/jsx.vim

endif
