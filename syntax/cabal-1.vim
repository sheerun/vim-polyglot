if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1

" syntax highlighting for cabal
"
" author: raichoo (raichoo@googlemail.com)

if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syn match cabalLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=@Spell
syn match cabalIdentifier "[A-Za-z\-]*" contained
syn match cabalOperator "[<=>&|!]"
syn match cabalColon ":" contained
syn match cabalNumber "\<[0-9][0-9\.*]*\>"
syn match cabalDelimiter "[,()]"
syn keyword cabalBool True False
syn keyword cabalConditional if else
syn match cabalCompilerFlag "\s\+-[^ -][^ ]*"
syn match cabalDocBulletPoint "^\s\+\*"
syn match cabalDocHeadline "^\s\+=.*$"
syn match cabalDocCode "^\s\+>.*$"
syn match cabalDocNewline "^\s\+\.\s*$"
syn match cabalSection "^\c\(executable\|library\|flag\|source-repository\|test-suite\|benchmark\)"
syn match cabalEntry "^\s*[A-Za-z][a-zA-Z\-]*:" contains=cabalIdentifier,cabalColon

syn region cabalDescription start="^\s*[dD]escription:" end="^\<" keepend
  \ contains=
  \ cabalEntry,
  \ cabalLineComment,
  \ cabalDocBulletPoint,
  \ cabalDocHeadline,
  \ cabalDocNewline,
  \ cabalDocCode

highlight def link cabalIdentifier Identifier
highlight def link cabalLineComment Comment
highlight def link cabalOperator Operator
highlight def link cabalColon Operator
highlight def link cabalNumber Number
highlight def link cabalSection Structure
highlight def link cabalDelimiter Delimiter
highlight def link cabalBool Boolean
highlight def link cabalCompilerFlag Macro
highlight def link cabalConditional Conditional
highlight def link cabalDocBulletPoint Structure
highlight def link cabalDocHeadline Include
highlight def link cabalDocNewline Operator
highlight def link cabalDocCode Macro

let b:current_syntax = "cabal"

endif
