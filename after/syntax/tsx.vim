if polyglot#init#is_disabled(expand('<sfile>:p'), 'jsx', 'after/syntax/tsx.vim')
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: javascript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
" Depends:  leafgarland/typescript-vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if get(g:, 'vim_jsx_pretty_disable_tsx', 0)
  finish
endif

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

for syntax_name in ['tsxRegion', 'tsxFragment']
  if hlexists(syntax_name)
    exe 'syntax clear ' . syntax_name
  endif
endfor

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
  hi def link typescriptTypeBrackets typescriptOpSymbols
endif

runtime syntax/jsx_pretty.vim
syntax cluster typescriptExpression add=jsxRegion,typescriptParens
" Fix type casting ambiguity with JSX syntax
syntax match typescriptTypeBrackets +[<>]+ contained
syntax match typescriptTypeCast +<\([_$A-Za-z0-9]\+\)>\%(\s*\%([_$A-Za-z0-9]\+\s*;\?\|(\)\%(\_[^<]*</\1>\)\@!\)\@=+ contains=typescriptTypeBrackets,@typescriptType,typescriptType nextgroup=@typescriptExpression

let b:current_syntax = 'typescript.tsx'

let &cpo = s:jsx_cpo
unlet s:jsx_cpo
