if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'jenkins') != -1
  finish
endif

runtime indent/groovy.vim
