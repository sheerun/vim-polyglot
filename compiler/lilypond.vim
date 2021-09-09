if polyglot#init#is_disabled(expand('<sfile>:p'), 'lilypond', 'compiler/lilypond.vim')
  finish
endif

" LilyPond compiler file
" Language:     LilyPond
" Maintainer:   Heikki Junes <hjunes@cc.hut.fi>
" License:      This file is part of LilyPond, the GNU music typesetter.
"
"               Copyright (C) 2004, 2007 Heikki Junes <hjunes@cc.hut.fi>
"
"               LilyPond is free software: you can redistribute it and/or modify
"               it under the terms of the GNU General Public License as published by
"               the Free Software Foundation, either version 3 of the License, or
"               (at your option) any later version.
"
"               LilyPond is distributed in the hope that it will be useful,
"               but WITHOUT ANY WARRANTY; without even the implied warranty of
"               MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"               GNU General Public License for more details.
"
"               You should have received a copy of the GNU General Public License
"               along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.
"
" Last Change:  2007 Aug 19
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
