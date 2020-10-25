if has_key(g:polyglot_is_disabled, 'jsx')
  finish
endif

if get(g:, 'vim_jsx_pretty_disable_js', 0)
  finish
endif

source <sfile>:h/jsx.vim
