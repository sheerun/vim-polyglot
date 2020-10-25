if !polyglot#util#IsEnabled('jenkins', expand('<sfile>:p'))
  finish
endif

runtime indent/groovy.vim
