if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1

" Language:    ember-script
" Maintainer:  Yulij Andreevich Lesov <yalesov@gmail.com>>
" URL:         http://github.com/yalesov/vim-ember-script
" Version:     1.0.4
" Last Change: 2016 Jul 6
" License:     ISC

if exists('b:did_indent')
  finish
endif

runtime! indent/coffee.vim
unlet! b:did_indent
let b:did_indent = 1

endif
