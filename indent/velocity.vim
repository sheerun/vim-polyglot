if polyglot#init#is_disabled(expand('<sfile>:p'), 'velocity', 'indent/velocity.vim')
  finish
endif

if exists("b:did_indent")
    finish
endif

runtime! indent/html.vim
