" Language:   TOML
" Maintainer: Caleb Spare <cespare@gmail.com>
" URL:        http://github.com/cespare/vim-toml
" LICENSE:    MIT

if exists("b:current_syntax")
  finish
endif

syn match tomlEscape /\\[0tnr"\\]/ display
hi def link tomlEscape SpecialChar

syn region tomlString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=tomlEscape
hi def link tomlString String

syn match tomlInteger /\<-\?\d\+\>/ display
hi def link tomlInteger Number

syn match tomlFloat /\<-\?\d\+\.\d\+\>/ display
hi def link tomlFloat Float

syn match tomlBoolean /\<\%(true\|false\)\>/ display
hi def link tomlBoolean Boolean

syn match tomlDate /\d\{4\}-\d\{2\}-\d\{2\}T\d\{2\}:\d\{2\}:\d\{2\}Z/ display
hi def link tomlDate Constant

syn match tomlKeyGroup /^\s*\[.\+\]\s*\(#.*\)\?$/ contains=tomlComment
hi def link tomlKeyGroup Identifier

syn keyword tomlTodo TODO FIXME XXX BUG contained
hi def link tomlTodo Todo

syn match tomlComment /#.*/ contains=@Spell,tomlTodo
hi def link tomlComment Comment

let b:current_syntax = "toml"
