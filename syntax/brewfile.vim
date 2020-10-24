let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/brewfile.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'brewfile') == -1

" Vim syntax file
" Language:    Brewfile
" Maintainer:  Baptiste Fontaine <b@ptistefontaine.fr>
" URL:         https://github.com/bfontaine/Brewfile.vim
" Last Change: 2015 Jun 18

if exists("b:current_syntax")
  finish
endif

" Load ruby syntax
source $VIMRUNTIME/syntax/ruby.vim
unlet b:current_syntax

syn keyword brewfileDirective brew cask tap mas cask_args

hi def link brewfileDirective Keyword

let b:current_syntax = "brewfile"

endif
