if !polyglot#util#IsEnabled('velocity', expand('<sfile>:p'))
  finish
endif

if exists("b:did_indent")
    finish
endif

runtime! indent/html.vim
