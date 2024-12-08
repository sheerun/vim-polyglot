if polyglot#init#is_disabled(expand('<sfile>:p'), 'pony', 'syntax/pony.vim')
  finish
endif

" Vim syntax file
" Language:             Pony
" Maintainer:           You
" Last Change:          2015 May 6
" Original Author:      David Leonard

if exists("b:current_syntax")
  finish
endif

" For syntastic as the 'pony' filetype is not officially registered.
if exists('g:syntastic_extra_filetypes')
    call add(g:syntastic_extra_filetypes, 'pony')
else
    let g:syntastic_extra_filetypes = ['pony']
endif

" TODO add markdown to triple-comments

syn case match

" Sync at the beginning of classes, functions
syn sync match ponySync grouphere NONE "^\s*\%(class\|fun\|be\|new\)\s\+[a-zA-Z_]"

" Constants
syn region  ponyString          start=+"+ skip=+\\"+ end=+"+ contains=ponyEscape
syn region  ponyTripleString    start=+"""+ end=+"""+ contains=ponyEscape,@markdownBlock
syn match   ponyEscape          contained "\\x\x\{2}"
syn match   ponyEscape          contained "\\u\x\{4}"
syn match   ponyEscape          contained "\\U\x\{6}"
syn match   ponyEscape          contained "\\[\\abefnrtv\"'0]"

hi def link ponyString          String
hi def link ponyTripleString    String
hi def link ponyEscape          Character

syn match   ponyInt             "\d\+"
syn match   ponyIntError        "0[bx]"
syn match   ponyInt             "0x\x\+"
syn match   ponyInt             "0b[01]\+"
syn match   ponyCharError       "'"
syn match   ponyChar            "'[^\\']'"
syn match   ponyChar            "'\\[\\abefnrtv\"'0]'" contains=ponyEscape
syn match   ponyChar            "'\\x\x\{2}'" contains=ponyEscape
syn match   ponyChar            "'\\u\x\{4}'" contains=ponyEscape
syn match   ponyChar            "'\\U\x\{6}'" contains=ponyEscape
syn keyword ponyBoolean         true false
syn match   ponyReal            "\d\+\%(\.\d\+\)\=[Ee][+-]\=\d\+"
syn match   ponyReal            "\d\+\.\d\+\%([Ee][+-]\=\d\+\)\="

hi def link ponyInt             Number
hi def link ponyChar            Number
hi def link ponyBoolean         Boolean
hi def link ponyReal            Float
hi def link ponyCharError       Error
hi def link ponyIntError        Error

" Identifiers

syn match   ponyId              "\<\a[a-zA-Z0-9_']*" nextgroup=ponyCap,ponyCapMod
syn match   ponyPrivateId       "\<_[a-zA-Z0-9_']\+"
syn cluster PonyIdentifier	contains=ponyId,ponyPrivateId
"hi def link ponyId              Identifier
"hi def link ponyPrivateId       Identifier

syn keyword ponyBuiltinClass    Array ArrayKeys ArrayValues ArrayPairs
syn keyword ponyBuiltinClass    Env Pointer String StringValues
hi def link ponyBuiltinClass    Structure

syn keyword ponyBuiltinType     Number Signed Unsigned Float
syn keyword ponyBuiltinType     I8 I16 I32 I64 I128 U8 U16 U32 U64 U128 F32 F64
syn keyword ponyBuiltinType     EventID Align IntFormat NumberPrefix FloatFormat
hi def link ponyBuiltinType     Type

syn keyword ponyBuiltinIface    Arithmetic Logical Bits Comparable Ordered
syn keyword ponyBuiltinIface    EventNotify Iterator ReadSeq StdinNotify Seq
syn keyword ponyBuiltinIface    Stringable Bytes BytesList Stream Any
hi def link ponyBuiltinIface    Type

syn region  ponyMethodDecl      matchgroup=ponyMethodKeyword start=+\<\%(fun\|be\|new\)\>+ end=+[[({]\@=+ contains=ponyCap,ponyMethod,@PonyComment
syn keyword ponyMethodKeyword   contained fun be new
syn match   ponyMethod          contained "\<\a[a-zA-Z0-9_']*"
syn match   ponyMethod          contained "\<_[a-zA-Z0-9_']\+"
hi def link ponyMethod          Function
hi def link ponyMethodKeyword   Keyword

syn region  ponyVarDecl         matchgroup=ponyVarKeyword start=+\<\%(var\|let\|embed\)\>+ end=+[:=]\@=+ contains=ponyVar,@PonyComment
syn keyword ponyVarKeyword      contained var let embed
syn match   ponyVar             contained "\<\a[a-zA-Z0-9_']*"
syn match   ponyVar             contained "\<_[a-zA-Z0-9_']\+"
hi def link ponyVar             Identifier
hi def link ponyVarKeyword      Keyword

" Operators and delimiters

syn match   ponyCapModError     +[\^\!]+
hi def link ponyCapModError     Error

syn match   ponyQuestion        +?+
hi def link ponyQuestion        StorageClass

syn match   ponyAt              +@+
hi def link ponyAt              Delimiter

syn match   ponyAtOpError       +@[^ 	\-[("a-zA-Z_]+
syn match   ponyAtIdError       +@\s\+[^"a-zA-Z_]+
hi def link ponyAtIdError       Error
hi def link ponyAtOpError       Error

syn keyword ponyOp1             and or xor is isnt not consume
syn match   ponyOp2             +\([=!]=\|[<>]=\|<<\|>>\|@-\|[-+<>*/%&|]\)+
hi def link ponyOp1             Operator
hi def link ponyOp2             Operator

" Keywords

syn keyword ponyUse             use
hi def link ponyUse             Include

syn keyword ponyStatement       return break continue
syn keyword ponyKeyword         error
syn keyword ponyConditional	if then else elseif match
syn keyword ponyKeyword         do end
syn keyword ponyKeyword         in
syn keyword ponyRepeat          while repeat until for
syn keyword ponyKeyword         with 
syn keyword ponyTry		try recover
syn keyword ponyKeyword         this box
syn keyword ponyKeyword         as where
hi def link ponyStatement       Statement
hi def link ponyConditional     Conditional
hi def link ponyRepeat          Repeat
hi def link ponyKeyword         Keyword
hi def link ponyTry             Exception

syn keyword ponyTypedef         type
syn keyword ponyStructure       interface trait primitive class actor
hi def link ponyTypedef         Typedef
hi def link ponyStructure       Structure

syn keyword ponyCap             iso trn ref val box tag nextgroup=ponyCapMod
syn match   ponyCapMod          contained +[\^\!]+
hi def link ponyCap             StorageClass
hi def link ponyCapMod          StorageClass

syn keyword ponySpecial         compiler_intrinsic
hi def link ponySpecial         Special

syn keyword ponyAny             _
hi def link ponyAny             Special

" Parentheses

syn match   ponyParenError      +[()]+
syn region  ponyParen           transparent start=+(+ end=+)+ contains=TOP,ponyParenError
syn match   ponyArrayError      +[\[\]]+
syn region  ponyArray           transparent start=+\[+ end=+]+ contains=TOP,ponyArrayError
syn match   ponyConstError      +[{}]+
syn region  ponyConst           transparent start=+{+ end=+}+ contains=TOP,ponyConstError

hi def link ponyParenError      Error
hi def link ponyArrayError      Error
hi def link ponyConstError      Error

" Methods

syn match   ponyIntroducer      +=>+
hi def link ponyIntroducer      Delimiter

" Comments
syn region ponyLineComment      start=+//+ end=+$+ contains=ponyTodo keepend
syn region ponyNestedComment    start=+/\*+ end=+\*/+ contains=ponyTodo,ponyNestedComment
syn cluster ponyComment		contains=ponyLineComment,ponyNestedComment
syn keyword ponyTodo            contained TODO FIXME XXX

hi def link ponyLineComment     Comment
hi def link ponyNestedComment   Comment
hi def link ponyTodo            Todo

let b:current_syntax = "pony"
