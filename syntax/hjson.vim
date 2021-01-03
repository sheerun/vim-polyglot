if polyglot#init#is_disabled(expand('<sfile>:p'), 'hjson', 'syntax/hjson.vim')
  finish
endif

" Vim syntax file
" Language: Hjson
" Maintainer: Christian Zangl
" Version: 1.0
" Acknowledgement: Based off of vim/runtime/syntax/json.vim

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'hjson'
endif

" quoteless Strings (has least priority)
syn match   hjsonStringUQ      /[^ \t].*$/

syn match   hjsonNoise         /\%(:\|,\)/

" Syntax: Comments
syn match   hjsonLineComment   "\/\/.*"
syn match   hjsonLineComment2  "#.*"
syn region  hjsonComment       start="/\*" end="\*/"

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
syn match   hjsonStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n,}\]#\/]/ contains=hjsonString
syn region  hjsonString oneline matchgroup=hjsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=hjsonEscape contained
syn match   hjsonStringMatchSQ /'\([^']\|\\\'\)\+'\ze[[:blank:]\r\n,}\]#\/]/ contains=hjsonStringSQ
syn region  hjsonStringSQ oneline matchgroup=hjsonQuote start=/'/  skip=/\\\\\|\\'/  end=/'/ contains=hjsonEscape contained
" multiline:
syn match   hjsonStringMatchML /'''\([\r\n]\|.\)\{-}'''/ contains=hjsonStringML
syn region  hjsonStringML matchgroup=hjsonQuote start=/'''/ end=/'''/ contained

" Syntax: Numbers
syn match   hjsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n,}\]]"

" Syntax: Boolean
syn match   hjsonBoolean   /\(true\|false\)\ze\_s*[\]}#\/,\r\n]/

" Syntax: Null
syn match   hjsonNull      /null\ze\_s*[\]}#\/,\r\n]/

" Syntax: JSON Object Keywords
" Separated into a match and region because a region by itself is always greedy
syn match   hjsonKeywordMatchQ /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=hjsonKeywordQ
syn region  hjsonKeywordQ matchgroup=hjsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contained
syn match   hjsonKeywordMatchSQ /'\([^']\|\\\'\)\+'[[:blank:]\r\n]*\:/ contains=hjsonKeywordSQ
syn region  hjsonKeywordSQ matchgroup=hjsonQuote start=/'/  end=/'\ze[[:blank:]\r\n]*\:/ contained
" without quotes
syn match   hjsonKeywordMatch /[^][",:{}[:blank:]]\+\:/ contains=hjsonKeyword
syn region  hjsonKeyword matchgroup=hjsonQuote start=//  end=/\ze\:/ contained

" Syntax: Escape sequences
syn match   hjsonEscape    "\\["'\\/bfnrt]" contained
syn match   hjsonEscape    "\\u\x\{4}" contained

" Syntax: Array/Object Braces
syn region  hjsonFold matchgroup=hjsonBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  hjsonFold matchgroup=hjsonBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" Define the default highlighting.
hi def link hjsonComment         Comment
hi def link hjsonLineComment     hjsonComment
hi def link hjsonLineComment2    hjsonComment
hi def link hjsonString          String
hi def link hjsonStringSQ        hjsonString
hi def link hjsonStringML        hjsonString
hi def link hjsonStringUQ        hjsonString
hi def link hjsonEscape          Character "Special
hi def link hjsonNumber          Number
hi def link hjsonBraces          Delimiter
hi def link hjsonNull            Function
hi def link hjsonBoolean         Boolean
hi def link hjsonKeyword         Label
hi def link hjsonKeywordQ        hjsonKeyword
hi def link hjsonKeywordSQ       hjsonKeyword
hi def link hjsonQuote           Character "Quote
hi def link hjsonNoise           Noise

let b:current_syntax = "hjson"
if main_syntax == 'hjson'
  unlet main_syntax
endif

" MIT License
" Copyright (c) 2013, Jeroen Ruigrok van der Werven, Eli Parra, Christian Zangl
"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

