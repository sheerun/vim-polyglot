if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1
  

if exists("b:current_syntax")
  finish
endif

syn case match


syn keyword juliaDirective import importall export using require include

hi def link juliaDirective Include

syn region juliaDeclTypeBlock transparent matchgroup=juliaDeclType start="\<\%(type\|immutable\)\>" end="\<end\>" contains=ALL
syn keyword juliaTypeAlias typealias
syn keyword juliaDeclAbstract abstract

hi def link juliaDeclType  Structure
hi def link juliaTypeAlias Typedef
hi def link juliaDeclAbstract Structure

" Module
syn region juliaModuleBlock transparent matchgroup=juliaModule start="\<module\>" end="\<end\>" contains=ALL

hi def link juliaModule Structure


" Misc. blocks
syn region juliaMiscBlockBlock transparent matchgroup=juliaMiscBlock start="\<\%(quote\|do\|begin\|let\)\>" end="\<end\>" contains=ALL

hi def link juliaMiscBlock Repeat

" Braces and Brackets
syn region juliaBracketsBlock matchgroup=juliaBrackets start='\[' end='\]' contains=ALLBUT,juliaRepeatBlock contained
syn region juliaBracesBlock matchgroup=juliaBraces start='{' end='}' contains=ALLBUT,juliaRepeatBlock contained

" Repeat
syn region juliaRepeatBlock transparent matchgroup=juliaRepeat start="\<\%(while\|for\)\>" end="\<end\>" contains=@juliaTop

hi def link juliaRepeat    Repeat

" Conditional
syn keyword juliaElse else elseif
syn region  juliaIfBlock transparent matchgroup=juliaIf start="\<if\>" end="\<end\>" contains=@juliaTop

hi def link juliaElse Conditional
hi def link juliaIf   Conditional


" try catch end
syn keyword juliaCatch    catch contained
syn region  juliaTryBlock transparent matchgroup=juliaTry start="\<try\>" end="\<end\>" contains=@juliaTop

hi def link juliaTry Exception
hi def link juliaCatch Exception


" one word statements
syn keyword juliaStatement return continue break

hi def link juliaStatement Statement

" misc
syn keyword juliaDeclaration const global local
syn keyword juliaComprehensionFor for

hi def link juliaDeclaration Keyword
hi def link juliaComprehensionFor Keyword

" Built in types
syn keyword juliaType Uint Uint8 Uint16 Uint32 Uint64 Uint128
syn keyword juliaType Int Int8 Int16 Int32 Int64 Int128
syn keyword juliaType Float Float16 Float32 Float64
syn keyword juliaType AbstractArray AbstractMatrix AbstractVector Array Vector Matrix
syn keyword juliaType String ByteString UTF8String SubString
syn keyword juliaType Bool Nothing Union Type


hi def link juliaType Type


" Comments
syn keyword juliaTodo         contained TODO FIXME XXX
syn cluster juliaCommentGroup contains=juliaTodo
syn region  juliaComment      start="#" end="$" contains=@juliaCommentGroup,@Spell

hi def link juliaComment Comment
hi def link juliaTodo    Todo


" Strings
syn region juliaString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@juliaStringGroup,@Spell
syn region juliaTripleString start=+"""+ end=+"""+
syn region juliaCharacter    start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@juliaCharacterGroup

hi def link juliaString        String
hi def link juliaTripleString  String
hi def link juliaCharacter     Character


" Functions
syn region juliaFunctionBlock transparent matchgroup=juliaFunction start="\<\%\(function\|macro\)\>" end="\<end\>" contains=@juliaTop
hi def link juliaFunction Function


" Numbers
syn match juliaNumber "\<\d\+\([Ee]\d\+\)\?\>"
syn match juliaNumber "\<0x\x\+\>"
syn match juliaNumber "\<0\o\+\>"

syn match juliaFloat "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match juliaFloat "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match juliaFloat "\<\d\+[Ee][-+]\d\+\>"
syn keyword juliaFloatSpecial NaN Inf

hi def link juliaNumber Number
hi def link juliaFloat Float
hi def link juliaFloatSpecial Float


" Operators
syn keyword juliaIn in
hi def link juliaIn Operator


" Constants
syn keyword juliaBool true false nothing
hi def link juliaBool Boolean

syn keyword juliaIdentifierSpecial STDOUT, STDIN, STDERR

hi def link juliaIdentifierSpecial Identifier


" Macros
syn match juliaMacro display "@[_[:alpha:]][_[:alnum:]!]*\%(\.[_[:alpha:]][_[:alnum:]!]*\)*"

hi def link juliaMacro Macro


syn cluster juliaTop contains=ALLBUT,juliaComprehensionFor

" Ragel
syn include @ragel syntax/ragel.vim
syn region ragelLine  start="%%" end="$" contains=@ragel


let b:current_syntax = "julia"



endif
