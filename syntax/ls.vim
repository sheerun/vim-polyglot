if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'livescript') == -1

" Language:    LiveScript "
" Maintainer:  George Zahariev
" URL:         http://github.com/gkz/vim-ls
" License:     WTFPL

if exists('b:current_syntax') && b:current_syntax == 'livescript'
  finish
endif

let b:current_syntax = "ls"

" Highlight long strings.
syntax sync minlines=100

setlocal iskeyword=48-57,A-Z,$,a-z,_,-

syntax match lsIdentifier /[$A-Za-z_]\k*\(-[a-zA-Z]\+\)*/
highlight default link lsIdentifier Identifier

" These are 'matches' rather than 'keywords' because vim's highlighting priority
" for keywords (the highest) causes them to be wrongly highlighted when used as
" dot-properties.
syntax match lsStatement /\<\%(return\|break\|continue\|throw\)\>/
highlight default link lsStatement Statement

syntax match lsRepeat /\<\%(for\%( own\| ever\)\?\|while\|until\)\>/
highlight default link lsRepeat Repeat

syntax match lsConditional /\<\%(if\|else\|unless\|switch\|case\|when\|default\|match\)\>/
highlight default link lsConditional Conditional

syntax match lsException /\<\%(try\|catch\|finally\)\>/
highlight default link lsException Exception

syntax match lsKeyword /\<\%(new\|in\%(stanceof\)\?\|typeof\|delete\|and\|o[fr]\|not\|xor\|is\|isnt\|imp\%(ort\%( all\)\?\|lements\)\|extends\|loop\|from\|to\|til\|by\|do\|then\|function\|class\|let\|with\|export\|const\|var\|eval\|super\|fallthrough\|debugger\|where\|yield\)\>/
highlight default link lsKeyword Keyword

syntax match lsBoolean /\<\%(true\|false\|yes\|no\|on\|off\|null\|void\)\>/
highlight default link lsBoolean Boolean

" Matches context variables.
syntax match lsContext /\<\%(this\|arguments\|it\|that\|constructor\|prototype\|superclass\)\>/
highlight default link lsContext Type

" Keywords reserved by the language
syntax cluster lsReserved contains=lsStatement,lsRepeat,lsConditional,
\                                  lsException,lsOperator,lsKeyword,lsBoolean

" Matches ECMAScript 5 built-in globals.
syntax match lsGlobal /\<\%(Array\|Boolean\|Date\|Function\|JSON\|Math\|Number\|Object\|RegExp\|String\|\%(Syntax\|Type\|URI\)\?Error\|is\%(NaN\|Finite\)\|parse\%(Int\|Float\)\|\%(en\|de\)codeURI\%(Component\)\?\)\>/
highlight default link lsGlobal Structure

syntax region lsString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=@lsInterpString
syntax region lsString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=@lsSimpleString
highlight default link lsString String

" Matches decimal/floating-point numbers like 10.42e-8.
syntax match lsFloat
\ /\%(\<-\?\|-\)\zs\d[0-9_]*\%(\.\d[0-9_]*\)\?\%(e[+-]\?\d[0-9_]*\)\?\%([a-zA-Z$][$a-zA-Z0-9_]*\)\?/
\ contains=lsNumberComment
highlight default link lsFloat Float
syntax match lsNumberComment /\d\+\zs\%(e[+-]\?\d\)\@![a-zA-Z$][$a-zA-Z0-9_]*/ contained
highlight default link lsNumberComment Comment
" Matches hex numbers like 0xfff, 0x000.
syntax match lsNumber /\%(\<-\?\|-\)\zs0x\x\+/
" Matches N radix numbers like 2@1010.
syntax match lsNumber
\ /\%(\<-\?\|-\)\zs\%(\d*\)\~[0-9A-Za-z][0-9A-Za-z_]*/
highlight default link lsNumber Number

" Displays an error for reserved words.
syntax match lsReservedError /\<\%(enum\|interface\|package\|private\|protected\|public\|static\)\>/
highlight default link lsReservedError Error

syntax keyword lsTodo TODO FIXME XXX contained
highlight default link lsTodo Todo

syntax match  lsComment /#.*/                   contains=@Spell,lsTodo
syntax region lsComment start=/\/\*/ end=/\*\// contains=@Spell,lsTodo
highlight default link lsComment Comment

syntax region lsInfixFunc start=/`/ end=/`/
highlight default link lsInfixFunc Identifier

syntax region lsInterpolation matchgroup=lsInterpDelim
\                                 start=/\#{/ end=/}/
\                                 contained contains=TOP
highlight default link lsInterpDelim Delimiter

" Matches escape sequences like \000, \x00, \u0000, \n.
syntax match lsEscape /\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\./ contained
highlight default link lsEscape SpecialChar

syntax match lsVarInterpolation /#[$A-Za-z_]\k*\(-[a-zA-Z]\+\)*/ contained
highlight default link lsVarInterpolation Identifier

" What is in a non-interpolated string
syntax cluster lsSimpleString contains=@Spell,lsEscape
" What is in an interpolated string
syntax cluster lsInterpString contains=@lsSimpleString,
\                                      lsInterpolation,lsVarInterpolation

syntax region lsRegex start=/\%(\%()\|\i\@<!\d\)\s*\|\i\)\@<!\/\*\@!/
\                     skip=/\[[^]]\{-}\/[^]]\{-}\]/
\                     end=/\/[gimy$]\{,4}/
\                     oneline contains=@lsSimpleString
syntax region lsHeregex start=/\/\// end=/\/\/[gimy$?]\{,4}/ contains=@lsInterpString,lsComment,lsSpaceError fold
highlight default link lsHeregex lsRegex
highlight default link lsRegex String

syntax region lsHeredoc start=/"""/ end=/"""/ contains=@lsInterpString fold
syntax region lsHeredoc start=/'''/ end=/'''/ contains=@lsSimpleString fold
highlight default link lsHeredoc String

syntax match lsWord /\\\S[^ \t\r,;)}\]]*/
highlight default link lsWord String

syntax region lsWords start=/<\[/ end=/\]>/ contains=fold
highlight default link lsWords String

" Reserved words can be used as property names.
syntax match lsProp /[$A-Za-z_]\k*[ \t]*:[:=]\@!/
highlight default link lsProp Label

syntax match lsKey
\ /\%(\.\@<!\.\%(=\?\s*\|\.\)\|[]})@?]\|::\)\zs\k\+/
\ transparent
\ contains=ALLBUT,lsNumberComment,lsIdentifier,lsContext,lsGlobal,lsReservedError,@lsReserved

" Displays an error for trailing whitespace.
syntax match lsSpaceError /\s\+$/ display
highlight default link lsSpaceError Error

if !exists('b:current_syntax')
  let b:current_syntax = 'livescript'
endif

endif
