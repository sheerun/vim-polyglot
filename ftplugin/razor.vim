if !polyglot#util#IsEnabled('razor', expand('<sfile>:p'))
  finish
endif

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" vim:set sw=2:
