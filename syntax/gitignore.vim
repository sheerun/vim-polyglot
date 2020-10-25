if has_key(g:polyglot_is_disabled, 'gitignore')
  finish
endif

scriptencoding utf-8

" Copyright (c) 2017-2020 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

if exists('b:current_syntax')
  finish
endif

" https://git-scm.com/docs/gitignore#_pattern_format
syntax keyword gitignoreTodo TODO FIXME XXX NOTE SEE contained
syntax match gitignoreComment '^#.*' contains=gitignoreTodo
syntax match gitignoreComment '\s#.*'ms=s+1 contains=gitignoreTodo
syntax match gitignoreNegation '^!'
syntax match gitignoreSeparator '/'
syntax match gitignoreWildcard '\(\\\)\@<![*?]'
syntax region gitignoreSet start='\[' skip='\\\]' end='\]'

highlight default link gitignoreTodo Todo
highlight default link gitignoreComment Comment
highlight default link gitignoreNegation Exception
highlight default link gitignoreSeparator Constant
highlight default link gitignoreWildcard Special
highlight default link gitignoreSet Character

let b:current_syntax = 'gitignore'

" vim: ts=2 et sw=2
