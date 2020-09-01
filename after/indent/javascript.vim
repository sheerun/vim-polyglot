if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1

" Copyright (c) 2016-2020 Jon Parise <jon@indelible.org>
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
" FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
" IN THE SOFTWARE.
"
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

runtime! indent/graphql.vim

" Don't redefine our function and also require the standard Javascript indent
" function to exist.
if exists('*GetJavascriptGraphQLIndent') || !exists('*GetJavascriptIndent')
  finish
endif

" Set the indentexpr with our own version that will call GetGraphQLIndent when
" we're inside of a GraphQL string and otherwise defer to GetJavascriptIndent.
setlocal indentexpr=GetJavascriptGraphQLIndent()

function GetJavascriptGraphQLIndent()
  let l:stack = map(synstack(v:lnum, 1), "synIDattr(v:val,'name')")
  if !empty(l:stack) && l:stack[0] ==# 'graphqlTemplateString'
    return GetGraphQLIndent()
  endif

  return GetJavascriptIndent()
endfunction

endif
if !exists('g:polyglot_disabled') || (index(g:polyglot_disabled, 'javascript') == -1 && index(g:polyglot_disabled, 'jsx') == -1)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim indent file
"
" Language: javascript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('b:did_indent')
  let s:did_indent = b:did_indent
  unlet b:did_indent
endif

let s:keepcpo = &cpo
set cpo&vim

if exists('s:did_indent')
  let b:did_indent = s:did_indent
endif

setlocal indentexpr=GetJsxIndent()
setlocal indentkeys=0.,0{,0},0),0],0?,0\*,0\,,!^F,:,<:>,o,O,e,<>>,=*/

function! GetJsxIndent()
  return jsx_pretty#indent#get(function('GetJavascriptIndent'))
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

endif
