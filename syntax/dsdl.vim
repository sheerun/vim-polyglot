if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1

" Vim syntax file for DUB configurations."
"
" Language:     SDLang (dub config)
" Maintainer:   Jesse Phillips <Jesse.K.Phillips+D@gmail.com>
" Last Change:  2015-07-11
"
" Contributors:
"   - Joakim Brannstrom <joakim.brannstrom@gmx.com>
"
" Please submit bugs/comments/suggestions to the github repo:
" https://github.com/JesseKPhillips/d.vim

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" General matchers
syn match dsdlAssign         contained "="
syn match dsdlAttribute      "\w*\s*=" contains=dsdlAssign
syn match dsdlStatement      "^\s*[a-zA-Z:]*"

" Keyword grouping
syn keyword dsdlInfo         name description copyright authors license
syn keyword dsdlStructure    buildRequirements buildType configuration
syn keyword dsdlBoolean      true false on off

syn keyword dsdlTodo         contained TODO FIXME XXX

" dsdlCommentGroup allows adding matches for special things in comments
syn cluster dsdlCommentGroup   contains=dsdlTodo

" Highlight % items in strings.
syn match   dsdlFormat     display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained

" dsdlCppString: same as dsdlString, but ends at end of line
syn region  dsdlString     start=+\(L\|u\|u8\|U\|R\|LR\|u8R\|uR\|UR\)\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,dsdlFormat,@Spell extend
syn region  dsdlCppString  start=+\(L\|u\|u8\|U\|R\|LR\|u8R\|uR\|UR\)\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,dsdlFormat,@Spell

syn cluster dsdlStringGroup    contains=dsdlCppString

" Comments
syn region  dsdlCommentL   start="//" skip="\\$" end="$" keepend contains=@dsdlCommentGroup,cSpaceError,@Spell
syn region  dsdlComment    matchgroup=cCommentStart start="/\*" end="\*/" contains=@dsdlCommentGroup,dsdlCommentStartError,cSpaceError,@Spell fold extend
" keep a // comment separately, it terminates a preproc. conditional
syn match   dsdlCommentError       display "\*/"
syn match   dsdlCommentStartError  display "/\*"me=e-1 contained

"integer number, or floating point number without a dot and with "f".
syn case ignore
syn match   dsdlNumbers    display transparent "\<\d\|\.\d" contains=dsdlNumber,dsdlFloat,cOctalError,dsdlOctal
" Same, but without octal error (for comments)
syn match   dsdlNumbersCom display contained transparent "\<\d\|\.\d" contains=dsdlNumber,dsdlFloat,dsdlOctal
syn match   dsdlNumber     display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syn match   dsdlNumber     display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
" Flag the first zero of an octal number as something special
syn match   dsdlOctal      display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=dsdlOctalZero
syn match   dsdlOctalZero  display contained "\<0"
syn match   dsdlFloat      display contained "\d\+f"
"floating point number, with dot, optional exponent
syn match   dsdlFloat      display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syn match   dsdlFloat      display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match   dsdlFloat      display contained "\d\+e[-+]\=\d\+[fl]\=\>"
syn case match

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link dsdlInfo                 Constant
hi def link dsdlAssign               Special
hi def link dsdlBoolean              Boolean
hi def link dsdlFormat               SpecialChar
hi def link dsdlCppString            dsdlString
hi def link dsdlCommentL             dsdlComment
hi def link dsdlNumber               Number
hi def link dsdlOctal                Number
hi def link dsdlOctalZero            PreProc  " link this to Error if you want
hi def link dsdlFloat                Float
hi def link dsdlCommentError         Error
hi def link dsdlCommentStartError    Error
hi def link dsdlStructure            Structure
hi def link dsdlString               String
hi def link dsdlComment              Comment
hi def link dsdlTodo                 Todo
hi def link dsdlStatement            Statement
hi def link dsdlAttribute            Tag

let b:current_syntax = "dsdl"

endif
