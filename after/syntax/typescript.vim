if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'jsx') != -1
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
if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'styled-components') != -1
  finish
endif

runtime! syntax/javascript.vim

" define custom API section, that contains typescript annotations
" this is structurally similar to `jsFuncCall`, but allows type
" annotations (delimited by brackets (e.g. "<>")) between `styled` and
" the function call parenthesis
syn match styledTypescriptPrefix
      \ "\<styled\><\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>(\%('\k\+'\|\"\k\+\"\|\k\+\))"
      \ transparent fold extend
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,foldBraces,
      \          styledTagNameString
      \ containedin=foldBraces
syn match styledTypescriptPrefix
      \ "\<styled\>\%((\%('\k\+'\|\"\k\+\"\|\k\+\))\|\.\k\+\)<\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ transparent fold extend
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,foldBraces,
      \          styledTagNameString
      \ containedin=foldBraces
syn match styledTypescriptPrefix "\.\<attrs\>\s*(\%(\n\|\s\|.\)\{-})<\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ transparent fold extend
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,foldBraces,
      \          styledTagNameString
      \ containedin=foldBraces
syn match styledTypescriptPrefix "\.\<extend\><\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ transparent fold extend
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,foldBraces,
      \          styledTagNameString
      \ containedin=foldBraces

syn match jsFuncCall "\<styled\>\s*(\%('\k\+'\|\"\k\+\"\|`\k\+`\))<\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ transparent fold
      \ contains=typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,foldBraces,
      \          styledTagNameString
      \ nextgroup=styledDefinition
      \ containedin=foldBraces

syn cluster typescriptValue add=styledPrefix,jsFuncCall,styledTypescriptPrefix

""" yats specific extensions
" extend typescriptIdentifierName to allow styledDefinitions in their
" tagged templates
syn match typescriptIdentifierName extend
      \ "\<css\>\|\<keyframes\>\|\<injectGlobal\>\|\<fontFace\>\|\<createGlobalStyle\>"
      \ nextgroup=styledDefinition
