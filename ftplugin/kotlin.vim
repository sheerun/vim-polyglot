if polyglot#init#is_disabled(expand('<sfile>:p'), 'kotlin', 'ftplugin/kotlin.vim')
  finish
endif

if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1

setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s
