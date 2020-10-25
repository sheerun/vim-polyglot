if !polyglot#util#IsEnabled('jsx', expand('<sfile>:p'))
  finish
endif

if get(g:, 'vim_jsx_pretty_disable_js', 0)
  finish
endif

source <sfile>:h/jsx.vim
