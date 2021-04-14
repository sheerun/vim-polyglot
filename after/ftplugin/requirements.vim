if polyglot#init#is_disabled(expand('<sfile>:p'), 'requirements', 'after/ftplugin/requirements.vim')
  finish
endif

" the Requirements File Format syntax support for Vim
" Version: 1.6.0
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
if executable('pip-compile')
    let s:filename = expand("%:p")
    if fnamemodify(s:filename, ":t") ==# 'requirements.in'
        " this is the default filename for pip-compile
        setlocal makeprg=pip-compile
    elseif fnamemodify(s:filename, ":e") ==# 'in'
        \ && Requirements_matched_filename(s:filename)
        setlocal makeprg=pip-compile\ %
    endif
endif
" vim: et sw=4 ts=4 sts=4:
