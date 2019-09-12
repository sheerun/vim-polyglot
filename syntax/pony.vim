if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pony') == -1

" Vim syntax file
" Language:     Pony
" Maintainer:   Jak Wings

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn case match

syn sync match ponySync grouphere NONE /\v^\s*%(actor|class|struct|primitive|trait|interface|new|be|fun|let|var|embed|use)>/

syn match   ponyErrSymbol       /['^!$&\`]/
hi def link ponyErrSymbol       Error

syn match   ponyErrNumGroup     /__\+/ contained
hi def link ponyErrNumGroup     Error

syn match   ponyPeriodComma     /,/ nextgroup=ponyEllipsis,ponyErrOperator skipwhite
syn match   ponyPeriodComma     /\./ nextgroup=ponyTupleIndex,ponyErrOperator skipwhite
syn match   ponyPeriodComma     /;/ nextgroup=ponyErrOperator skipwhite
hi def link ponyPeriodComma     Operator

syn match   ponyBracket         /[{[()\]}]/

syn match   ponyErrNormal       /\v_>|<%([^_a-z]|_[^a-z])|__+/ contained
hi def link ponyErrNormal       Error
syn match   ponyNormal          /\v_?[_a-z]\w*'*/ contains=ponyErrNormal nextgroup=ponyGeneric skipwhite

syn match   ponyInteger         /\v%(\d+_*)+/ contains=ponyErrNumGroup
syn match   ponyErrIntDec       /\v(0[xX])@<=[_.g-zG-Z]/
syn match   ponyErrIntHex       /[.g-zG-Z]/ contained
syn match   ponyInteger         /\v0[xX]%(\x+_*)+/ contains=ponyErrNumGroup nextgroup=ponyErrIntHex
syn match   ponyErrIntDec       /\v(0[bB])@<=[_2-9a-zA-Z]/
syn match   ponyErrIntBin       /[2-9.a-zA-Z]/ contained
syn match   ponyInteger         /\v0[bB]%([01]+_*)+/ contains=ponyErrNumGroup nextgroup=ponyErrIntBin
hi def link ponyErrIntDec       Error
hi def link ponyErrIntHex       Error
hi def link ponyErrIntBin       Error
hi def link ponyInteger         Number

syn match   ponyFloat           /\v%(\d+_*)+[eE][-+]?%(\d+_*)+/ contains=ponyErrNumGroup
syn match   ponyFloat           /\v%(\d+_*)+\.%(\d+_*)+%([eE][-+]?%(\d+_*)+)?/ contains=ponyErrNumGroup
hi def link ponyFloat           Float

syn match   ponyErrUserVariable /\v_>|<%([^_a-z]|_[^a-z])|__+/ contained
hi def link ponyErrUserVariable Error
syn match   ponyUserVariable    /\v[_a-zA-Z]\w*'*/ contained contains=ponyErrUserVariable
hi def link ponyUserVariable    Identifier
syn match   ponyErrUserPackage  /\<[^a-z]/ contained
hi def link ponyErrUserPackage  Error
syn match   ponyUserPackage     /\v[_a-zA-Z]\w*/ contained contains=ponyErrUserPackage
hi def link ponyUserPackage     Identifier
syn match   ponyErrUserType     /\v_>|\a@<=_|<%([^_A-Z]|_[^A-Z])/ contained
hi def link ponyErrUserType     Error
syn match   ponyUserType2       /\v[_a-zA-Z]\w*/ contained contains=ponyErrUserType nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyGeneric,ponyArgument skipwhite
syn match   ponyUserType        /\v_?[A-Z]\w*/ contains=ponyErrUserType nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyGeneric,ponyArgument skipwhite
syn match   ponyErrUserMethod   /\v_>|<%([^_a-z]|_[^a-z])|__+/ contained
hi def link ponyErrUserMethod   Error
syn match   ponyUserMethod      /\v[_a-zA-Z]\w*/ contained contains=ponyErrUserMethod nextgroup=ponyGeneric,ponyArgument,ponyBracketT2 skipwhite
hi def link ponyUserMethod      Function
syn match   ponyForeignFunction /\v[_a-zA-Z]\w*/ contained nextgroup=ponyGeneric skipwhite
hi def link ponyForeignFunction Macro
syn match   ponyErrTupleIndex   /\v_0+>/ contained
hi def link ponyErrTupleIndex   Error
syn match   ponyTupleIndex      /\v_\d+\w@!/ contained contains=ponyErrTupleIndex
hi def link ponyTupleIndex      Normal

syn keyword ponyBoolean         true false
hi def link ponyBoolean         Boolean

syn region  ponyBracketT1       matchgroup=ponyBracket start=/(/ end=/)/ contained contains=@ponyComments,@ponyKeyword,@ponyType,@ponyBracketT,@ponyTypeOperator,ponySymbol,ponyPeriodComma nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyArgument skipwhite
syn region  ponyBracketT2       matchgroup=ponyBracket start=/\[/ end=/\]/ contained contains=@ponyComments,@ponyKeyword,@ponyType,@ponyBracketT,@ponyTypeOperator,ponySymbol,ponyPeriodComma nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyArgument skipwhite
syn region  ponyBracketT3       matchgroup=ponyBracket start=/{/ end=/}/ contained contains=@ponyComments,@ponyKeyword,@ponyType,@ponyBracketT,@ponyTypeOperator,ponySymbol,ponyPeriodComma nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyArgument skipwhite
syn cluster ponyBracketT        contains=ponyBracketT\d

syn region  ponyGeneric         matchgroup=ponyBracketT2 start=/\[/ end=/\]/ contained contains=@ponyComments,@ponyKeyword,@ponyType,@ponyBracketT,@ponyTypeOperator,ponySymbol,ponyPeriodComma nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyArgument skipwhite

syn region  ponyArgument        matchgroup=ponyBracket start=/(/ end=/)/ contained contains=TOP nextgroup=ponyArgument skipwhite

syn match   ponyTypeSuffix      /[!^]/ contained nextgroup=ponyArgument,ponyKwOperatorT skipwhite
hi def link ponyTypeSuffix      StorageClass

syn match   ponyTypeOperator1   /[&|]/ contained nextgroup=@ponyBracketT,@ponyKeyword,@ponyType skipwhite skipempty
hi def link ponyTypeOperator1   Operator

syn match   ponyTypeOperator2   /->\|<:/ contained nextgroup=@ponyBracketT,@ponyKeyword,@ponyType skipwhite skipempty
hi def link ponyTypeOperator2   Operator

syn cluster ponyTypeOperator    contains=ponyTypeOperator\d

syn match   ponyErrOperator     /[-.]>\|<:\|\%(==\|!=\|<<\|>>\|<=\|>=\|[+*/%<>]\)\~\?\|[~.,]/ contained nextgroup=ponyErrOperator skipwhite
hi def link ponyErrOperator     Error

syn match   ponyObjectOperator  /\%(==\|!=\|<<\|>>\|<=\|>=\|[+\-*/%<>]\)\~\?\|\~\|\.>/ nextgroup=ponyErrOperator skipwhite
hi def link ponyObjectOperator  Operator

syn keyword ponyKwOperatorT     is contained nextgroup=@ponyBracketT,@ponyKeyword,@ponyType skipwhite skipempty
hi def link ponyKwOperatorT     Operator

syn keyword ponyKwOperator      as nextgroup=@ponyBracketT,@ponyKeyword,@ponyType skipwhite skipempty
syn keyword ponyKwOperator      and or xor not is isnt consume addressof digestof
hi def link ponyKwOperator      Operator

syn match   ponySymbol          /=>\|[?#]/
syn match   ponySymbol          /@/ nextgroup=ponyForeignFunction skipwhite skipempty
syn match   ponySymbol          /:/ nextgroup=@ponyKeyword,@ponyType,@ponyBracketT skipwhite skipempty
hi def link ponySymbol          Special

syn match   ponyEllipsis        /\.\{3}/ contained containedin=ponyArgument
hi def link ponyEllipsis        Special

syn region  ponyLambda          matchgroup=ponyBracketLambda start=/{/ end=/}/ contains=ponyArgument,@ponyComments,@ponyKeyword,@ponyType,@ponyTypeOperator,ponySymbol,ponyPeriodComma,ponyLambdaBody nextgroup=ponyArgument skipwhite
syn match   ponyLambdaBody      /=>\_.*}/me=e-1 contained contains=TOP
hi def link ponyBracketLambda   Special

" $scripts/gen_id.sh $packages/builtin
syn keyword ponyBuiltinType     AmbientAuth Any Array ArrayKeys ArrayPairs
                          \     ArrayValues AsioEvent AsioEventID
                          \     AsioEventNotify Bool ByteSeq ByteSeqIter
                          \     Comparable Compare DisposableActor
                          \     DoNotOptimise Env Equal Equatable F32 F64
                          \     Float FloatingPoint Greater HasEq I128 I16 I32
                          \     I64 I8 ILong ISize Int Integer Iterator Less
                          \     MaybePointer None Number OutStream Platform
                          \     Pointer ReadElement ReadSeq Real Seq Signed
                          \     SourceLoc StdStream Stdin StdinNotify String
                          \     StringBytes StringRunes Stringable U128 U16
                          \     U32 U64 U8 ULong USize Unsigned
                          \     nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyGeneric,ponyArgument skipwhite
hi def link ponyBuiltinType     Type

syn keyword ponyKwControl       end if else do then elseif match while for in
                        \       repeat until ifdef try with recover return
                        \       break continue error compile_intrinsic
                        \       compile_error iftype elseiftype
hi def link ponyKwControl       Keyword

syn keyword ponyCaseGuard       if contained containedin=ponyMatchCase
hi def link ponyCaseGuard       Keyword

syn region  ponyMatchCase       matchgroup=ponyKwBranchHead start=/|/ matchgroup=ponySymbol end=/=>/ contains=TOP
hi def link ponyKwBranchHead    Keyword

syn keyword ponyKwAtom          this nextgroup=ponyTypeOperator2 skipwhite skipempty
syn keyword ponyKwAtom          object __loc
syn keyword ponyKwAtom          lambda nextgroup=ponyArgument skipwhite
hi def link ponyKwAtom          Keyword

syn keyword ponyKwField         let var embed nextgroup=@ponyKeyword,ponyUserVariable skipwhite skipempty
hi def link ponyKwField         Keyword

syn keyword ponyKwUse           use nextgroup=ponyString,@ponyKeyword,ponyUserPackage skipwhite skipempty
hi def link ponyKwUse           Include

syn keyword ponyKwWhere         where
hi def link ponyKwWhere         Keyword

syn keyword ponyKwTypedef       type nextgroup=@ponyKeyword,@ponyType2 skipwhite skipempty
hi def link ponyKwTypedef       Typedef

syn match   ponyKwCapability    /\v#%(read|send|share|alias|any)>/ nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT skipwhite
syn keyword ponyKwCapability    ref val tag iso box trn nextgroup=ponyTypeSuffix,ponyTypeOperator2,ponyKwOperatorT,ponyArgument skipwhite
hi def link ponyKwCapability    StorageClass

syn keyword ponyKwClass         actor class struct primitive trait interface nextgroup=@ponyKeyword,@ponyType2 skipwhite skipempty
hi def link ponyKwClass         Structure

syn keyword ponyKwFnCapability  ref val tag iso box trn contained nextgroup=@ponyKeyword,ponyUserMethod skipwhite skipempty
hi def link ponyKwFnCapability  StorageClass
syn keyword ponyKwFunction      new be fun nextgroup=ponyKwFnCapability,@ponyKeyword,ponyUserMethod skipwhite skipempty
hi def link ponyKwFunction      Keyword

syn cluster ponyKeyword         contains=ponyKw.*,ponyBoolean,ponyBuiltinType remove=ponyKwOperatorT,ponyKwFnCapability,ponyKwBranchHead
syn cluster ponyType            contains=ponyBuiltinType,ponyUserType,ponyNormal
syn cluster ponyType2           contains=ponyBuiltinType,ponyUserType2
syn cluster ponyComments        contains=ponyNestedComment,ponyComment

syn match   ponyErrEscape       /\\\_.\?\_s*/ contained
hi def link ponyErrEscape       Error
syn match   ponyEscapeSQuote    /\\'/ contained
hi def link ponyEscapeSQuote    SpecialChar
syn match   ponyEscapeDQuote    /\\"/ contained
hi def link ponyEscapeDQuote    SpecialChar
syn match   ponyEscape          /\\[abefnrtv\\0]/ contained
syn match   ponyEscape          /\v\\x\x{2}/ contained
syn match   ponyEscape          /\v\\u\x{4}/ contained
syn match   ponyEscape          /\v\\U\x{6}/ contained
hi def link ponyEscape          SpecialChar

syn region  ponyCharacter       matchgroup=ponyCharacterX start=/\w\@<!'/ skip=/\\./ end=/'/ contains=ponyEscapeSQuote,ponyEscape,ponyErrEscape
hi def link ponyCharacter       Character

syn region  ponyString          matchgroup=ponyStringX start=/"/ skip=/\\./ end=/"/ contains=ponyEscapeDQuote,ponyEscape,ponyErrEscape
hi def link ponyString          String
syn region  ponyDocumentString  matchgroup=ponyDocumentStringX start=/"\ze""/ end=/"""*\zs"/
hi def link ponyDocumentString  String

syn keyword ponyCommentShit     XXX contained
hi def link ponyCommentShit     Underlined
syn keyword ponyCommentDamn     FIXME contained
hi def link ponyCommentDamn     Error
syn keyword ponyCommentTodo     TODO contained
hi def link ponyCommentTodo     Todo
syn cluster ponyCommentNote     contains=ponyCommentTodo,ponyCommentDamn,ponyCommentShit

syn match   ponyComment         @//.*$@ contains=@ponyCommentNote,ponyCommentX
hi def link ponyComment         Comment
syn region  ponyNestedComment   matchgroup=ponyNestedCommentX start=@/\ze\*@ end=@\/\@<!\*\zs/@ contains=ponyNestedComment,@ponyCommentNote keepend extend fold
hi def link ponyNestedComment   Comment

" for indent check
syn match   ponyCommentX        @/\ze/.*$@ contained transparent
hi def link ponyNestedCommentX  Comment
hi def link ponyCharacterX      Character
hi def link ponyStringX         String
hi def link ponyDocumentStringX String


let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = 'pony'

endif
