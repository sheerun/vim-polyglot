if has_key(g:polyglot_is_disabled, 'requirements')
  finish
endif

" the Requirements File Format syntax support for Vim
" Version: 1.5.3
" Author:  raimon <raimon49@hotmail.com>
" License: MIT LICENSE
" The MIT License (MIT)
"
" Copyright (c) 2015 raimon
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

if exists("b:current_syntax") && b:current_syntax == "requirements"
    finish
endif

syn case match

syn region requirementsComment start="[ \t]*#" end="$"
syn match requirementsCommandOption "\v^\[?--?[a-zA-Z\-]*\]?"
syn match requirementsVersionSpecifiers "\v(\=\=\=?|\<\=?|\>\=?|\~\=|\!\=)"
syn match requirementsPackageName "\v^([a-zA-Z0-9][a-zA-Z0-9\-_\.]*[a-zA-Z0-9])"
syn match requirementsExtras "\v\[\S+\]"
syn match requirementsVersionControls "\v(git\+?|hg\+|svn\+|bzr\+).*://.\S+"
syn match requirementsURLs "\v(\@\s)?(https?|ftp|gopher)://?[^\s/$.?#].\S*"
syn match requirementsEnvironmentMarkers "\v;\s[^#]+"

hi link requirementsComment Comment
hi link requirementsCommandOption Special
hi link requirementsVersionSpecifiers Boolean
hi link requirementsPackageName Identifier
hi link requirementsExtras Type
hi link requirementsVersionControls Underlined
hi link requirementsURLs Underlined
hi link requirementsEnvironmentMarkers Macro

let b:current_syntax = "requirements"

" vim: et sw=4 ts=4 sts=4:
