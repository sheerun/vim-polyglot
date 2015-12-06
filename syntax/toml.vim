if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'toml') == -1
  
" Language:   TOML
" Maintainer: Caleb Spare <cespare@gmail.com>
" URL:        https://github.com/cespare/vim-toml
" LICENSE:    MIT

if exists("b:current_syntax")
  finish
endif

syn match tomlEscape /\\[btnfr"/\\]/ display contained
syn match tomlEscape /\\u\x\{4}/ contained
syn match tomlEscape /\\U\x\{8}/ contained
hi def link tomlEscape SpecialChar

syn match tomlLineEscape /\\$/ contained
hi def link tomlLineEscape SpecialChar

" Basic strings
syn region tomlString oneline start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=tomlEscape
" Multi-line basic strings
syn region tomlString start=/"""/ end=/"""/ contains=tomlEscape,tomlLineEscape
" Literal strings
syn region tomlString oneline start=/'/ end=/'/
" Multi-line literal strings
syn region tomlString start=/'''/ end=/'''/
hi def link tomlString String

syn match tomlInteger /\<[+-]\=[0-9]\(_\=\d\)*\>/ display
hi def link tomlInteger Number

syn match tomlFloat /\<[+-]\=[0-9]\(_\=\d\)*\.\d\+\>/ display
syn match tomlFloat /\<[+-]\=[0-9]\(_\=\d\)*\(\.[0-9]\(_\=\d\)*\)\=[eE][+-]\=[0-9]\(_\=\d\)*\>/ display
hi def link tomlFloat Float

syn match tomlBoolean /\<\%(true\|false\)\>/ display
hi def link tomlBoolean Boolean

" https://tools.ietf.org/html/rfc3339
syn match tomlDate /\d\{4\}-\d\{2\}-\d\{2\}T\d\{2\}:\d\{2\}:\d\{2\}\%(\.\d\+\)\?\%(Z\|[+-]\d\{2\}:\d\{2\}\)/ display
hi def link tomlDate Constant

syn match tomlTable /^\s*\[[^#\[\]]\+\]\s*\(#.*\)\?$/ contains=tomlComment
hi def link tomlTable Identifier

syn match tomlTableArray /^\s*\[\[[^#\[\]]\+\]\]\s*\(#.*\)\?$/ contains=tomlComment
hi def link tomlTableArray Identifier

syn keyword tomlTodo TODO FIXME XXX BUG contained
hi def link tomlTodo Todo

syn match tomlComment /#.*/ contains=@Spell,tomlTodo
hi def link tomlComment Comment

let b:current_syntax = "toml"

endif
