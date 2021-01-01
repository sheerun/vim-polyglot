if polyglot#init#is_disabled(expand('<sfile>:p'), 'haskell', 'after/ftplugin/cabal.vim')
  finish
endif

setlocal comments=s1fl:{-,mb:-,ex:-},:--
setlocal iskeyword+=-,.,*
setlocal commentstring=--\ %s
