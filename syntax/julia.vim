if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1
  
" Vim syntax file
" Language:	julia
" Maintainer:	Carlo Baldassi <carlobaldassi@gmail.com>
" Last Change:	2013 feb 11

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version < 704
  " this is used to disable regex syntax like `\@3<='
  " on older vim versions
  function! s:d(x)
    return ''
  endfunction
else
  function! s:d(x)
    return string(a:x)
  endfunction
endif

scriptencoding utf-8

if !exists("b:julia_syntax_version")
  let b:julia_syntax_version = get(g:, "default_julia_version", "current")
endif
if !exists("b:julia_syntax_highlight_deprecated")
  let b:julia_syntax_highlight_deprecated = get(g:, "julia_syntax_highlight_deprecated", 0)
endif

if b:julia_syntax_version =~? '\<\%(curr\%(ent\)\?\|release\|6\|0\.6\)\>'
  let b:julia_syntax_version = 6
elseif b:julia_syntax_version =~? '\<\%(next\|devel\|7\|0\.7\)\>'
  let b:julia_syntax_version = 7
elseif b:julia_syntax_version =~? '\<\%(prev\%(ious\)\?\|legacy\|5\|0\.5\)\>'
  let b:julia_syntax_version = 5
else
  echohl WarningMsg | echomsg "Unrecognized or unsupported julia syntax version: " . b:julia_syntax_version | echohl None
  let b:julia_syntax_version = 6
endif

let s:julia_spellcheck_strings = get(g:, "julia_spellcheck_strings", 0)
let s:julia_spellcheck_docstrings = get(g:, "julia_spellcheck_docstrings", 1)
let s:julia_spellcheck_comments = get(g:, "julia_spellcheck_comments", 1)

let s:julia_highlight_operators = get(g:, "julia_highlight_operators", 1)

" characters which cannot be used in identifiers. This list is very incomplete:
" 1) it only cares about charactes below 256
" 2) it doesn't distinguish between what's allowed as the 1st char vs in the
"    rest of an identifier (e.g. digits, `!` and `?`)
" Despite these shortcomings, it seems to do a decent job.
" note: \U5B and \U5D are '[' and ']'
let s:nonid_chars = "\U01-\U07" . "\U0E-\U1F" .
      \             "\"#$'(,.:;=@`\\U5B{" .
      \             "\U80-\UA1" . "\UA7\UA8\UAB\UAD\UAF\UB4" . "\UB6-\UB8" . "\UBB\UBF"

let s:nonidS_chars = "[:space:])\\U5D}" . s:nonid_chars

" the following excludes '!' since it can be used as an identifier,
" and '$' since it can be used in interpolations
" note that \U2D is '-'
let s:uniop_chars = "+\\U2D~¬√∛∜"

let s:binop_chars = "=+\\U2D*/\\%÷^&|⊻<>≤≥≡≠≢∈∉⋅×∪∩⊆⊈⊂⊄⊊←→∋∌⊕⊖⊞⊟∘∧⊗⊘↑↓∨⊠±"

" the following is a list of all remainig valid operator chars,
" but it's more efficient when expressed with ranges (see below)
" let s:binop_chars_extra = "↔↚↛↠↣↦↮⇎⇏⇒⇔⇴⇶⇷⇸⇹⇺⇻⇼⇽⇾⇿⟵⟶⟷⟷⟹⟺⟻⟼⟽⟾⟿⤀⤁⤂⤃⤄⤅⤆⤇⤌⤍⤎⤏⤐⤑⤔⤕⤖⤗⤘⤝⤞⤟⤠⥄⥅⥆⥇⥈⥊⥋⥎⥐⥒⥓⥖⥗⥚⥛⥞⥟⥢⥤⥦⥧⥨⥩⥪⥫⥬⥭⥰⧴⬱⬰⬲⬳⬴⬵⬶⬷⬸⬹⬺⬻⬼⬽⬾⬿⭀⭁⭂⭃⭄⭇⭈⭉⭊⭋⭌￩￫" .
"       \                   "∝∊∍∥∦∷∺∻∽∾≁≃≄≅≆≇≈≉≊≋≌≍≎≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≣≦≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊃⊅⊇⊉⊋⊏⊐⊑⊒⊜⊩⊬⊮⊰⊱⊲⊳⊴⊵⊶⊷⋍⋐⋑⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿⟈⟉⟒⦷⧀⧁⧡⧣⧤⧥⩦⩧⩪⩫⩬⩭⩮⩯⩰⩱⩲⩳⩴⩵⩶⩷⩸⩹⩺⩻⩼⩽⩾⩿⪀⪁⪂⪃⪄⪅⪆⪇⪈⪉⪊⪋⪌⪍⪎⪏⪐⪑⪒⪓⪔⪕⪖⪗⪘⪙⪚⪛⪜⪝⪞⪟⪠⪡⪢⪣⪤⪥⪦⪧⪨⪩⪪⪫⪬⪭⪮⪯⪰⪱⪲⪳⪴⪵⪶⪷⪸⪹⪺⪻⪼⪽⪾⪿⫀⫁⫂⫃⫄⫅⫆⫇⫈⫉⫊⫋⫌⫍⫎⫏⫐⫑⫒⫓⫔⫕⫖⫗⫘⫙⫷⫸⫹⫺⊢⊣" .
"       \                   "⊔∓∔∸≂≏⊎⊽⋎⋓⧺⧻⨈⨢⨣⨤⨥⨦⨧⨨⨩⨪⨫⨬⨭⨮⨹⨺⩁⩂⩅⩊⩌⩏⩐⩒⩔⩖⩗⩛⩝⩡⩢⩣" .
"       \                   "⊙⊚⊛⊡⊓∗∙∤⅋≀⊼⋄⋆⋇⋉⋊⋋⋌⋏⋒⟑⦸⦼⦾⦿⧶⧷⨇⨰⨱⨲⨳⨴⨵⨶⨷⨸⨻⨼⨽⩀⩃⩄⩋⩍⩎⩑⩓⩕⩘⩚⩜⩞⩟⩠⫛⊍▷⨝⟕⟖⟗" .
"       \                   "⇵⟰⟱⤈⤉⤊⤋⤒⤓⥉⥌⥍⥏⥑⥔⥕⥘⥙⥜⥝⥠⥡⥣⥥⥮⥯￪￬"

" same as above, but with character ranges, for performance
let s:binop_chars_extra = "\\U214B\\U2190-\\U2194\\U219A\\U219B\\U21A0\\U21A3\\U21A6\\U21AE\\U21CE\\U21CF\\U21D2\\U21D4\\U21F4-\\U21FF\\U2208-\\U220D\\U2213\\U2214\\U2217-\\U2219\\U221D\\U2224-\\U222A\\U2237\\U2238\\U223A\\U223B\\U223D\\U223E\\U2240-\\U228B\\U228D-\\U229C\\U229E-\\U22A3\\U22A9\\U22AC\\U22AE\\U22B0-\\U22B7\\U22BB-\\U22BD\\U22C4-\\U22C7\\U22C9-\\U22D3\\U22D5-\\U22ED\\U22F2-\\U22FF\\U25B7\\U27C8\\U27C9\\U27D1\\U27D2\\U27D5-\\U27D7\\U27F0\\U27F1\\U27F5-\\U27F7\\U27F7\\U27F9-\\U27FF\\U2900-\\U2918\\U291D-\\U2920\\U2944-\\U2970\\U29B7\\U29B8\\U29BC\\U29BE-\\U29C1\\U29E1\\U29E3-\\U29E5\\U29F4\\U29F6\\U29F7\\U29FA\\U29FB\\U2A07\\U2A08\\U2A1D\\U2A22-\\U2A2E\\U2A30-\\U2A3D\\U2A40-\\U2A45\\U2A4A-\\U2A58\\U2A5A-\\U2A63\\U2A66\\U2A67\\U2A6A-\\U2AD9\\U2ADB\\U2AF7-\\U2AFA\\U2B30-\\U2B44\\U2B47-\\U2B4C\\UFFE9-\\UFFEC"

" a Julia identifier, sort of (TODO: the special case of a lone `?` should be
" removed as soon as the Julia parser is fixed)
let s:idregex = '\%([^' . s:nonidS_chars . '0-9!?' . s:uniop_chars . s:binop_chars . '][^' . s:nonidS_chars . s:uniop_chars . s:binop_chars . s:binop_chars_extra . ']*\|\<?\>\)'

let s:operators = '\%(' . '\.\%([-+*/^÷%|&!]\|//\|\\\|<<\|>>>\?\)\?=' .
      \           '\|'  . '[:$<>]=\|||\|&&\||>\|<|\|<:\|>:\|::\|<<\|>>>\?\|//\|[-=]>\|\.\{3\}' .
      \           '\|'  . '[' . s:uniop_chars . '!$]' .
      \           '\|'  . '\.\?[' . s:binop_chars . s:binop_chars_extra . ']' .
      \           '\)'

syn case match

syntax cluster juliaExpressions		contains=@juliaParItems,@juliaStringItems,@juliaKeywordItems,@juliaBlocksItems,@juliaTypesItems,@juliaConstItems,@juliaMacroItems,@juliaSymbolItems,@juliaOperatorItems,@juliaNumberItems,@juliaCommentItems,@juliaErrorItems
syntax cluster juliaExprsPrintf		contains=@juliaExpressions,@juliaPrintfItems

syntax cluster juliaParItems		contains=juliaParBlock,juliaSqBraBlock,juliaCurBraBlock,juliaQuotedParBlock,juliaQuotedQMarkPar
syntax cluster juliaKeywordItems	contains=juliaKeyword,juliaInfixKeyword,juliaRepKeyword,juliaTypedef
if b:julia_syntax_version == 5
  syntax cluster juliaBlocksItems	contains=@juliaBlocksItemsAll
else
  syntax cluster juliaBlocksItems	contains=@juliaBlocksItemsAll,@juliaBlocksItems0607
endif
syntax cluster juliaBlocksItemsAll	contains=juliaConditionalBlock,juliaWhileBlock,juliaForBlock,juliaBeginBlock,juliaFunctionBlock,juliaMacroBlock,juliaQuoteBlock,juliaTypeBlock,juliaImmutableBlock,juliaExceptionBlock,juliaLetBlock,juliaDoBlock,juliaModuleBlock
syntax cluster juliaBlocksItems0607	contains=juliaStructBlock,juliaMutableStructBlock,juliaAbstractBlock,juliaPrimitiveBlock
if b:julia_syntax_version == 5
  syntax cluster juliaTypesItems	contains=@juliaTypesItemsAll,@juliaTypesItems05,@juliaTypesItems0506
elseif b:julia_syntax_version == 6
  syntax cluster juliaTypesItems	contains=@juliaTypesItemsAll,@juliaTypesItems05,@juliaTypesItems0506,@juliaTypesItems0607
else
  syntax cluster juliaTypesItems	contains=@juliaTypesItemsAll,@juliaTypesItems05,@juliaTypesItems0506,@juliaTypesItems0607,@juliaTypesItems07
endif
syntax cluster juliaTypesItemsAll	contains=juliaBaseTypeBasic,juliaBaseTypeNum,juliaBaseTypeC,juliaBaseTypeError,juliaBaseTypeIter,juliaBaseTypeString,juliaBaseTypeArray,juliaBaseTypeDict,juliaBaseTypeSet,juliaBaseTypeIO,juliaBaseTypeProcess,juliaBaseTypeRange,juliaBaseTypeRegex,juliaBaseTypeFact,juliaBaseTypeFact,juliaBaseTypeSort,juliaBaseTypeRound,juliaBaseTypeSpecial,juliaBaseTypeRandom,juliaBaseTypeDisplay,juliaBaseTypeTime,juliaBaseTypeOther
syntax cluster juliaTypesItems05	contains=juliaBaseTypeIter05,juliaBaseTypeRange05
syntax cluster juliaTypesItems0506	contains=juliaBaseTypeNum0506,juliaBaseTypeRange0506,juliaBaseTypeDict0506,juliaBaseTypeSet0506
syntax cluster juliaTypesItems0607	contains=juliaBaseTypeBasic0607,juliaBaseTypeArray0607,juliaBaseTypeSet0607,juliaBaseTypeProcess0607,juliaBaseTypeRange0607,juliaBaseTypeTime0607
syntax cluster juliaTypesItems07	contains=juliaBaseTypeBasic07,juliaBaseTypeNum07,juliaBaseTypeError07,juliaBaseTypeIter07,juliaBaseTypeRange07,juliaBaseTypeArray07,juliaBaseTypeDict07,juliaBaseTypeSet07,juliaBaseTypeC07,juliaBaseTypeDisplay07,juliaBaseTypeIO07

syntax cluster juliaConstItemsAll	contains=juliaConstNum,juliaConstBool,juliaConstEnv,juliaConstMMap,juliaConstC,juliaConstGeneric
syntax cluster juliaConstItems0506	contains=juliaConstNum0506,juliaConstIO0506
syntax cluster juliaConstItems07	contains=juliaConstGeneric07,juliaPossibleEuler,juliaConstEnv07,juliaConstIO07
if b:julia_syntax_version <= 6
  syntax cluster juliaConstItems	contains=@juliaConstItemsAll,@juliaConstItems0506
else
  syntax cluster juliaConstItems	contains=@juliaConstItemsAll,@juliaConstItems0506,@juliaConstItems07
endif

syntax cluster juliaMacroItems		contains=juliaPossibleMacro,juliaDollarVar,juliaDollarPar,juliaDollarSqBra
syntax cluster juliaSymbolItems		contains=juliaPossibleSymbol
syntax cluster juliaNumberItems		contains=juliaNumbers
syntax cluster juliaStringItems		contains=juliaChar,juliaString,juliabString,juliasString,juliavString,juliaipString,juliabigString,juliaMIMEString,juliaShellString,juliaDocString,juliaRegEx
syntax cluster juliaPrintfItems		contains=juliaPrintfParBlock,juliaPrintfString
syntax cluster juliaOperatorItems	contains=juliaOperator,juliaRangeOperator,juliaCTransOperator,juliaTernaryRegion,juliaColon,juliaSemicolon,juliaComma
syntax cluster juliaCommentItems	contains=juliaCommentL,juliaCommentM
syntax cluster juliaErrorItems		contains=juliaErrorPar,juliaErrorEnd,juliaErrorElse,juliaErrorCatch,juliaErrorFinally

syntax cluster juliaSpellcheckStrings	        contains=@spell
syntax cluster juliaSpellcheckDocStrings	contains=@spell
syntax cluster juliaSpellcheckComments	        contains=@spell

if !s:julia_spellcheck_docstrings
  syntax cluster juliaSpellcheckDocStrings      remove=@spell
endif
if !s:julia_spellcheck_strings
  syntax cluster juliaSpellcheckStrings remove=@spell
endif
if !s:julia_spellcheck_comments
  syntax cluster juliaSpellcheckComments        remove=@spell
endif

syntax match   juliaSemicolon		display ";"
syntax match   juliaComma		display ","
syntax match   juliaColon		display ":"

syntax match   juliaErrorPar		display "[])}]"
syntax match   juliaErrorEnd		display "\<end\>"
syntax match   juliaErrorElse		display "\<\%(else\|elseif\)\>"
syntax match   juliaErrorCatch		display "\<catch\>"
syntax match   juliaErrorFinally	display "\<finally\>"
syntax match   juliaErrorSemicol	display contained ";"

syntax match   juliaRangeEnd		display contained "\<end\>"

syntax region  juliaParBlock		matchgroup=juliaParDelim start="(" end=")" contains=@juliaExpressions,juliaComprehensionFor
syntax region  juliaParBlockInRange	matchgroup=juliaParDelim contained start="(" end=")" contains=@juliaExpressions,juliaParBlockInRange,juliaRangeEnd,juliaComprehensionFor
syntax region  juliaSqBraBlock		matchgroup=juliaParDelim start="\[" end="\]" contains=@juliaExpressions,juliaParBlockInRange,juliaRangeEnd,juliaComprehensionFor,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS
syntax region  juliaCurBraBlock		matchgroup=juliaParDelim start="{" end="}" contains=@juliaExpressions

if b:julia_syntax_version >= 6
  let s:keywords = '\<\%(return\|local\|global\|import\%(all\)\?\|export\|using\|const\|where\)\>'
  let s:infixkeywords = '\<\%(in\|isa\)\>'
else
  let s:keywords = '\<\%(return\|local\|global\|import\%(all\)\?\|export\|using\|const\)\>'
  let s:infixkeywords = '\<\%(in\)\>'
endif

exec 'syntax match   juliaKeyword		display "' . s:keywords . '"'
exec 'syntax match   juliaInfixKeyword		display "\%(=\s*\)\@<!' . s:infixkeywords . '\S\@!\%(\s*=\)\@!"'
syntax match   juliaRepKeyword		display "\<\%(break\|continue\)\>"
syntax region  juliaConditionalBlock	matchgroup=juliaConditional start="\<if\>" end="\<end\>" contains=@juliaExpressions,juliaConditionalEIBlock,juliaConditionalEBlock fold
syntax region  juliaConditionalEIBlock	matchgroup=juliaConditional transparent contained start="\<elseif\>" end="\<\%(end\|else\|elseif\)\>"me=s-1 contains=@juliaExpressions,juliaConditionalEIBlock,juliaConditionalEBlock
syntax region  juliaConditionalEBlock	matchgroup=juliaConditional transparent contained start="\<else\>" end="\<end\>"me=s-1 contains=@juliaExpressions
syntax region  juliaWhileBlock		matchgroup=juliaRepeat start="\<while\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaForBlock		matchgroup=juliaRepeat start="\<for\>" end="\<end\>" contains=@juliaExpressions,juliaOuter fold
syntax region  juliaBeginBlock		matchgroup=juliaBlKeyword start="\<begin\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaFunctionBlock	matchgroup=juliaBlKeyword start="\<function\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaMacroBlock		matchgroup=juliaBlKeyword start="\<macro\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaQuoteBlock		matchgroup=juliaBlKeyword start="\<quote\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaTypeBlock		matchgroup=juliaBlKeyword start="\<type\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaImmutableBlock	matchgroup=juliaBlKeyword start="\<immutable\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaStructBlock		matchgroup=juliaBlKeyword start="\<struct\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaMutableStructBlock	matchgroup=juliaBlKeyword start="\<mutable struct\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaLetBlock		matchgroup=juliaBlKeyword start="\<let\>" end="\<end\>" contains=@juliaExpressions fold
syntax region  juliaDoBlock		matchgroup=juliaBlKeyword start="\<do\>" end="\<end\>" contains=@juliaExpressions fold
exec 'syntax region  juliaModuleBlock		matchgroup=juliaBlKeyword start="\%(\%(\.\s*\)\@'.s:d(6).'<!\|\%(@\s*\.\s*\)\@'.s:d(6).'<=\)\<\%(bare\)\?module\>" end="\<end\>" contains=@juliaExpressions fold'
syntax region  juliaExceptionBlock	matchgroup=juliaException start="\<try\>" end="\<end\>" contains=@juliaExpressions,juliaCatchBlock,juliaFinallyBlock fold
syntax region  juliaCatchBlock		matchgroup=juliaException transparent contained start="\<catch\>" end="\<end\>"me=s-1 contains=@juliaExpressions,juliaFinallyBlock
syntax region  juliaFinallyBlock	matchgroup=juliaException transparent contained start="\<finally\>" end="\<end\>"me=s-1 contains=@juliaExpressions
syntax match   juliaTypedef		"\<\%(abstract\|typealias\|bitstype\)\>"
" AbstractBlock needs to come after to take precedence
syntax region  juliaAbstractBlock	matchgroup=juliaBlKeyword start="\<abstract type\>" end="\<end\>" fold contains=@juliaExpressions
syntax region  juliaPrimitiveBlock	matchgroup=juliaBlKeyword start="\<primitive type\>" end="\<end\>" fold contains=@juliaExpressions

exec 'syntax region  juliaComprehensionFor	matchgroup=juliaComprehensionFor transparent contained start="\%([^[:space:],;:({[]\_s*\)\@'.s:d(80).'<=\<for\>" end="\ze[]);]" contains=@juliaExpressions,juliaComprehensionIf,juliaComprehensionFor'
syntax match   juliaComprehensionIf	contained "\<if\>"

exec 'syntax match   juliaOuter    contained "\<outer\ze\s\+' . s:idregex . '\>"'

syntax match   juliaBaseTypeBasic	display "\<\%(Tuple\|NTuple\|Symbol\|\%(Intrinsic\)\?Function\|Union\|Type\%(Name\|Constructor\|Var\)\?\|Any\|ANY\|Vararg\|Top\|None\|Nothing\|Ptr\|Void\|Exception\|Module\|Box\|Expr\|LambdaStaticData\|\%(Data\|Union\)Type\|\%(LineNumber\|Label\|Goto\|Quote\|Top\|Symbol\|Getfield\)Node\|\%(Weak\|Global\)\?Ref\|Associative\|Method\(Table\)\?\|GetfieldNode\|Nullable\|Pair\|Val\|TypeMap\%(Level\|Entry\)\)\>"
syntax match   juliaBaseTypeBasic0607	display "\<\%(UnionAll\|CodeInfo\)\>"
syntax match   juliaBaseTypeBasic07	display "\<\%(Some\|Missing\)\>"
syntax match   juliaBaseTypeNum		display "\<\%(U\?Int\%(8\|16\|32\|64\|128\)\?\|Float\%(16\|32\|64\)\|Complex\|Bool\|Char\|Number\|Signed\|Unsigned\|Integer\|AbstractFloat\|Real\|Rational\|Irrational\|Enum\|BigInt\|BigFloat\|MathConst\)\>"
syntax match   juliaBaseTypeNum0506	display "\<Complex\%(32\|64\|128\)\>"
syntax match   juliaBaseTypeNum07	display "\<\%(AbstractIrrational\|ComplexF\%(16\|32\|64\)\)\>"
syntax match   juliaBaseTypeC		display "\<\%(FileOffset\|C\%(u\?\%(char\|short\|int\|long\(long\)\?\|w\?string\)\|float\|double\|\%(ptrdiff\|s\?size\|wchar\|off\|u\?intmax\)_t\)\)\>"
syntax match   juliaBaseTypeC07		display "\<Cvoid\>"
syntax match   juliaBaseTypeError	display "\<\%(\%(Bounds\|Divide\|Domain\|\%(Stack\)\?Overflow\|EOF\|Undef\%(Ref\|Var\)\|System\|Type\|Parse\|Argument\|Key\|Load\|Method\|Inexact\|OutOfMemory\|Init\|Assertion\|Unicode\|ReadOnlyMemory\)Error\|\%(Interrupt\|Error\|ProcessExited\|Captured\|Composite\|InvalidState\|Null\|Remote\)Exception\|DimensionMismatch\|SegmentationFault\)\>"
syntax match   juliaBaseTypeError07	display "\<\%(StringIndexError\|MissingException\)\>"
syntax match   juliaBaseTypeIter	display "\<\%(EachLine\|Enumerate\|Cartesian\%(Index\|Range\)\|LinSpace\)\>"
syntax match   juliaBaseTypeIter05	display "\<\%(Zip\|Filter\)\>"
syntax match   juliaBaseTypeIter07	display "\<CartesianIndices\>"
syntax match   juliaBaseTypeString	display "\<\%(DirectIndex\|Sub\|Rep\|Rev\|Abstract\)\?String\>"
syntax match   juliaBaseTypeArray	display "\<\%(\%(Sub\)\?Array\|\%(Abstract\|Dense\|Strided\)\?\%(Array\|Matrix\|Vec\%(tor\|OrMat\)\)\|SparseMatrixCSC\|\%(AbstractSparse\|Bit\|Shared\)\%(Array\|Vector\|Matrix\)\|\%\(D\|Bid\|\%(Sym\)\?Trid\)iagonal\|Hermitian\|Symmetric\|UniformScaling\|\%(Lower\|Upper\)Triangular\|SparseVector\|VecElement\)\>"
syntax match   juliaBaseTypeArray0607	display "\<\%(Conj\%(Array\|Matrix\|Vector\)\|Index\%(Cartesian\|Linear\|Style\)\|PermutedDimsArray\|RowVector\)\>"
syntax match   juliaBaseTypeArray07	display "\<\%(BroadcastStyle\|Adjoint\|Transpose\|LinearIndices\)\>"
syntax match   juliaBaseTypeDict	display "\<\%(WeakKey\)\?Dict\>"
syntax match   juliaBaseTypeDict0506	display "\<ObjectIdDict\>"
syntax match   juliaBaseTypeDict07	display "\<IdDict\>"
syntax match   juliaBaseTypeSet		display "\<Set\>"
syntax match   juliaBaseTypeSet0506	display "\<IntSet\>"
syntax match   juliaBaseTypeSet0607	display "\<AbstractSet\>"
syntax match   juliaBaseTypeSet07	display "\<\%(\%(Bit\|Key\)Set\|AbstractDict\)\>"
syntax match   juliaBaseTypeIO		display "\<\%(IO\%(Stream\|Buffer\|Context\)\?\|RawFD\|StatStruct\|FileMonitor\|PollingFileWatcher\|Timer\|Base64\%(Decode\|Encode\)Pipe\|\%(UDP\|TCP\)Socket\|\%(Abstract\)\?Channel\|BufferStream\|ReentrantLock\)\>"
syntax match   juliaBaseTypeIO07	display "\<GenericIOBuffer\>"
syntax match   juliaBaseTypeProcess	display "\<\%(ProcessGroup\|Pipe\|Cmd\)\>"
syntax match   juliaBaseTypeProcess0607	display "\<PipeBuffer\>"
syntax match   juliaBaseTypeRange	display "\<\%(Dims\|RangeIndex\|\%(Ordinal\|Step\|\%(Abstract\)\?Unit\)Range\|Colon\)\>"
syntax match   juliaBaseTypeRange05	display "\<FloatRange\>"
syntax match   juliaBaseTypeRange0506	display "\<Range\>"
syntax match   juliaBaseTypeRange0607	display "\<\%(ExponentialBackOff\|StepRangeLen\)\>"
syntax match   juliaBaseTypeRange07	display "\<\(Abstract\|Lin\)Range\>"
syntax match   juliaBaseTypeRegex	display "\<Regex\%(Match\)\?\>"
syntax match   juliaBaseTypeFact	display "\<Factorization\>"
syntax match   juliaBaseTypeSort	display "\<\%(Insertion\|\(Partial\)\?Quick\|Merge\)Sort\>"
syntax match   juliaBaseTypeRound	display "\<Round\%(ingMode\|FromZero\|Down\|Nearest\%(Ties\%(Away\|Up\)\)\?\|ToZero\|Up\)\>"
syntax match   juliaBaseTypeSpecial	display "\<\%(LocalProcess\|ClusterManager\)\>"
syntax match   juliaBaseTypeRandom	display "\<\%(AbstractRNG\|MersenneTwister\|RandomDevice\)\>"
syntax match   juliaBaseTypeDisplay	display "\<\%(Text\(Display\)\?\|Display\|MIME\|HTML\)\>"
syntax match   juliaBaseTypeDisplay07	display "\<AbstractDisplay\>"
syntax match   juliaBaseTypeTime	display "\<\%(Date\%(Time\)\?\)\>"
syntax match   juliaBaseTypeTime0607	display "\<DateFormat\>"
syntax match   juliaBaseTypeOther	display "\<\%(RemoteRef\|Task\|Condition\|VersionNumber\|IPv[46]\|SerializationState\|WorkerConfig\|Future\|RemoteChannel\|IPAddr\|Stack\%(Trace\|Frame\)\|\(Caching\|Worker\)Pool\|AbstractSerializer\)\>"

syntax match   juliaConstNum		display "\%(\<\%(\%(NaN\|Inf\)\%(16\|32\|64\)\?\|pi\|π\)\>\)"
syntax match   juliaConstNum0506	display "\%(\<\%(eu\?\|eulergamma\|γ\|catalan\|φ\|golden\)\>\)"
" Note: recognition of ℯ, which Vim does not consider a valid identifier, is
" complicated. We detect possible uses by just looking for the character (for
" performance) and then check that it's actually used by its own.
" (This also tries to detect preceding number constants; it does so in a crude
" way.)
syntax match   juliaPossibleEuler	"ℯ" contains=juliaEuler
exec 'syntax match   juliaEuler	        contained "\%(\%(^\|[' . s:nonidS_chars . ']\|' . s:operators . '\)\%([.0-9eEf_]*\d\)\?\)\@'.s:d(80).'<=ℯ\ze\%($\|[' . s:nonidS_chars . ']\|' . s:operators . '\)"'
syntax match   juliaConstBool		display "\<\%(true\|false\)\>"
syntax match   juliaConstEnv		display "\<\%(ARGS\|ENV\|OS_NAME\|ENDIAN_BOM\|LOAD_PATH\|VERSION\|JULIA_HOME\|PROGRAM_FILE\)\>"
syntax match   juliaConstEnv07		display "\<DEPOT_PATH\>"
syntax match   juliaConstIO0506		display "\<\%(STD\%(OUT\|IN\|ERR\)\|DevNull\)\>"
syntax match   juliaConstIO07		display "\<\%(std\%(out\|in\|err\)\|devnull\)\>"
syntax match   juliaConstC		display "\<\%(WORD_SIZE\|C_NULL\)\>"
syntax match   juliaConstGeneric	display "\<\%(nothing\|Main\)\>"
syntax match   juliaConstGeneric07	display "\<missing\>"

syntax match   juliaPossibleMacro	transparent "@" contains=juliaMacroCall,juliaMacroCallP,juliaPrintfMacro

exec 'syntax match   juliaMacro		contained "@' . s:idregex . '\%(\.' . s:idregex . '\)*"'
syntax match   juliaMacro		contained "@\.\ze[^0-9]"
exec 'syntax region  juliaMacroCallP	contained transparent start="@' . s:idregex . '\%(\.' . s:idregex . '\)*(" end=")\@'.s:d(1).'<=" contains=juliaMacro,juliaParBlock'
exec 'syntax region  juliaMacroCallP	contained transparent start="@.(" end=")\@'.s:d(1).'<=" contains=juliaMacro,juliaParBlock'
exec 'syntax region  juliaMacroCall	contained transparent start="\(@' . s:idregex . '\%(\.' . s:idregex . '\)*\)\@=\1\%([^(]\|$\)" end="\ze\%([])};#]\|$\|\<for\>\)" contains=@juliaExpressions,juliaMacro,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS'
exec 'syntax region  juliaMacroCall	contained transparent start="\(@.\)\@=\1\%([^(]\|$\)" end="\ze\%([])};#]\|$\|\<for\>\)" contains=@juliaExpressions,juliaMacro,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS'

syntax match   juliaNumbers		transparent "\<\d\|\.\d\|\<im\>" contains=juliaNumber,juliaFloat,juliaComplexUnit

"integer regexes
let s:dec_regex = '\d\%(_\?\d\)*\%(\>\|im\>\|\ze\D\)'
let s:hex_regex = '0x\x\%(_\?\x\)*\%(\>\|im\>\|\ze\X\)'
let s:bin_regex = '0b[01]\%(_\?[01]\)*\%(\>\|im\>\|\ze[^01]\)'
let s:oct_regex = '0o\o\%(_\?\o\)*\%(\>\|im\>\|\ze\O\)'

let s:int_regex = '\%(' . s:hex_regex .
      \           '\|'  . s:bin_regex .
      \           '\|'  . s:oct_regex .
      \           '\|'  . s:dec_regex .
      \           '\)'

"floating point regexes
"  starting with a dot, optional exponent
let s:float_regex1 = '\.\d\%(_\?\d\)*\%([eEf][-+]\?\d\+\)\?\%(\>\|im\>\|\ze\D\)'
"  with dot, optional exponent
let s:float_regex2 = '\d\%(_\?\d\)*\.\%(\d\%(_\?\d\)*\)\?\%([eEf][-+]\?\d\+\)\?\%(\>\|im\>\|\ze\D\)'
"  without dot, with exponent
let s:float_regex3 = '\d\%(_\?\d\)*[eEf][-+]\?\d\+\%(\>\|im\>\|\ze\D\)'

"hex floating point numbers
"  starting with a dot
let s:hexfloat_regex1 = '0x\.\%\(\x\%(_\?\x\)*\)\?[pP][-+]\?\d\+\%(\>\|im\>\|\ze\X\)'
"  starting with a digit
let s:hexfloat_regex2 = '0x\x\%(_\?\x\)*\%\(\.\%\(\x\%(_\?\x\)*\)\?\)\?[pP][-+]\?\d\+\%(\>\|im\>\|\ze\X\)'

let s:float_regex = '\%(' . s:float_regex3 .
      \             '\|'  . s:float_regex2 .
      \             '\|'  . s:float_regex1 .
      \             '\|'  . s:hexfloat_regex2 .
      \             '\|'  . s:hexfloat_regex1 .
      \             '\)'

exec 'syntax match   juliaNumber	contained "' . s:int_regex . '" contains=juliaComplexUnit'
exec 'syntax match   juliaFloat		contained "' . s:float_regex . '" contains=juliaComplexUnit'
syntax match   juliaComplexUnit		display	contained "\<im\>"

exec 'syntax match   juliaOperator	"' . s:operators . '"'
syntax match   juliaRangeOperator	display ":"
exec 'syntax region  juliaTernaryRegion	matchgroup=juliaTernaryOperator start="\s\zs?\ze\s" skip="\%(:\(:\|[^:[:space:]'."'".'"({[]\+\s*\ze:\)\|^\s*:\|\%(?\s*\)\@'.s:d(6).'<=:(\)" end=":" contains=@juliaExpressions,juliaErrorSemicol'

let s:interp_dollar = '\([' . s:nonidS_chars . s:uniop_chars . s:binop_chars . '!?]\|^\)\@'.s:d(1).'<=\$'

exec 'syntax match   juliaDollarVar	display contained "' . s:interp_dollar . s:idregex . '"'
exec 'syntax region  juliaDollarPar	matchgroup=juliaDollarVar contained start="' .s:interp_dollar . '(" end=")" contains=@juliaExpressions'
exec 'syntax region  juliaDollarSqBra	matchgroup=juliaDollarVar contained start="' .s:interp_dollar . '\[" end="\]" contains=@juliaExpressions,juliaComprehensionFor,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS'

syntax match   juliaChar		"'\\\?.'" contains=juliaSpecialChar
syntax match   juliaChar		display "'\\\o\{3\}'" contains=juliaOctalEscapeChar
syntax match   juliaChar		display "'\\x\x\{2\}'" contains=juliaHexEscapeChar
syntax match   juliaChar		display "'\\u\x\{1,4\}'" contains=juliaUniCharSmall
syntax match   juliaChar		display "'\\U\x\{1,8\}'" contains=juliaUniCharLarge

exec 'syntax match   juliaCTransOperator	"[[:space:]}' . s:nonid_chars . s:uniop_chars . s:binop_chars . '!?]\@'.s:d(1).'<!\.\?' . "'" . '"'

syntax region  juliaString		matchgroup=juliaStringDelim start=+\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaStringVars,@juliaSpecialChars,@juliaSpellcheckStrings
syntax region  juliabString		matchgroup=juliaStringDelim start=+\<b\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialChars
syntax region  juliasString		matchgroup=juliaStringDelim start=+\<s\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialChars
syntax region  juliavString		matchgroup=juliaStringDelim start=+\<v\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+
syntax region  juliaipString		matchgroup=juliaStringDelim start=+\<ip\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+
syntax region  juliabigString		matchgroup=juliaStringDelim start=+\<big\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+
syntax region  juliaMIMEString		matchgroup=juliaStringDelim start=+\<MIME\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialChars

syntax region  juliaDocString		matchgroup=juliaStringDelim start=+^"""+ skip=+\%(\\\\\)*\\"+ end=+"""+ contains=@juliaStringVars,@juliaSpecialChars,@juliaSpellcheckDocStrings

exec 'syntax region  juliaPrintfMacro		contained transparent start="@s\?printf(" end=")\@'.s:d(1).'<=" contains=juliaMacro,juliaPrintfParBlock'
syntax region  juliaPrintfMacro		contained transparent start="@s\?printf\s\+" end="\ze\%([])};#]\|$\|\<for\>\)" contains=@juliaExprsPrintf,juliaMacro,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS
syntax region  juliaPrintfParBlock	contained matchgroup=juliaParDelim start="(" end=")" contains=@juliaExprsPrintf
syntax region  juliaPrintfString	contained matchgroup=juliaStringDelim start=+"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaSpecialChars,@juliaPrintfChars

syntax region  juliaShellString		matchgroup=juliaStringDelim start=+`+ skip=+\%(\\\\\)*\\`+ end=+`+ contains=@juliaStringVars,juliaSpecialChar

syntax cluster juliaStringVars		contains=juliaStringVarsPar,juliaStringVarsSqBra,juliaStringVarsCurBra,juliaStringVarsPla
syntax region  juliaStringVarsPar	contained matchgroup=juliaStringVarDelim start="$(" end=")" contains=@juliaExpressions
syntax region  juliaStringVarsSqBra	contained matchgroup=juliaStringVarDelim start="$\[" end="\]" contains=@juliaExpressions,juliaComprehensionFor,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS
syntax region  juliaStringVarsCurBra	contained matchgroup=juliaStringVarDelim start="${" end="}" contains=@juliaExpressions
exec 'syntax match   juliaStringVarsPla	contained "\$' . s:idregex . '"'

" TODO improve RegEx
syntax region  juliaRegEx		matchgroup=juliaStringDelim start=+\<r\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1[imsx]*+

syntax cluster juliaSpecialChars	contains=juliaSpecialChar,juliaOctalEscapeChar,juliaHexEscapeChar,juliaUniCharSmall,juliaUniCharLarge
syntax match   juliaSpecialChar		display contained "\\."
syntax match   juliaOctalEscapeChar	display contained "\\\o\{3\}"
syntax match   juliaHexEscapeChar	display contained "\\x\x\{2\}"
syntax match   juliaUniCharSmall	display contained "\\u\x\{1,4\}"
syntax match   juliaUniCharLarge	display contained "\\U\x\{1,8\}"

syntax cluster juliaPrintfChars		contains=juliaErrorPrintfFmt,juliaPrintfFmt
syntax match   juliaErrorPrintfFmt	display contained "\\\?%."
syntax match   juliaPrintfFmt		display contained "%\%(\d\+\$\)\=[-+' #0]*\%(\d*\|\*\|\*\d\+\$\)\%(\.\%(\d*\|\*\|\*\d\+\$\)\)\=\%([hlLjqzt]\|ll\|hh\)\=[aAbdiuoxXDOUfFeEgGcCsSpn]"
syntax match   juliaPrintfFmt		display contained "%%"
syntax match   juliaPrintfFmt		display contained "\\%\%(\d\+\$\)\=[-+' #0]*\%(\d*\|\*\|\*\d\+\$\)\%(\.\%(\d*\|\*\|\*\d\+\$\)\)\=\%([hlLjqzt]\|ll\|hh\)\=[aAbdiuoxXDOUfFeEgGcCsSpn]"hs=s+1
syntax match   juliaPrintfFmt		display contained "\\%%"hs=s+1

" this is used to restrict the search for Symbols to when colons appear at all
" (for performance reasons)
syntax match   juliaPossibleSymbol      transparent ":\ze[^:]" contains=juliaSymbol,juliaQuotedParBlock,juliaQuotedQMarkPar,juliaColon

let s:quotable = '\%(' . s:idregex . '\|?\|' . s:operators . '\|' . s:float_regex . '\|' . s:int_regex . '\)'
let s:quoting_colon = '\%(\%(^\s*\|\s\{6,\}\|[' . s:nonid_chars . s:uniop_chars . s:binop_chars . '?]\s*\)\@'.s:d(6).'<=\|\%(\<\%(return\|if\|else\%(if\)\?\|while\|try\|begin\)\s*\)\@'.s:d(9).'<=\)\zs:'
let s:quoting_colonS = '\s\@'.s:d(1).'<=:'

" note: juliaSymbolS only works within whitespace-sensitive contexts,
" such as in macro calls without parentheses, or within square brackets.
" It is used to override the recognition of expressions like `a :b` as
" ranges rather than symbols in those contexts.
" (Note that such `a :b` expressions only allows at most 5 spaces between
" the identifier and the colon anyway.)

exec 'syntax match   juliaSymbol	contained "' .s:quoting_colon . s:quotable . '"'
exec 'syntax match   juliaSymbolS	contained "' . s:quoting_colonS . s:quotable . '"'

" same as above for quoted expressions such as :(expr)
" (includes :(?) as a special case, although it really shouldn't work...)
exec 'syntax region   juliaQuotedParBlock	matchgroup=juliaQParDelim start="' . s:quoting_colon . '(" end=")" contains=@juliaExpressions'
exec 'syntax match    juliaQuotedQMarkPar	"' . s:quoting_colon . '(\s*?\s*)" contains=juliaQuotedQMark'
exec 'syntax region   juliaQuotedParBlockS	matchgroup=juliaQParDelim contained start="' . s:quoting_colonS . '(" end=")" contains=@juliaExpressions'
exec 'syntax match    juliaQuotedQMarkParS	contained "' . s:quoting_colonS . '(\s*?\s*)" contains=juliaQuotedQMark'

" force precedence over Symbols
syntax match   juliaOperator		display "::"

syntax region  juliaCommentL		matchgroup=juliaCommentDelim start="#\ze\%([^=]\|$\)" end="$" keepend contains=juliaTodo,@juliaSpellcheckComments
syntax region  juliaCommentM		matchgroup=juliaCommentDelim start="#=\ze\%([^#]\|$\)" end="=#" contains=juliaTodo,juliaCommentM,@juliaSpellcheckComments
syntax keyword juliaTodo		contained TODO FIXME XXX


" the following are disabled by default, but
" can be enabled by entering e.g.
"   :hi link juliaParDelim Delimiter
hi def link juliaParDelim		juliaNone
hi def link juliaSemicolon		juliaNone
hi def link juliaComma  		juliaNone

hi def link juliaColon			juliaOperator


hi def link juliaKeyword		Keyword
hi def link juliaInfixKeyword		Keyword
hi def link juliaRepKeyword		Keyword
hi def link juliaBlKeyword		Keyword
hi def link juliaConditional		Conditional
hi def link juliaRepeat			Repeat
hi def link juliaException		Exception
hi def link juliaTypedef		Keyword
exec 'hi! def link juliaOuter ' . (b:julia_syntax_version >= 7 ? 'Keyword' : 'NONE')
hi def link juliaBaseTypeBasic		Type
hi def link juliaBaseTypeNum		Type
hi def link juliaBaseTypeC		Type
hi def link juliaBaseTypeError		Type
hi def link juliaBaseTypeIter		Type
hi def link juliaBaseTypeString		Type
hi def link juliaBaseTypeArray		Type
hi def link juliaBaseTypeDict		Type
hi def link juliaBaseTypeSet		Type
hi def link juliaBaseTypeIO		Type
hi def link juliaBaseTypeProcess	Type
hi def link juliaBaseTypeRange		Type
hi def link juliaBaseTypeRegex		Type
hi def link juliaBaseTypeFact		Type
hi def link juliaBaseTypeSort		Type
hi def link juliaBaseTypeRound		Type
hi def link juliaBaseTypeSpecial	Type
hi def link juliaBaseTypeRandom		Type
hi def link juliaBaseTypeDisplay	Type
hi def link juliaBaseTypeTime		Type
hi def link juliaBaseTypeOther		Type
for t in ["Basic", "Array", "Set", "Range", "Time", "Process"]
  let h = b:julia_syntax_version >= 6 ? "Type" : "NONE"
  exec "hi! def link juliaBaseType" . t . "0607	" . h
endfor
for t in ["Iter", "Range"]
  let h = b:julia_syntax_version == 5 ? "Type" : b:julia_syntax_version == 6 ? "juliaDeprecated" : "NONE"
  exec "hi! def link juliaBaseType" . t . "05 " . h
endfor
for t in ["Num", "Range", "Dict", "Set"]
  let h = b:julia_syntax_version <= 6 ? "Type" : "juliaDeprecated"
  exec "hi! def link juliaBaseType" . t . "0506 " . h
endfor
for t in ["Range", "Dict", "Set", "Basic", "C", "Array", "Iter", "Display", "IO", "Num", "Error"]
  let h = b:julia_syntax_version >= 7 ? "Type" : "NONE"
  exec "hi! def link juliaBaseType" . t . "07 " . h
endfor

" NOTE: deprecated constants are not highlighted as such. For once,
" one can still legitimately use them by importing Base.MathConstants.
" Plus, one-letter variables like `e` and `γ` can be used with other
" meanings.
hi def link juliaConstNum		Constant
let h = b:julia_syntax_version <= 6 ? "Constant" : "NONE"
exec "hi! def link juliaConstNum0506 " . h
let h = b:julia_syntax_version >= 7 ? "Constant" : "NONE"
exec "hi! def link juliaEuler " . h

hi def link juliaConstEnv		Constant
hi def link juliaConstC			Constant
hi def link juliaConstLimits		Constant
hi def link juliaConstGeneric		Constant
hi def link juliaRangeEnd		Constant
hi def link juliaConstBool		Boolean

for t in ["Generic", "IO", "Env"]
  let h = b:julia_syntax_version >= 7 ? "Constant" : "NONE"
  exec "hi! def link juliaConst" . t . "07 " . h
endfor
let h = b:julia_syntax_version < 7 ? "Constant" : "juliaDeprecated"
exec "hi! def link juliaConstIO0506 " . h

hi def link juliaComprehensionFor	Keyword
hi def link juliaComprehensionIf	Keyword

hi def link juliaDollarVar		Identifier

hi def link juliaMacro			Macro
hi def link juliaSymbol			Identifier
hi def link juliaSymbolS		Identifier
hi def link juliaQParDelim		Identifier
hi def link juliaQuotedQMarkPar		Identifier
hi def link juliaQuotedQMarkParS	Identifier
hi def link juliaQuotedQMark            juliaOperatorHL

hi def link juliaNumber			Number
hi def link juliaFloat			Float
hi def link juliaComplexUnit		Constant

hi def link juliaChar			Character

hi def link juliaString			String
hi def link juliabString		String
hi def link juliasString		String
hi def link juliavString		String
hi def link juliarString		String
hi def link juliaipString		String
hi def link juliabigString		String
hi def link juliaMIMEString		String
hi def link juliaPrintfString		String
hi def link juliaShellString		String
hi def link juliaDocString		String
hi def link juliaStringDelim		String
hi def link juliaStringVarsPla		Identifier
hi def link juliaStringVarDelim		Identifier

hi def link juliaRegEx			String

hi def link juliaSpecialChar		SpecialChar
hi def link juliaOctalEscapeChar	SpecialChar
hi def link juliaHexEscapeChar		SpecialChar
hi def link juliaUniCharSmall		SpecialChar
hi def link juliaUniCharLarge		SpecialChar

hi def link juliaPrintfFmt		SpecialChar

if s:julia_highlight_operators
  hi! def link juliaOperatorHL		Operator
else
  hi! def link juliaOperatorHL		juliaNone
endif
hi def link juliaOperator		juliaOperatorHL
hi def link juliaRangeOperator		juliaOperatorHL
hi def link juliaCTransOperator		juliaOperatorHL
hi def link juliaTernaryOperator	juliaOperatorHL

hi def link juliaCommentL		Comment
hi def link juliaCommentM		Comment
hi def link juliaCommentDelim		Comment
hi def link juliaTodo			Todo

hi def link juliaErrorPar		juliaError
hi def link juliaErrorEnd		juliaError
hi def link juliaErrorElse		juliaError
hi def link juliaErrorCatch		juliaError
hi def link juliaErrorFinally		juliaError
hi def link juliaErrorSemicol		juliaError
hi def link juliaErrorPrintfFmt		juliaError

hi def link juliaError			Error

if b:julia_syntax_highlight_deprecated == 1
  hi! def link juliaDeprecated		Todo
else
  hi! def link juliaDeprecated		NONE
end

syntax sync fromstart

let b:current_syntax = "julia"

endif
