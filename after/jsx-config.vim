"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimscript file
"
" Set up a bunch of configuration variables.
"
" Also check (if desired) whether or not the @jsx pragma is correctly included
" in '%'.  Set the result in b:jsx_pragma_found.
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only check once.
if exists('b:jsx_pragma_found')
  finish
endif

" Whether the .jsx extension is required to enable JSX syntax/indent.
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 1
endif

" Whether the @jsx pragma is required to enable JSX syntax/indent.
if !exists('g:jsx_pragma_required')
  let g:jsx_pragma_required = 0
endif
if !g:jsx_pragma_required | finish | endif

" Look for the @jsx pragma.  It must be included in a docblock comment before
" anything else in the file (except whitespace).
let s:jsx_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@jsx\_.\{-}\*\/'
let b:jsx_pragma_found = search(s:jsx_pragma_pattern, 'npw')
