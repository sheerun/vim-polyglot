if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim filetype plugin
" Language:	SCSS
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2016 Aug 29

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/sass.vim
setlocal comments=s1:/*,mb:*,ex:*/,://

" vim:set sw=2:

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scss') == -1
  
if exists('b:did_indent') && b:did_indent
  " be kind. allow users to override this. Does it work?
  finish
endif

setlocal indentexpr=scss_indent#GetIndent(v:lnum)

" Automatically insert the current comment leader after hitting <Enter>
" in Insert mode respectively after hitting 'o' or 'O' in Normal mode
setlocal formatoptions+=ro

" SCSS comments are either /* */ or //
setlocal comments=s1:/*,mb:*,ex:*/,://

endif
