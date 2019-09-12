if !exists('g:polyglot_disabled') || !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: javascript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
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

if hlexists("jsNoise")    " pangloss/vim-javascript
  syntax cluster jsExpression add=jsxRegion
elseif hlexists("javascriptOpSymbols")    " othree/yajs.vim
  " refine the javascript line comment
  syntax region javascriptLineComment start=+//+ end=/$/ contains=@Spell,javascriptCommentTodo extend keepend
  syntax cluster javascriptValue add=jsxRegion
  syntax cluster javascriptNoReserved add=jsxElement,jsxTag

  " add support to arrow function which returns a tagged template string, e.g.
  " () => html`<div></div>`
  syntax cluster afterArrowFunc add=javascriptTagRef
else    " build-in javascript syntax
  " refine the javascript line comment
  syntax region javaScriptLineComment start=+//+ end=/$/ contains=@Spell,javascriptCommentTodo extend keepend
  " add a javaScriptBlock group for build-in syntax
  syntax region javaScriptBlockBuildIn
        \ contained
        \ matchgroup=javaScriptBraces
        \ start="{"
        \ end="}"
        \ extend
        \ contains=javaScriptBlockBuildIn,@javaScriptEmbededExpr,javaScript.*
        \ fold
  syntax cluster javaScriptEmbededExpr add=jsxRegion

  " refine the template string syntax
  syntax region javaScriptStringT start=+`+ skip=+\\\\\|\\`+ end=+`+ contains=javaScriptSpecial,javaScriptEmbed,@htmlPreproc extend
  syntax region javaScriptEmbed matchgroup=javaScriptEmbedBraces start=+\${+ end=+}+ contained contains=@javaScriptEmbededExpr,javaScript.*
endif

runtime syntax/jsx_pretty.vim

let b:current_syntax = 'javascript.jsx'

let &cpo = s:jsx_cpo
unlet s:jsx_cpo

endif
