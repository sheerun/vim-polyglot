if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'zephir') == -1

" Copyright 2009 The Go Authors. All rights reserved.
if exists("b:current_syntax")
  finish
endif

syn case match

" Comments; their contents
syn keyword     zepTodo              contained TODO FIXME XXX
syn cluster     zepCommentGroup      contains=zepTodo
syn region      zepComment           start="/\*" end="\*/" contains=@zepCommentGroup,@Spell
syn region      zepComment           start="//" end="$" contains=@zepCommentGroup,@Spell

hi def link     zepComment           Comment
hi def link     zepTodo              Todo

syn keyword     zepDirective         namespace extends implements return
syn keyword     zepDeclaration       var let new const
syn keyword     zepDeclType          abstract class interface
syn keyword     zepDeclFun           function
syn keyword     zepDeclMore          public private protected static final
syn keyword     zepExceptionOperator throw try catch

hi def link     zepDirective         Statement
hi def link     zepDeclaration       Keyword
hi def link     zepDeclFun           Keyword
hi def link     zepDeclType          Keyword
hi def link     zepDeclMore          Keyword
hi def link     zepExceptionOperator Keyword

syn keyword     zepCond              if else elseif switch
syn keyword     zepRepeat            for in while loop
syn keyword     zepLabel             case default continue require this parent self
syn match       zepTypeHits          "\<\w+\>"me=e+1,me=e-1 contained display

hi def link     zepCond              Conditional
hi def link     zepRepeat            Repeat
hi def link     zepLabel             Label

syn match       zepOperator          "[-=+%^&|*!.~?:]" contained display
syn match       zepOperator          "[-+*/%^&|.]="  contained display
syn match       zepOperator          "/[^*/]"me=e-1  contained display
syn match       zepOperator          "\$"  contained display
syn match       zepOperator          "&&\|\<and\>" contained display
syn match       zepOperator          "||\|\<x\=or\>" contained display
syn match       zepRelation          "[!=<>]=" contained display
syn match       zepRelation          "[<>]"  contained display
syn match       zepMemberSelector    "->"  contained display

hi def link     zepOperator          Operator
hi def link     zepRelation          Operator
hi def link     zepMemberSelector    Operator

syn keyword     zepType              array string char void void
syn keyword     zepType              bool[ean] true false
syn keyword     zepType              unsigned int uint long ulong

hi def link     zepType              Type

syn match       zepGlobalVar         "_(SERVER|POST|GET|COOKIE|SESSION)\["me=e-1 contained display

hi def link     zepGlobalVar         Statement

syn keyword     zepSpecialOperator   empty isset fetch
syn keyword     zepBuildIns          global_set global_get
syn keyword     zepBuildIns          echo count typeof range reverse
syn keyword     zepBuildIns          set get toString
"for string
syn keyword     zepBuildIns          length trim trimleft trimright index lower upper lowerfirst upperfirst format
"for array
syn keyword     zepBuildIns          join reverse
"for char
syn keyword     zepBuildIns          toHex
"for integer
syn keyword     zepBuildIns          abs

hi def link     zepSpecialOperator   Function
hi def link     zepBuildIns          Function

" zep escapes
syn match       zepEscapeOctal       display contained "\\[0-7]\{3}"
syn match       zepEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       zepEscapeX           display contained "\\x\x\{2}"
syn match       zepEscapeU           display contained "\\u\x\{4}"
syn match       zepEscapeBigU        display contained "\\U\x\{8}"
syn match       zepEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     zepEscapeOctal       zepSpecialString
hi def link     zepEscapeC           zepSpecialString
hi def link     zepEscapeX           zepSpecialString
hi def link     zepEscapeU           zepSpecialString
hi def link     zepEscapeBigU        zepSpecialString
hi def link     zepSpecialString     Special
hi def link     zepEscapeError       Error

" Strings and their contents
syn cluster     zepStringGroup       contains=zepEscapeOctal,zepEscapeC,zepEscapeX,zepEscapeU,zepEscapeBigU,zepEscapeError
syn region      zepString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@zepStringGroup
syn region      zepString            start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@zepStringGroup

hi def link     zepString            String

" Integers
syn match       zepDecimalInt        "\<\d\+\([Ee]\d\+\)\?\>"
syn match       zepHexadecimalInt    "\<0x\x\+\>"
syn match       zepOctalInt          "\<0\o\+\>"
syn match       zepOctalError        "\<0\o*[89]\d*\>"

hi def link     zepDecimalInt        Integer
hi def link     zepHexadecimalInt    Integer
hi def link     zepOctalInt          Integer
hi def link     Integer              Number

" Floating point
syn match       zepFloat             "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match       zepFloat             "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match       zepFloat             "\<\d\+[Ee][-+]\d\+\>"

hi def link     zepFloat             Float

" Imaginary literals
syn match       zepImaginary         "\<\d\+i\>"
syn match       zepImaginary         "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syn match       zepImaginary         "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syn match       zepImaginary         "\<\d\+[Ee][-+]\d\+i\>"

hi def link     zepImaginary         Number


syn sync minlines=500

let b:current_syntax = "zephir"
syn match       zepTypeHits          "<\w+>" contained display

endif
