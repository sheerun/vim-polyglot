if polyglot#init#is_disabled(expand('<sfile>:p'), 'lilypond', 'indent/lilypond.vim')
  finish
endif

" LilyPond indent file
" Language:     LilyPond
" Maintainer:   Heikki Junes <hjunes@cc.hut.fi>
" License:      This file is part of LilyPond, the GNU music typesetter.
"
"               Copyright (C) 2004, 2010 Heikki Junes <hjunes@cc.hut.fi>
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
" Last Change:  2010 Jul 26
"
" Installed As:	vim/indent/lilypond.vim
"
" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetLilyPondIndent()
setlocal indentkeys=o,O,},>>,!^F

" Only define the function once.
if exists("*GetLilyPondIndent")
  finish
endif

function GetLilyPondIndent()
  if v:lnum == 1
    return 0
  endif

  "Find a non-blank line above the current line.
  let lnum = prevnonblank(v:lnum - 1)
  "Check if a block was started: '{' or '<<' is the last non-blank character of the previous line.
  if getline(lnum) =~ '^.*\({\|<<\)\s*$'
    let ind = indent(lnum) + &sw
  else
    let ind = indent(lnum)
  endif

  "Check if a block was ended: '}' or '>>' is the first non-blank character of the current line.
  if getline(v:lnum) =~ '^\s*\(}\|>>\)'
    let ind = ind - &sw
  endif

  " Check if the first character from the previous line is within
  " a `lilyScheme' region, and if so, use lisp-style indentation
  " for the current line.
  "
  " TODO:
  "   - Only works in version 7.1.215 or later, though it should
  "     silently fail in older versions.
  "   - We should support `lilyScheme' regions that begin in the
  "     middle of the line, too.
  for id in synstack(lnum, 1)
    if synIDattr(id, "name") == "lilyScheme"
      let ind = lispindent(v:lnum)
    endif
  endfor

  return ind
endfunction
"
"
"
