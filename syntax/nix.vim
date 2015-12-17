if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1
  
"
" Syntax file for Nix
"
" TODO:
"   Emphasize :
"   Deemphasize ;
"   Consistent ()
"   rec (red?)

if exists("b:current_syntax")
    finish
endif

" Operators
syn match nixOperator "\V++"
syn match nixOperator "\V+"
syn match nixOperator "\V!"
syn match nixOperator "\V=="
syn match nixOperator "\V!="
syn match nixOperator "\V&&"
syn match nixOperator "\V||"
syn match nixOperator "\V->"

syn match nixOperator "\V-"
syn match nixOperator "\V*"
syn match nixOperator "\V/"
syn match nixOperator "\V>"
syn match nixOperator "\V<"

" Keywords
syn keyword nixKeyword let in or assert inherit null with rec
syn keyword nixConditional if else then
syn keyword nixBoolean true false

" Builtins
syn keyword nixBuiltin builtins abort add attrNames attrValues
            \ baseNameOf compareVersions concatLists currentSystem deepSeq
            \ derivation dirOf div elem elemAt filter filterSource fromJSON
            \ getAttr getEnv hasAttr hashString head import intersectAttrs
            \ isAttrs isList isFunction isString isInt isBool isNull length
            \ lessThan listToAttrs map mul parseDrvNames pathExists readDir
            \ readFile removeAttrs seq stringLength sub substring tail throw
            \ toFile toJSON toPath toString toXML trace typeOf tryEval

syn match nixpkgs "<nixpkgs>"
syn match nixSpecialOper "\V@\|;\|,\|?\|..."

" Attribute Lists
"syn match nixBrace "\v[(){}\[\]]|rec\s*\{"
syn region nixSet matchgroup=nixBraces start="{" end="}" contains=ALL
syn region nixRecSet matchgroup=nixBraces start="rec\s*{" end="}" contains=ALL
syn region nixList matchgroup=nixBraces start="\[" end="\]" contains=ALLBUT,nixAttr
syn match nixAttr "\v[0-9A-Za-z\-\_]+\ze\s*\=" contained

syn match nixInteger "\v<\d+>"

" Functions
syn match nixFuncArg "\v\zs\w+\ze\s*:"

" TODO: Exclude ; and other illegal characters
syn match nixPath "\v\S*/\S+|\S+/\S*"

" This operator is placed after nixPath to override nixPath's highlighting
syn match nixOperator "\V//"

" Strings
syn match nixStringIndentedEscapes +'''\|''\${\|''\\n\|''\\r\|''\\t+
syn match nixStringEscapes +\\"\|\\\${\|\\n\|\\r\|\\t\|\\\\+
syn region nixStringIndented
            \ start=+''+
            \ skip=+'''+
            \ end=+''+
            \ contains=nixAntiquotation,nixStringIndentedEscapes
syn region nixString
            \ start=+"+
            \ skip=+\\"+
            \ end=+"+
            \ contains=nixAntiquotation,nixStringEscapes

" If this contains nixBrace, it ignores its own closing brace and syntax gets
" thrown way off contains=ALLBUT,nixBrace
syn region nixAntiquotation start=+\${+ end=+}+ contains=nixAntiQuotation

" Comments
syn region nixMultiLineComment start=+/\*+ skip=+\\"+ end=+\*/+ contains=nixTodos
syn match  nixEndOfLineComment "#.*$" contains=nixTodos
syntax keyword nixTodos TODO XXX FIXME NOTE TODOS contained

" Special (Delimiter
hi def link nixBraces                Delimiter
hi def link nixpkgs                  Special
hi def link nixSpecialOper           Special
hi def link nixStringIndentedEscapes SpecialChar
hi def link nixStringEscapes         SpecialChar
hi def link nixBuiltin               Special
hi def link nixOperator              Operator

" Constants
hi def link nixBoolean          Boolean
hi def link nixInteger          Number
hi def link nixString           String
hi def link nixStringIndented   String

" Comments
hi def link nixMultiLineComment Comment
hi def link nixEndOfLineComment Comment

" Identifiers
hi def link nixConditional      Conditional
hi def link nixKeyword          Keyword
hi def link nixOperator         Operator
hi def link nixException        Exception
hi def link nixAttr             Identifier
hi def link nixFuncArg          Identifier

" PreProc
hi def link nixAntiquotation      Macro

" Underlined (html links)
hi def link nixPath             Underlined

" Error

syn sync maxlines=20000
syn sync minlines=50000

let b:current_syntax = 'nix'

endif
