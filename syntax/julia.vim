" Vim syntax file
" Language:	julia
" Maintainer:	Carlo Baldassi <carlobaldassi@gmail.com>
" Last Change:	2013 feb 11

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax cluster juliaExpressions		contains=@juliaParItems,@juliaStringItems,@juliaKeywordItems,@juliaBlocksItems,@juliaTypesItems,@juliaConstItems,@juliaMacroItems,@juliaOperatorItems,@juliaNumberItems,@juliaQuotedItems,@juliaCommentItems,@juliaErrorItems
syntax cluster juliaExprsPrintf		contains=@juliaExpressions,@juliaPrintfItems

syntax cluster juliaParItems		contains=juliaParBlock,juliaSqBraBlock,juliaCurBraBlock
syntax cluster juliaKeywordItems	contains=juliaKeyword,juliaRepKeyword,juliaTypedef
syntax cluster juliaBlocksItems		contains=juliaConditionalBlock,juliaRepeatBlock,juliaBeginBlock,juliaFunctionBlock,juliaMacroBlock,juliaQuoteBlock,juliaTypeBlock,juliaImmutableBlock,juliaExceptionBlock,juliaLetBlock,juliaDoBlock,juliaModuleBlock
syntax cluster juliaTypesItems		contains=juliaBuiltinTypeBasic,juliaBuiltinTypeNum,juliaBuiltinTypeC,juliaBuiltinTypeError,juliaBuiltinTypeIter,juliaBuiltinTypeString,juliaBuiltinTypeArray,juliaBuiltinTypeDict,juliaBuiltinTypeSet,juliaBuiltinTypeIO,juliaBuiltinTypeProcess,juliaBuiltinTypeRange,juliaBuiltinTypeRegex,juliaBuiltinTypeFact,juliaBuitinTypeFact,juliaBuiltinTypeSpecial,juliaBuiltinTypeRandom,juliaBuiltinTypeDisplay,juliaBuiltinTypeOther
syntax cluster juliaConstItems		contains=juliaConstNum,juliaConstBool,juliaConstEnv,juliaConstIO,juliaConstMMap,juliaConstC,juliaConstGeneric
syntax cluster juliaMacroItems		contains=juliaMacro,juliaDollarVar,juliaPrintfMacro
syntax cluster juliaNumberItems		contains=juliaNumbers
syntax cluster juliaStringItems		contains=juliaChar,juliaString,juliabString,juliavString,juliaipString,juliaMIMEString,juliaTriString,juliaShellString,juliaRegEx
syntax cluster juliaPrintfItems		contains=juliaPrintfParBlock,juliaPrintfString
syntax cluster juliaOperatorItems	contains=juliaArithOperator,juliaBitOperator,juliaRedirOperator,juliaBoolOperator,juliaCompOperator,juliaAssignOperator,juliaRangeOperator,juliaTypeOperator,juliaFuncOperator,juliaCTransOperator,juliaVarargOperator,juliaTernaryRegion
syntax cluster juliaQuotedItems		contains=juliaQuotedEnd,juliaQuotedBlockKeyword,juliaQuotedQuestion
syntax cluster juliaCommentItems	contains=juliaCommentL,juliaCommentM
syntax cluster juliaErrorItems		contains=juliaErrorPar,juliaErrorEnd,juliaErrorElse

syntax match   juliaErrorPar		display "[])}]"
syntax match   juliaErrorEnd		display "\<end\>"
syntax match   juliaErrorElse		display "\<\%(else\|elseif\)\>"
syntax match   juliaErrorCatch		display "\<catch\>"
syntax match   juliaErrorSemicol	display contained ";"

syntax match   juliaQuotedEnd		display ":\@<=end\>"
syntax match   juliaRangeEnd		display contained "\<end\>"

syntax region  juliaParBlock		matchgroup=juliaParDelim start="(" end=")" contains=@juliaExpressions
syntax region  juliaParBlockInRange	matchgroup=juliaParDelim contained start="(" end=")" contains=@juliaExpressions,juliaParBlockInRange,juliaRangeEnd
syntax region  juliaSqBraBlock		matchgroup=juliaParDelim start="\[" end="\]" contains=@juliaExpressions,juliaParBlockInRange,juliaRangeEnd,juliaComprehensionFor
syntax region  juliaCurBraBlock		matchgroup=juliaParDelim start="{" end="}" contains=@juliaExpressions,juliaComprehensionFor

syntax match   juliaKeyword		"\<\%(return\|local\|global\|import\%(all\)\?\|export\|using\|const\|in\)\>"
syntax match   juliaRepKeyword		"\<\%(break\|continue\)\>"
syntax region  juliaConditionalBlock	matchgroup=juliaConditional start="\<if\>" end="\<end\>" contains=@juliaExpressions,juliaConditionalEIBlock,juliaConditionalEBlock fold
syntax region  juliaConditionalEIBlock	matchgroup=juliaConditional transparent contained start="\<elseif\>" end="\<\%(end\|else\|elseif\)\>"me=s-1 contains=@juliaExpressions,juliaConditionalEIBlock,juliaConditionalEBlock
syntax region  juliaConditionalEBlock	matchgroup=juliaConditional transparent contained start="\<else\>" end="\<end\>"me=s-1 contains=@juliaExpressions
syntax region  juliaRepeatBlock		matchgroup=juliaRepeat start="\<\%(while\|for\)\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaBeginBlock		matchgroup=juliaBlKeyword start="\<begin\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaFunctionBlock	matchgroup=juliaBlKeyword start="\<\%(staged\)\?function\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaMacroBlock		matchgroup=juliaBlKeyword start="\<macro\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaQuoteBlock		matchgroup=juliaBlKeyword start="\<quote\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaTypeBlock		matchgroup=juliaBlKeyword start="\<type\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaImmutableBlock	matchgroup=juliaBlKeyword start="\<immutable\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaLetBlock		matchgroup=juliaBlKeyword start="\<let\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaDoBlock		matchgroup=juliaBlKeyword start="\<do\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaModuleBlock		matchgroup=juliaBlKeyword start="\%(\.\s*\)\@<!\<\%(bare\)\?module\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaExceptionBlock	matchgroup=juliaException start="\<try\>" end="\<end\>" contains=@juliaExpressions,juliaCatchBlock,juliaFinallyBlock fold
syntax region  juliaCatchBlock		matchgroup=juliaException transparent contained start="\<catch\>" end="\<end\>"me=s-1 contains=@juliaExpressions,juliaFinallyBlock
syntax region  juliaFinallyBlock	matchgroup=juliaException transparent contained start="\<finally\>" end="\<end\>"me=s-1 contains=@juliaExpressions
syntax match   juliaTypedef		"\<\%(abstract\|typealias\|bitstype\)\>"

syntax match   juliaComprehensionFor    contained "\<for\>"

syntax match   juliaBuiltinTypeBasic	display "\<\%(Tuple\|NTuple\|Symbol\|\%(Intrinsic\)\?Function\|Union\|Type\%(Name\|Constructor\|Var\)\?\|Any\|ANY\|Vararg\|Top\|None\|Nothing\|Ptr\|Void\|Exception\|Module\|Box\|Expr\|LambdaStaticData\|\%(Data\|Union\)Type\|\%(LineNumber\|Label\|Goto\|Quote\|Top\|Symbol\|Getfield\)Node\|WeakRef\|Associative\|Method\(Table\)\?\)\>"
syntax match   juliaBuiltinTypeNum	display "\<\%(Uint\%(\|8\|16\|32\|64\|128\)\|Int\%(eger\|8\|16\|32\|64\|128\)\?\|Float\%(ingPoint\|16\|32\|64\)\|Complex\%(32\|64\|128\)\?\|Bool\|Char\|Number\|Signed\|Unsigned\|Real\|Rational\|BigInt\|BigFloat\|MathConst\)\>"
syntax match   juliaBuiltinTypeC	display "\<\%(FileOffset\|C\%(u\?\%(char\|short\|int\|long\(long\)\?\)\|float\|double\|\%(ptrdiff\|s\?size\|wchar\|off\)_t\)\)\>"
syntax match   juliaBuiltinTypeError	display "\<\%(\%(Bounds\|Divide\|Domain\|Memory\|\%(Stack\)\?Overflow\|EOF\|Undef\%(Ref\|Var\)\|System\|Type\|Parse\|Argument\|Key\|Load\|Method\|Inexact\)Error\|\%(Interrupt\|Error\|ProcessExited\)Exception\|DimensionMismatch\)\>"
syntax match   juliaBuiltinTypeIter	display "\<\%(EachLine\|Enumerate\|Zip\|Filter\)\>"
syntax match   juliaBuiltinTypeString	display "\<\%(DirectIndex\|ASCII\|UTF\%(8\|16\|32\)\|Byte\|Sub\|Rep\|Rev\|Rope\|W\)\?String\>"
syntax match   juliaBuiltinTypeArray	display "\<\%(D\?Array\|\%(Abstract\|Dense\|Strided\)\?\%(Array\|Matrix\|Vec\%(tor\|OrMat\)\)\|SparseMatrixCSC\|Sub\%(Array\|\%(Or\)\?DArray\)\|\%(AbstractSparse\|Bit\|Shared\)\%(Array\|Vector\|Matrix\)\|\%\(D\|Bid\|\%(Sym\)\?Trid\)iagonal\|Woodbury\|Triangular\|Hermitian\|Symmetric\|UniformScaling\)\>"
syntax match   juliaBuiltinTypeDict	display "\<\%(WeakKey\|ObjectId\)\?Dict\>"
syntax match   juliaBuiltinTypeSet	display "\<\%(Int\)\?Set\>"
syntax match   juliaBuiltinTypeIO	display "\<\%(IO\%(Stream\|Buffer\)\?\|CFILE\|Base64Pipe\|RawFD\|StatStruct\|DevNull\|FileMonitor\|PollingFileWatcher\|Timer\|UdpSocket\)\>"
syntax match   juliaBuiltinTypeProcess	display "\<\%(ProcessGroup\|PipeBuffer\|Cmd\)\>"
syntax match   juliaBuiltinTypeRange	display "\<\%(Dims\|Range\%(Index\)\?\|\(Ordinal\|Step\|Unit\|Float\)Range\|Colon\)\>"
syntax match   juliaBuiltinTypeRegex	display "\<Regex\%(Match\)\?\>"
syntax match   juliaBuiltinTypeFact	display "\<Factorization\>"
syntax match   juliaBuiltinTypeSort	display "\<\%(Insertion\|Quick\|Merge\)Sort\>"
syntax match   juliaBuiltinTypeRound	display "\<Round\%(ingMode\|FromZero\|Down\|Nearest\|ToZero\|Up\)\>"
syntax match   juliaBuiltinTypeSpecial	display "\<\%(LocalProcess\|ClusterManager\)\>"
syntax match   juliaBuiltinTypeRandom	display "\<\%(AbstractRNG\|MersenneTwister\)\>"
syntax match   juliaBuiltinTypeDisplay	display "\<\%(\%(Text\)\?Display\|MIME\)\>"
syntax match   juliaBuiltinTypeOther	display "\<\%(RemoteRef\|Task\|Condition\|VersionNumber\|TmStruct\|IPv[46]\)\>"

syntax match   juliaConstNum		display "\<\%(NaN\%(16\|32\)\?\|Inf\%(16\|32\)\?\|eu\?\|pi\|π\|eulergamma\|γ\|catalan\|φ\|golden\)\>"
syntax match   juliaConstBool		display "\<\%(true\|false\)\>"
syntax match   juliaConstEnv		display "\<\%(ARGS\|ENV\|CPU_CORES\|OS_NAME\|ENDIAN_BOM\|\%(DL_\)\?LOAD_PATH\|VERSION\|JULIA_HOME\)\>"
syntax match   juliaConstIO		display "\<\%(STD\%(OUT\|IN\|ERR\)\)\>"
syntax match   juliaConstMMap		display "\<\%(MS_\%(A\?SYNC\|INVALIDATE\)\)\>"
syntax match   juliaConstC		display "\<\%(WORD_SIZE\|C_NULL\|RTLD_\%(LOCAL\|GLOBAL\|LAZY\|NOW\|NOLOAD\|NODELETE\|DEEPBIND\|FIRST\)\)\>"
syntax match   juliaConstGeneric	display "\<\%(nothing\|Main\)\>"

syntax match   juliaMacro		display "@[_[:alpha:]][_[:alnum:]!]*\%(\.[_[:alpha:]][_[:alnum:]!]*\)*"

syntax match   juliaNumbers		display transparent "\<\d\|\.\d\|\<im\>" contains=juliaNumber,juliaFloat,juliaComplexUnit

"decimal number
syntax match   juliaNumber		display contained "\d\%(_\?\d\)*\%(\>\|im\>\|\ze\D\)" contains=juliaComplexUnit
"hex number
syntax match   juliaNumber		display contained "0x\x\%(_\?\x\)*\%(\>\|im\>\|\ze\X\)" contains=juliaComplexUnit
"bin number
syntax match   juliaNumber		display contained "0b[01]\%(_\?[01]\)*\%(\>\|im\>\|\ze[^01]\)" contains=juliaComplexUnit
"oct number
syntax match   juliaNumber		display contained "0o\o\%(_\?\o\)*\%(\>\|im\>\|\ze\O\)" contains=juliaComplexUnit
"floating point number, starting with a dot, optional exponent
syntax match   juliaFloat		display contained "\.\d\%(_\?\d\)*\%([eEf][-+]\?\d\+\)\?\%(\>\|im\>\|\ze\D\)" contains=juliaComplexUnit
"floating point number, with dot, optional exponent
syntax match   juliaFloat		display contained "\d\%(_\?\d\)*\.\%(\d\%(_\?\d\)*\)\?\%([eEf][-+]\?\d\+\)\?\%(\>\|im\>\|\ze\D\)" contains=juliaComplexUnit
"floating point number, without dot, with exponent
syntax match   juliaFloat		display contained "\d\%(_\?\d\)*[eEf][-+]\?\d\+\%(\>\|im\>\|\ze\D\)" contains=juliaComplexUnit

"hex floating point number, starting with a dot
syntax match   juliaFloat		display contained "0x\.\%\(\x\%(_\?\x\)*\)\?[pP][-+]\?\d\+\%(\>\|im\>\|\ze\X\)" contains=juliaComplexUnit
"hex floating point number, starting with a digit
syntax match   juliaFloat		display contained "0x\x\%(_\?\x\)*\%\(\.\%\(\x\%(_\?\x\)*\)\?\)\?[pP][-+]\?\d\+\%(\>\|im\>\|\ze\X\)" contains=juliaComplexUnit

syntax match   juliaComplexUnit		display	contained "\<im\>"

syntax match   juliaArithOperator	"\%(//\|√\|∛\|\.\?\%(//\|\\\|[-+*%/^÷⋅×⊛⊖⊗⊘⊙⊚⊛⫽]\)\)"
syntax match   juliaSetOperator		"[∪∩∈∉∋∌⊆⊈⊊]"
syntax match   juliaCompOperator	"\.\?[<>]"
syntax match   juliaBitOperator		"\%(<<\|>>>\|>>\|&\||\|\~\|\$\)"
syntax match   juliaRedirOperator	"\%(|>\|<|\)"
syntax match   juliaBoolOperator	"\%(&&\|||\|!\|[∧∨]\)"
syntax match   juliaCompOperator	"\.\?\%([<>]=\|!=\|==\|[≤≥≠≡≢]\)"
syntax match   juliaAssignOperator	"\%([$|\&*/\\%+-]\|<<\|>>>\|>>\)\?="
syntax match   juliaRangeOperator	":"
syntax match   juliaTypeOperator	"\%(<:\|::\)"
syntax match   juliaFuncOperator	"->"
syntax match   juliaVarargOperator	"\.\{3\}"
syntax region  juliaTernaryRegion	matchgroup=juliaTernaryOperator start="?" skip="::" end=":" contains=@juliaExpressions,juliaErrorSemicol

" TODO: this is very greedy. Improve?
syntax match   juliaDollarVar		contained "[[:alnum:]_]\@<!$[_[:alpha:]][_[:alnum:]!]*"

syntax match   juliaChar		display "'\\\?.'" contains=juliaSpecialChar
syntax match   juliaChar		display "'\\\o\{3\}'" contains=juliaOctalEscapeChar
syntax match   juliaChar		display "'\\x\x\{2\}'" contains=juliaHexEscapeChar
syntax match   juliaChar		display "'\\u\x\{1,4\}'" contains=juliaUniCharSmall
syntax match   juliaChar		display "'\\U\x\{1,8\}'" contains=juliaUniCharLarge

syntax match   juliaCTransOperator	"[])}[:alnum:]_]\@<=\.\?'"

syntax region  juliaString		matchgroup=juliaStringDelim start=+"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaStringVars,@juliaSpecialChars
syntax region  juliabString		matchgroup=juliaStringDelim start=+\<b"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaSpecialChars
syntax region  juliavString		matchgroup=juliaStringDelim start=+\<v"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaSpecialChars
syntax region  juliaipString		matchgroup=juliaStringDelim start=+\<ip"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaSpecialChars
syntax region  juliaMIMEString		matchgroup=juliaStringDelim start=+\<MIME"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaSpecialChars

syntax region  juliaTriString		matchgroup=juliaStringDelim start=+"""+ skip=+\%(\\\\\)*\\"+ end=+"""+ contains=@juliaStringVars,@juliaSpecialChars

syntax region  juliaPrintfMacro		transparent start="@s\?printf(" end=")\@<=" contains=juliaMacro,juliaPrintfParBlock
syntax region  juliaPrintfMacro		transparent start="@s\?printf\s\+" end="\n" contains=@juliaExprsPrintf
syntax region  juliaPrintfParBlock	contained matchgroup=juliaParDelim start="(" end=")" contains=@juliaExprsPrintf
syntax region  juliaPrintfString	contained matchgroup=juliaStringDelim start=+"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaSpecialChars,@juliaPrintfChars

syntax region  juliaShellString		matchgroup=juliaStringDelim start=+`+ skip=+\%(\\\\\)*\\`+ end=+`+ contains=@juliaStringVars,juliaSpecialChar

syntax cluster juliaStringVars		contains=juliaStringVarsPar,juliaStringVarsSqBra,juliaStringVarsCurBra,juliaStringVarsPla
syntax region  juliaStringVarsPar	contained matchgroup=juliaStringVarDelim start="$(" end=")" contains=@juliaExpressions
syntax region  juliaStringVarsSqBra	contained matchgroup=juliaStringVarDelim start="$\[" end="\]" contains=@juliaExpressions
syntax region  juliaStringVarsCurBra	contained matchgroup=juliaStringVarDelim start="${" end="}" contains=@juliaExpressions
syntax match   juliaStringVarsPla	contained "$[_[:alpha:]][_[:alnum:]]*"

" TODO improve RegEx
syntax region  juliaRegEx		matchgroup=juliaStringDelim start=+\<r"+ skip=+\%(\\\\\)*\\"+ end=+"[imsx]*+

syntax cluster juliaSpecialChars	contains=juliaSpecialChar,juliaOctalEscapeChar,juliaHexEscapeChar,juliaUniCharSmall,juliaUniCharLarge
syntax match   juliaSpecialChar		contained "\\."
syntax match   juliaOctalEscapeChar	contained "\\\o\{3\}"
syntax match   juliaHexEscapeChar	contained "\\x\x\{2\}"
syntax match   juliaUniCharSmall	contained "\\u\x\{1,4\}"
syntax match   juliaUniCharLarge	contained "\\U\x\{1,8\}"

syntax cluster juliaPrintfChars		contains=juliaErrorPrintfFmt,juliaPrintfFmt
syntax match   juliaErrorPrintfFmt	display contained "\\\?%."
syntax match   juliaPrintfFmt		display contained "%\%(\d\+\$\)\=[-+' #0]*\%(\d*\|\*\|\*\d\+\$\)\%(\.\%(\d*\|\*\|\*\d\+\$\)\)\=\%([hlLjqzt]\|ll\|hh\)\=[aAbdiuoxXDOUfFeEgGcCsSpn]"
syntax match   juliaPrintfFmt		display contained "%%"
syntax match   juliaPrintfFmt		display contained "\\%\%(\d\+\$\)\=[-+' #0]*\%(\d*\|\*\|\*\d\+\$\)\%(\.\%(\d*\|\*\|\*\d\+\$\)\)\=\%([hlLjqzt]\|ll\|hh\)\=[aAbdiuoxXDOUfFeEgGcCsSpn]"hs=s+1
syntax match   juliaPrintfFmt		display contained "\\%%"hs=s+1

syntax match   juliaQuotedBlockKeyword	display ":\s*\%(if\|elseif\|else\|while\|for\|begin\|\%(staged\)\?function\|macro\|quote\|type\|immutable\|try\|catch\|let\|\%(bare\)\?module\|do\)\>"he=s+1 contains=juliaInQuote
syntax match   juliaQuotedQuestion      display ":\s*\%(?\|(\s*?\s*)\)"he=s+1 contains=juliaInQuote
syntax match   juliaInQuote             display contained ":\zs\s*[^])}[:space:],;]\+"

syntax region  juliaCommentL		matchgroup=juliaCommentDelim start="#\ze\%([^=]\|$\)" end="$" keepend contains=juliaTodo,@spell
syntax region  juliaCommentM		matchgroup=juliaCommentDelim start="#=\ze\%([^#]\|$\)" end="=#" contains=juliaTodo,juliaCommentM,@spell
syntax keyword juliaTodo		contained TODO FIXME XXX


hi def link juliaParDelim		juliaNone

hi def link juliaKeyword		Keyword
hi def link juliaRepKeyword		Keyword
hi def link juliaBlKeyword		Keyword
hi def link juliaConditional		Conditional
hi def link juliaRepeat			Repeat
hi def link juliaException		Exception
hi def link juliaTypedef		Typedef
hi def link juliaBuiltinTypeBasic	Type
hi def link juliaBuiltinTypeNum		Type
hi def link juliaBuiltinTypeC		Type
hi def link juliaBuiltinTypeError	Type
hi def link juliaBuiltinTypeIter	Type
hi def link juliaBuiltinTypeString	Type
hi def link juliaBuiltinTypeArray	Type
hi def link juliaBuiltinTypeDict	Type
hi def link juliaBuiltinTypeSet		Type
hi def link juliaBuiltinTypeIO		Type
hi def link juliaBuiltinTypeProcess	Type
hi def link juliaBuiltinTypeRange	Type
hi def link juliaBuiltinTypeRegex	Type
hi def link juliaBuiltinTypeFact	Type
hi def link juliaBuiltinTypeSort	Type
hi def link juliaBuiltinTypeRound	Type
hi def link juliaBuiltinTypeSpecial	Type
hi def link juliaBuiltinTypeRandom	Type
hi def link juliaBuiltinTypeDisplay	Type
hi def link juliaBuiltinTypeOther	Type
hi def link juliaConstNum		Constant
hi def link juliaConstEnv		Constant
hi def link juliaConstIO		Constant
hi def link juliaConstMMap		Constant
hi def link juliaConstC 		Constant
hi def link juliaConstLimits		Constant
hi def link juliaConstGeneric		Constant
hi def link juliaRangeEnd		Constant
hi def link juliaConstBool		Boolean

hi def link juliaComprehensionFor	Keyword

hi def link juliaDollarVar		Identifier

hi def link juliaMacro			Macro

hi def link juliaNumber			Number
hi def link juliaFloat			Float
hi def link juliaComplexUnit		Constant

hi def link juliaChar			Character

hi def link juliaString			String
hi def link juliabString		String
hi def link juliavString		String
hi def link juliarString		String
hi def link juliaipString		String
hi def link juliaMIMEString		String
hi def link juliaTriString		String
hi def link juliaPrintfString		String
hi def link juliaShellString		String
hi def link juliaStringDelim		String
hi def link juliaStringVarsPla		Identifier
hi def link juliaStringVarDelim		Delimiter

hi def link juliaRegEx			String

hi def link juliaSpecialChar		SpecialChar
hi def link juliaOctalEscapeChar	SpecialChar
hi def link juliaHexEscapeChar		SpecialChar
hi def link juliaUniCharSmall		SpecialChar
hi def link juliaUniCharLarge		SpecialChar

hi def link juliaPrintfFmt		SpecialChar

if exists("g:julia_highlight_operators")
  hi def link juliaOperator		Operator
else
  hi def link juliaOperator		juliaNone
endif
hi def link juliaArithOperator		juliaOperator
hi def link juliaSetOperator		juliaOperator
hi def link juliaBitOperator		juliaOperator
hi def link juliaRedirOperator		juliaOperator
hi def link juliaBoolOperator		juliaOperator
hi def link juliaCompOperator		juliaOperator
hi def link juliaAssignOperator		juliaOperator
hi def link juliaRangeOperator		juliaOperator
hi def link juliaTypeOperator		juliaOperator
hi def link juliaFuncOperator		juliaOperator
hi def link juliaCTransOperator		juliaOperator
hi def link juliaVarargOperator		juliaOperator
hi def link juliaTernaryOperator	juliaOperator

"hi def link juliaQuotedEnd              juliaOperator
hi def link juliaQuotedBlockKeyword	juliaOperator
hi def link juliaQuotedQuestion 	juliaOperator

hi def link juliaCommentL		Comment
hi def link juliaCommentM		Comment
hi def link juliaCommentDelim		Comment
hi def link juliaTodo			Todo

hi def link juliaErrorPar		juliaError
hi def link juliaErrorEnd		juliaError
hi def link juliaErrorElse		juliaError
hi def link juliaErrorCatch		juliaError
hi def link juliaErrorSemicol		juliaError
hi def link juliaErrorPrintfFmt		juliaError

hi def link juliaError			Error

syntax sync fromstart

let b:current_syntax = "julia"
