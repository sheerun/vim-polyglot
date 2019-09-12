if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1

" Language:    ember-script
" Maintainer:  Yulij Andreevich Lesov <yalesov@gmail.com>>
" URL:         http://github.com/yalesov/vim-ember-script
" Version:     1.0.4
" Last Change: 2016 Jul 6
" License:     ISC

if exists('b:current_syntax') && b:current_syntax == 'ember-script'
  finish
endif

runtime! syntax/coffee.vim
unlet b:current_syntax

" mixin and with
syn match emKeyword /\vmixin|with/ display
hi def link emKeyword Keyword

" annotations
syn match emAnnotation /\v\+(computed|observer|volatile)/ display
hi def link emAnnotation Define

" ~> and *. operators
syn match emOperator /\v\~\>|\*\./ display
hi def link emOperator Operator

" @each is special
syn match emEach /\v\@each/ display
hi def link emEach Special

let b:current_syntax = 'ember-script'

endif
