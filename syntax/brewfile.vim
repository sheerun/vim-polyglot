if has_key(g:polyglot_is_disabled, 'brewfile')
  finish
endif

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
