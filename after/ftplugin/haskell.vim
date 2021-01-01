if polyglot#init#is_disabled(expand('<sfile>:p'), 'haskell', 'after/ftplugin/haskell.vim')
  finish
endif

setlocal comments=s1fl:{-,mb:\ \ ,ex:-},:--
setlocal iskeyword+='
