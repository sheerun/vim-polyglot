if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1
  
" Language:    ember-script
" Maintainer:  heartsentwined <heartsentwined@cogito-lab.com>
" URL:         http://github.com/heartsentwined/vim-ember-script
" Version:     1.0.1
" Last Change: 2013 Apr 17
" License:     GPL-3.0

if exists('b:did_indent')
  finish
endif

runtime! indent/coffee.vim
unlet! b:did_indent
let b:did_indent = 1

endif
