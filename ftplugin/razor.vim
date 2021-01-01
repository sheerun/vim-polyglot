if polyglot#init#is_disabled(expand('<sfile>:p'), 'razor', 'ftplugin/razor.vim')
  finish
endif

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" vim:set sw=2:
