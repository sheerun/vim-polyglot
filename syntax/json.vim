if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'json') == -1
  
" Vim syntax file
" Language:	JSON
" Maintainer:	Eli Parra <eli@elzr.com> https://github.com/elzr/vim-json
" Last Change:	2014-12-20 Load ftplugin/json.vim

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'json'
endif

let s:concealends = ''
if has('conceal') && get(g:, 'vim_json_syntax_conceal', 1) == 1
  let s:concealends = ' concealends'
endif

syntax match   jsonNoise           /\%(:\|,\)/

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
syn match  jsonStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n]*[,}\]]/ contains=jsonString
exe 'syn region  jsonString oneline matchgroup=jsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ ' . s:concealends . ' contains=jsonEscape contained'

" Syntax: JSON does not allow strings with single quotes, unlike JavaScript.
syn region  jsonStringSQError oneline  start=+'+  skip=+\\\\\|\\"+  end=+'+

" Syntax: JSON Keywords
" Separated into a match and region because a region by itself is always greedy
syn match  jsonKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonKeyword
syn region  jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contains=jsonEscape contained

" Syntax: Escape sequences
syn match   jsonEscape    "\\["\\/bfnrt]" contained
syn match   jsonEscape    "\\u\x\{4}" contained

" Syntax: Numbers
syn match   jsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n]*[,}\]]"

" ERROR WARNINGS **********************************************
" Syntax: Strings should always be enclosed with quotes.
syn match   jsonNoQuotesError  "\<[[:alpha:]][[:alnum:]]*\>"
syn match   jsonTripleQuotesError  /"""/

" Syntax: An integer part of 0 followed by other digits is not allowed.
syn match   jsonNumError  "-\=\<0\d\.\d*\>"

" Syntax: Decimals smaller than one should begin with 0 (so .1 should be 0.1).
syn match   jsonNumError  "\:\@<=[[:blank:]\r\n]*\zs\.\d\+"

" Syntax: No comments in JSON, see http://stackoverflow.com/questions/244777/can-i-comment-a-json-file
syn match   jsonCommentError  "//.*"
syn match   jsonCommentError  "\(/\*\)\|\(\*/\)"

" Syntax: No semicolons in JSON
syn match   jsonSemicolonError  ";"

" Syntax: No trailing comma after the last element of arrays or objects
syn match   jsonTrailingCommaError  ",\_s*[}\]]"

" Syntax: Watch out for missing commas between elements
syn match   jsonMissingCommaError /\("\|\]\|\d\)\zs\_s\+\ze"/
syn match   jsonMissingCommaError /\(\]\|\}\)\_s\+\ze"/ "arrays/objects as values
syn match   jsonMissingCommaError /}\_s\+\ze{/ "objects as elements in an array
syn match   jsonMissingCommaError /\(true\|false\)\_s\+\ze"/ "true/false as value

" ********************************************** END OF ERROR WARNINGS
" Allowances for JSONP: function call at the beginning of the file,
" parenthesis and semicolon at the end.
" Function name validation based on
" http://stackoverflow.com/questions/2008279/validate-a-javascript-function-name/2008444#2008444
syn match  jsonPadding "\%^[[:blank:]\r\n]*[_$[:alpha:]][_$[:alnum:]]*[[:blank:]\r\n]*("
syn match  jsonPadding ");[[:blank:]\r\n]*\%$"

" Syntax: Boolean
syn match  jsonBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/

" Syntax: Null
syn keyword  jsonNull      null

" Syntax: Braces
syn region  jsonFold matchgroup=jsonBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  jsonFold matchgroup=jsonBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" Define the default highlighting.
if version >= 508 || !exists("did_json_syn_inits")
  hi def link jsonPadding		Operator
  hi def link jsonString		String
  hi def link jsonTest			Label
  hi def link jsonEscape		Special
  hi def link jsonNumber		Number
  hi def link jsonBraces		Delimiter
  hi def link jsonNull			Function
  hi def link jsonBoolean		Boolean
  hi def link jsonKeyword		Label

  hi def link jsonNumError					Error
  hi def link jsonCommentError				Error
  hi def link jsonSemicolonError			Error
  hi def link jsonTrailingCommaError		Error
  hi def link jsonMissingCommaError		Error
  hi def link jsonStringSQError				Error
  hi def link jsonNoQuotesError				Error
  hi def link jsonTripleQuotesError		Error
  hi def link jsonQuote			Quote
  hi def link jsonNoise			Noise
endif

let b:current_syntax = "json"
if main_syntax == 'json'
  unlet main_syntax
endif

" Vim settings
" vim: ts=8 fdm=marker

" MIT License
" Copyright (c) 2013, Jeroen Ruigrok van der Werven, Eli Parra
"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"See https://twitter.com/elzr/status/294964017926119424

endif
