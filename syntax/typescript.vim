if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

" Vim syntax file
" Language:     TypeScript
" Maintainer:   Herrington Darkholme
" Last Change:  2016-04-05
" Version:      1.0
" Changes:      Go to https:github.com/HerringtonDarkholme/yats.vim for recent changes.
" Origin:       https://github.com/othree/yajs
" Credits:      Kao Wei-Ko(othree), Jose Elera Campana, Zhao Yi, Claudio Fleiner, Scott Shattuck
"               (This file is based on their hard work), gumnos (From the #vim
"               IRC Channel in Freenode)


if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'typescript'
endif

" nextgroup doesn't contain objectLiteral, let outer region contains it
syntax region typescriptTypeCast matchgroup=typescriptTypeBrackets
  \ start=/< \@!/ end=/>/
  \ contains=@typescriptType
  \ nextgroup=@typescriptExpression
  \ contained skipwhite oneline

runtime syntax/common.vim

let b:current_syntax = "typescript"
if main_syntax == 'typescript'
  unlet main_syntax
endif

endif
