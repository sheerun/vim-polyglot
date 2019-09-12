if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'moonscript') == -1

" Language:    MoonScript
" Maintainer:  leafo <leafot@gmail.com>
" Based On:    CoffeeScript by Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/leafo/moonscript-vim
" License:     WTFPL

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'moon'
  finish
endif

if version < 600
  syn clear
endif

" Highlight long strings.
syn sync minlines=100

" These are `matches` instead of `keywords` because vim's highlighting
" priority for keywords is higher than matches. This causes keywords to be
" highlighted inside matches, even if a match says it shouldn't contain them --
" like with moonAssign and moonDot.
syn match moonStatement /\<\%(return\|break\|continue\)\>/ display
hi def link moonStatement Statement

syn match moonRepeat /\<\%(for\|while\)\>/ display
hi def link moonRepeat Repeat

syn match moonConditional /\<\%(if\|else\|elseif\|then\|switch\|when\|unless\)\>/
\                           display
hi def link moonConditional Conditional

" syn match moonException /\<\%(try\|catch\|finally\)\>/ display
" hi def link moonException Exception

syn match moonKeyword /\<\%(export\|local\|import\|from\|with\|in\|and\|or\|not\|class\|extends\|super\|using\|do\)\>/
\                       display
hi def link moonKeyword Keyword

" all built in funcs from Lua 5.1
syn keyword moonLuaFunc assert collectgarbage dofile error next
syn keyword moonLuaFunc print rawget rawset tonumber tostring type _VERSION
syn keyword moonLuaFunc _G getfenv getmetatable ipairs loadfile
syn keyword moonLuaFunc loadstring pairs pcall rawequal
syn keyword moonLuaFunc require setfenv setmetatable unpack xpcall
syn keyword moonLuaFunc load module select
syn match moonLuaFunc /package\.cpath/
syn match moonLuaFunc /package\.loaded/
syn match moonLuaFunc /package\.loadlib/
syn match moonLuaFunc /package\.path/
syn match moonLuaFunc /package\.preload/
syn match moonLuaFunc /package\.seeall/
syn match moonLuaFunc /coroutine\.running/
syn match moonLuaFunc /coroutine\.create/
syn match moonLuaFunc /coroutine\.resume/
syn match moonLuaFunc /coroutine\.status/
syn match moonLuaFunc /coroutine\.wrap/
syn match moonLuaFunc /coroutine\.yield/
syn match moonLuaFunc /string\.byte/
syn match moonLuaFunc /string\.char/
syn match moonLuaFunc /string\.dump/
syn match moonLuaFunc /string\.find/
syn match moonLuaFunc /string\.len/
syn match moonLuaFunc /string\.lower/
syn match moonLuaFunc /string\.rep/
syn match moonLuaFunc /string\.sub/
syn match moonLuaFunc /string\.upper/
syn match moonLuaFunc /string\.format/
syn match moonLuaFunc /string\.gsub/
syn match moonLuaFunc /string\.gmatch/
syn match moonLuaFunc /string\.match/
syn match moonLuaFunc /string\.reverse/
syn match moonLuaFunc /table\.maxn/
syn match moonLuaFunc /table\.concat/
syn match moonLuaFunc /table\.sort/
syn match moonLuaFunc /table\.insert/
syn match moonLuaFunc /table\.remove/
syn match moonLuaFunc /math\.abs/
syn match moonLuaFunc /math\.acos/
syn match moonLuaFunc /math\.asin/
syn match moonLuaFunc /math\.atan/
syn match moonLuaFunc /math\.atan2/
syn match moonLuaFunc /math\.ceil/
syn match moonLuaFunc /math\.sin/
syn match moonLuaFunc /math\.cos/
syn match moonLuaFunc /math\.tan/
syn match moonLuaFunc /math\.deg/
syn match moonLuaFunc /math\.exp/
syn match moonLuaFunc /math\.floor/
syn match moonLuaFunc /math\.log/
syn match moonLuaFunc /math\.log10/
syn match moonLuaFunc /math\.max/
syn match moonLuaFunc /math\.min/
syn match moonLuaFunc /math\.fmod/
syn match moonLuaFunc /math\.modf/
syn match moonLuaFunc /math\.cosh/
syn match moonLuaFunc /math\.sinh/
syn match moonLuaFunc /math\.tanh/
syn match moonLuaFunc /math\.pow/
syn match moonLuaFunc /math\.rad/
syn match moonLuaFunc /math\.sqrt/
syn match moonLuaFunc /math\.frexp/
syn match moonLuaFunc /math\.ldexp/
syn match moonLuaFunc /math\.random/
syn match moonLuaFunc /math\.randomseed/
syn match moonLuaFunc /math\.pi/
syn match moonLuaFunc /io\.stdin/
syn match moonLuaFunc /io\.stdout/
syn match moonLuaFunc /io\.stderr/
syn match moonLuaFunc /io\.close/
syn match moonLuaFunc /io\.flush/
syn match moonLuaFunc /io\.input/
syn match moonLuaFunc /io\.lines/
syn match moonLuaFunc /io\.open/
syn match moonLuaFunc /io\.output/
syn match moonLuaFunc /io\.popen/
syn match moonLuaFunc /io\.read/
syn match moonLuaFunc /io\.tmpfile/
syn match moonLuaFunc /io\.type/
syn match moonLuaFunc /io\.write/
syn match moonLuaFunc /os\.clock/
syn match moonLuaFunc /os\.date/
syn match moonLuaFunc /os\.difftime/
syn match moonLuaFunc /os\.execute/
syn match moonLuaFunc /os\.exit/
syn match moonLuaFunc /os\.getenv/
syn match moonLuaFunc /os\.remove/
syn match moonLuaFunc /os\.rename/
syn match moonLuaFunc /os\.setlocale/
syn match moonLuaFunc /os\.time/
syn match moonLuaFunc /os\.tmpname/
syn match moonLuaFunc /debug\.debug/
syn match moonLuaFunc /debug\.gethook/
syn match moonLuaFunc /debug\.getinfo/
syn match moonLuaFunc /debug\.getlocal/
syn match moonLuaFunc /debug\.getupvalue/
syn match moonLuaFunc /debug\.setlocal/
syn match moonLuaFunc /debug\.setupvalue/
syn match moonLuaFunc /debug\.sethook/
syn match moonLuaFunc /debug\.traceback/
syn match moonLuaFunc /debug\.getfenv/
syn match moonLuaFunc /debug\.getmetatable/
syn match moonLuaFunc /debug\.getregistry/
syn match moonLuaFunc /debug\.setfenv/
syn match moonLuaFunc /debug\.setmetatable/

hi def link moonLuaFunc Identifier

" The first case matches symbol operators only if they have an operand before.
syn match moonExtendedOp /\%(\S\s*\)\@<=[+\-*/%&|\^=!<>?#]\+\|\.\|\\/
\                          display
hi def link moonExtendedOp moonOperator
hi def link moonOperator Operator

syntax match moonFunction /->\|=>\|)\|(\|\[\|]\|{\|}\|!/
highlight default link moonFunction Function

" This is separate from `moonExtendedOp` to help differentiate commas from
" dots.
syn match moonSpecialOp /[,;]/ display
hi def link moonSpecialOp SpecialChar

syn match moonBoolean /\<\%(true\|false\)\>/ display
hi def link moonBoolean Boolean

syn match moonGlobal /\<\%(nil\)\>/ display
hi def link moonGlobal Type

" A special variable
syn match moonSpecialVar /\<\%(self\)\>/ display
" An @-variable
syn match moonSpecialVar /@\%(\I\i*\)\?/ display
hi def link moonSpecialVar Structure

" A class-like name that starts with a capital letter
syn match moonObject /\<\u\w*\>/ display
hi def link moonObject Structure

" A constant-like name in SCREAMING_CAPS
syn match moonConstant /\<\u[A-Z0-9_]\+\>/ display
hi def link moonConstant Constant

" A variable name
syn cluster moonIdentifier contains=moonSpecialVar,moonObject,
\                                     moonConstant

" A non-interpolated string
syn cluster moonBasicString contains=@Spell,moonEscape
" An interpolated string
syn cluster moonInterpString contains=@moonBasicString,moonInterp

" Regular strings
syn region moonString start=/"/ skip=/\\\\\|\\"/ end=/"/
\                       contains=@moonInterpString
syn region moonString start=/'/ skip=/\\\\\|\\'/ end=/'/
\                       contains=@moonBasicString
hi def link moonString String

syn region moonString2 matchgroup=moonString start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell
hi def link moonString2 String


" A integer, including a leading plus or minus
syn match moonNumber /\i\@<![-+]\?\d\+\%([eE][+-]\?\d\+\)\?/ display
" A hex number
syn match moonNumber /\<0[xX]\x\+\>/ display
hi def link moonNumber Number

" A floating-point number, including a leading plus or minus
syn match moonFloat /\i\@<![-+]\?\d*\.\@<!\.\d\+\%([eE][+-]\?\d\+\)\?/
\                     display
hi def link moonFloat Float

" An error for reserved keywords
if !exists("moon_no_reserved_words_error")
  syn match moonReservedError /\<\%(end\|function\|repeat\)\>/
  \                             display
  hi def link moonReservedError Error
endif

" This is separate from `moonExtendedOp` since assignments require it.
syn match moonAssignOp /:/ contained display
hi def link moonAssignOp moonOperator

" Strings used in string assignments, which can't have interpolations
syn region moonAssignString start=/"/ skip=/\\\\\|\\"/ end=/"/ contained
\                             contains=@moonBasicString
syn region moonAssignString start=/'/ skip=/\\\\\|\\'/ end=/'/ contained
\                             contains=@moonBasicString
hi def link moonAssignString String

" A normal object assignment
syn match moonObjAssign /@\?\I\i*\s*:\@<!::\@!/
\                         contains=@moonIdentifier,moonAssignOp
hi def link moonObjAssign Identifier

" Short hand table literal assign
syn match moonShortHandAssign /:\@<!:@\?\I\i*\s*/
\                         contains=@moonIdentifier,moonAssignOp
hi def link moonShortHandAssign Identifier

" An object-string assignment
syn match moonObjStringAssign /\("\|'\)[^\1]*\1\s*;\@<!::\@!'\@!/
\                               contains=moonAssignString,moonAssignOp
" An object-integer assignment
syn match moonObjNumberAssign /\d\+\%(\.\d\+\)\?\s*:\@<!::\@!/
\                               contains=moonNumber,moonAssignOp

syn keyword moonTodo TODO FIXME XXX contained
hi def link moonTodo Todo

syn match moonComment "\%^#!.*"
syn match moonComment /--.*/ contains=@Spell,moonTodo
hi def link moonComment Comment

" syn region moonBlockComment start=/####\@!/ end=/###/
" \                             contains=@Spell,moonTodo
" hi def link moonBlockComment moonComment

syn region moonInterp matchgroup=moonInterpDelim start=/#{/ end=/}/ contained
\                       contains=@moonAll
hi def link moonInterpDelim PreProc

" A string escape sequence
syn match moonEscape /\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\./ contained display
hi def link moonEscape SpecialChar

" Heredoc strings
" syn region moonHeredoc start=/"""/ end=/"""/ contains=@moonInterpString
" \                        fold
" syn region moonHeredoc start=/'''/ end=/'''/ contains=@moonBasicString
" \                        fold
" hi def link moonHeredoc String

" An error for trailing whitespace, as long as the line isn't just whitespace
if !exists("moon_no_trailing_space_error")
  syn match moonSpaceError /\S\@<=\s\+$/ display
  hi def link moonSpaceError Error
endif

" An error for trailing semicolons, for help transitioning from JavaScript
if !exists("moon_no_trailing_semicolon_error")
  syn match moonSemicolonError /;$/ display
  hi def link moonSemicolonError Error
endif

" Ignore reserved words in dot accesses.
syn match moonDotAccess /\.\@<!\.\s*\I\i*/he=s+1 contains=@moonIdentifier
hi def link moonDotAccess moonExtendedOp

" This is required for interpolations to work.
syn region moonCurlies matchgroup=moonCurly start=/{/ end=/}/
\                        contains=@moonAll contained

" " These are highlighted the same as commas since they tend to go together.
" hi def link moonBlock moonSpecialOp
" hi def link moonBracket moonBlock
" hi def link moonCurly moonBlock
" hi def link moonParen moonBlock

" This is used instead of TOP to keep things moon-specific for good
" embedding. `contained` groups aren't included.
syn cluster moonAll contains=moonStatement,moonRepeat,moonConditional,
\                              moonKeyword,moonOperator,moonFunction,
\                              moonExtendedOp,moonSpecialOp,moonBoolean,
\                              moonGlobal,moonSpecialVar,moonObject,
\                              moonConstant,moonString,moonNumber,
\                              moonFloat,moonReservedError,moonObjAssign,
\                              moonObjStringAssign,moonObjNumberAssign,
\                              moonShortHandAssign,moonComment,moonLuaFunc,
\                              moonSpaceError,moonSemicolonError,
\                              moonDotAccess,
\                              moonCurlies

if !exists('b:current_syntax')
  let b:current_syntax = 'moon'
endif

endif
