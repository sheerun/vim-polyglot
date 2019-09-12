if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: javascript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
" Depends:  leafgarland/typescript-vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:jsx_cpo = &cpo
set cpo&vim

syntax case match

if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif

if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

" refine the typescript line comment
syntax region typescriptLineComment start=+//+ end=/$/ contains=@Spell,typescriptCommentTodo,typescriptRef extend keepend

if !hlexists('typescriptTypeCast')
  " add a typescriptBlock group for typescript
  syntax region typescriptBlock
        \ matchgroup=typescriptBraces
        \ start="{"
        \ end="}"
        \ contained
        \ extend
        \ contains=@typescriptExpression,typescriptBlock
        \ fold
endif

syntax cluster typescriptExpression add=jsxRegion,typescriptParens

runtime syntax/jsx_pretty.vim

let b:current_syntax = 'typescript.tsx'

let &cpo = s:jsx_cpo
unlet s:jsx_cpo

endif
