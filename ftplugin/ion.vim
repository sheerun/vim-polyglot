if has_key(g:polyglot_is_disabled, 'ion')
  finish
endif


if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal commentstring=#%s
