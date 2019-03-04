if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'coffee-script') != -1
  finish
endif

runtime ftplugin/coffee.vim
