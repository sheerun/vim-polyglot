if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'vm') != -1
  finish
endif

if exists("b:did_indent")
    finish
endif

runtime! indent/html.vim
