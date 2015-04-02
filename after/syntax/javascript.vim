"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
" Depends: pangloss/vim-javascript
"
" CREDITS: Inspired by Facebook.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do nothing if we don't find the @jsx pragma (and we care).
exec 'source '.fnameescape(expand('<sfile>:p:h:h').'/jsx-config.vim')
if g:jsx_pragma_required && !b:jsx_pragma_found | finish | endif

" Do nothing if we don't have the .jsx extension (and we care).
if g:jsx_ext_required && !exists('b:jsx_ext_found') | finish | endif

" Prologue; load in XML syntax.
if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @XMLSyntax syntax/xml.vim
if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

" Highlight JSX regions as XML; recursively match.
syn region jsxRegion contains=@XMLSyntax,jsxRegion,jsBlock,jsStringD,jsStringS
  \ start=+<\@<!<\z([a-zA-Z][a-zA-Z0-9:\-.]*\)+
  \ skip=+<!--\_.\{-}-->+
  \ end=+</\z1\_\s\{-}>+
  \ end=+/>+
  \ keepend
  \ extend

" JSX attributes should color as JS.  Note the trivial end pattern; we let
" jsBlock take care of ending the region.
syn region xmlString contained start=+{+ end=++ contains=jsBlock

" Add jsxRegion to the lowest-level JS syntax cluster.
syn cluster jsExpression add=jsxRegion
