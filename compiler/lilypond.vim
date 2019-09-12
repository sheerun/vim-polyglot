if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'lilypond') == -1

" LilyPond compiler file
" Language:     LilyPond
" Maintainer:   Heikki Junes <hjunes@cc.hut.fi>
" Last Change:  2004 Mar 01
"
" Installed As:	vim/compiler/lilypond.vim
"
" Only load this indent file when no other was loaded.
if exists("current_compiler")
  finish
endif
let current_compiler = "lilypond"

" default make
setlocal makeprg=lilypond\ $*
" errorformat for lily (with columns) and gcc
" (how to see multiple-line error messages?)
setlocal errorformat=%f:%l:%c:\ %m,%f:%l:\ %m,In\ file\ included\ from\ %f:%l:,\^I\^Ifrom\ %f:%l%m
"

endif
