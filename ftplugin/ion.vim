if !polyglot#util#IsEnabled('ion', expand('<sfile>:p'))
  finish
endif


if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal commentstring=#%s
