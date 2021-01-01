if polyglot#init#is_disabled(expand('<sfile>:p'), 'jsx', 'after/ftplugin/javascript-2.vim')
  finish
endif

if get(g:, 'vim_jsx_pretty_disable_js', 0)
  finish
endif

source <sfile>:h/jsx.vim
