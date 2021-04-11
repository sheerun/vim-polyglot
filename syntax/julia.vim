if polyglot#init#is_disabled(expand('<sfile>:p'), 'julia', 'syntax/julia.vim')
  finish
endif

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
let s:uniop_chars = "+\\U2D~¬√∛∜⋆"

let s:binop_chars = "=+\\U2D*/\\%÷^&|⊻<>≤≥≡≠≢∈∉⋅×∪∩⊆⊈⊂⊄⊊←→∋∌⊕⊖⊞⊟∘∧⊗⊘↑↓∨⊠±⟂⋆"

" the following is a list of all remainig valid operator chars,
" but it's more efficient when expressed with ranges (see below)
" let s:binop_chars_extra = "↔↚↛↠↣↦↮⇎⇏⇒⇔⇴⇶⇷⇸⇹⇺⇻⇼⇽⇾⇿⟵⟶⟷⟷⟹⟺⟻⟼⟽⟾⟿⤀⤁⤂⤃⤄⤅⤆⤇⤌⤍⤎⤏⤐⤑⤔⤕⤖⤗⤘⤝⤞⤟⤠⥄⥅⥆⥇⥈⥊⥋⥎⥐⥒⥓⥖⥗⥚⥛⥞⥟⥢⥤⥦⥧⥨⥩⥪⥫⥬⥭⥰⧴⬱⬰⬲⬳⬴⬵⬶⬷⬸⬹⬺⬻⬼⬽⬾⬿⭀⭁⭂⭃⭄⭇⭈⭉⭊⭋⭌￩￫" .
"       \                   "∝∊∍∥∦∷∺∻∽∾≁≃≄≅≆≇≈≉≊≋≌≍≎≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≣≦≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊃⊅⊇⊉⊋⊏⊐⊑⊒⊜⊩⊬⊮⊰⊱⊲⊳⊴⊵⊶⊷⋍⋐⋑⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿⟈⟉⟒⦷⧀⧁⧡⧣⧤⧥⩦⩧⩪⩫⩬⩭⩮⩯⩰⩱⩲⩳⩴⩵⩶⩷⩸⩹⩺⩻⩼⩽⩾⩿⪀⪁⪂⪃⪄⪅⪆⪇⪈⪉⪊⪋⪌⪍⪎⪏⪐⪑⪒⪓⪔⪕⪖⪗⪘⪙⪚⪛⪜⪝⪞⪟⪠⪡⪢⪣⪤⪥⪦⪧⪨⪩⪪⪫⪬⪭⪮⪯⪰⪱⪲⪳⪴⪵⪶⪷⪸⪹⪺⪻⪼⪽⪾⪿⫀⫁⫂⫃⫄⫅⫆⫇⫈⫉⫊⫋⫌⫍⫎⫏⫐⫑⫒⫓⫔⫕⫖⫗⫘⫙⫷⫸⫹⫺⊢⊣" .
"       \                   "⊔∓∔∸≂≏⊎⊽⋎⋓⧺⧻⨈⨢⨣⨤⨥⨦⨧⨨⨩⨪⨫⨬⨭⨮⨹⨺⩁⩂⩅⩊⩌⩏⩐⩒⩔⩖⩗⩛⩝⩡⩢⩣" .
"       \                   "⊙⊚⊛⊡⊓∗∙∤⅋≀⊼⋄⋇⋉⋊⋋⋌⋏⋒⟑⦸⦼⦾⦿⧶⧷⨇⨰⨱⨲⨳⨴⨵⨶⨷⨸⨻⨼⨽⩀⩃⩄⩋⩍⩎⩑⩓⩕⩘⩚⩜⩞⩟⩠⫛⊍▷⨝⟕⟖⟗" .
"       \                   "⇵⟰⟱⤈⤉⤊⤋⤒⤓⥉⥌⥍⥏⥑⥔⥕⥘⥙⥜⥝⥠⥡⥣⥥⥮⥯￪￬"

" same as above, but with character ranges, for performance
let s:binop_chars_extra = "\\U214B\\U2190-\\U2194\\U219A\\U219B\\U21A0\\U21A3\\U21A6\\U21AE\\U21CE\\U21CF\\U21D2\\U21D4\\U21F4-\\U21FF\\U2208-\\U220D\\U2213\\U2214\\U2217-\\U2219\\U221D\\U2224-\\U222A\\U2237\\U2238\\U223A\\U223B\\U223D\\U223E\\U2240-\\U228B\\U228D-\\U229C\\U229E-\\U22A3\\U22A9\\U22AC\\U22AE\\U22B0-\\U22B7\\U22BB-\\U22BD\\U22C4-\\U22C7\\U22C9-\\U22D3\\U22D5-\\U22ED\\U22F2-\\U22FF\\U25B7\\U27C8\\U27C9\\U27D1\\U27D2\\U27D5-\\U27D7\\U27F0\\U27F1\\U27F5-\\U27F7\\U27F7\\U27F9-\\U27FF\\U2900-\\U2918\\U291D-\\U2920\\U2944-\\U2970\\U29B7\\U29B8\\U29BC\\U29BE-\\U29C1\\U29E1\\U29E3-\\U29E5\\U29F4\\U29F6\\U29F7\\U29FA\\U29FB\\U2A07\\U2A08\\U2A1D\\U2A22-\\U2A2E\\U2A30-\\U2A3D\\U2A40-\\U2A45\\U2A4A-\\U2A58\\U2A5A-\\U2A63\\U2A66\\U2A67\\U2A6A-\\U2AD9\\U2ADB\\U2AF7-\\U2AFA\\U2B30-\\U2B44\\U2B47-\\U2B4C\\UFFE9-\\UFFEC"

" a Julia identifier, sort of
let s:idregex = '\%([^' . s:nonidS_chars . '0-9!?' . s:uniop_chars . s:binop_chars . '][^' . s:nonidS_chars . s:uniop_chars . s:binop_chars . s:binop_chars_extra . ']*\)'

let s:operators = '\%(' . '\.\%([-+*/^÷%|&!]\|//\|\\\|<<\|>>>\?\)\?=' .
      \           '\|'  . '[:$<>]=\|||\|&&\||>\|<|\|<:\|>:\|::\|<<\|>>>\?\|//\|[-=]>\|\.\{3\}' .
      \           '\|'  . '[' . s:uniop_chars . '!$]' .
      \           '\|'  . '\.\?[' . s:binop_chars . s:binop_chars_extra . ']' .
      \           '\)'

syn case match

syntax cluster juliaExpressions		contains=@juliaParItems,@juliaStringItems,@juliaKeywordItems,@juliaBlocksItems,@juliaTypesItems,@juliaConstItems,@juliaMacroItems,@juliaSymbolItems,@juliaOperatorItems,@juliaNumberItems,@juliaCommentItems,@juliaErrorItems
syntax cluster juliaExprsPrintf		contains=@juliaExpressions,@juliaPrintfItems

syntax cluster juliaParItems		contains=juliaParBlock,juliaSqBraIdxBlock,juliaSqBraBlock,juliaCurBraBlock,juliaQuotedParBlock,juliaQuotedQMarkPar
syntax cluster juliaKeywordItems	contains=juliaKeyword,juliaImportLine,juliaInfixKeyword,juliaRepKeyword
syntax cluster juliaBlocksItems		contains=juliaConditionalBlock,juliaWhileBlock,juliaForBlock,juliaBeginBlock,juliaFunctionBlock,juliaMacroBlock,juliaQuoteBlock,juliaTypeBlock,juliaImmutableBlock,juliaExceptionBlock,juliaLetBlock,juliaDoBlock,juliaModuleBlock,juliaStructBlock,juliaMutableStructBlock,juliaAbstractBlock,juliaPrimitiveBlock
syntax cluster juliaTypesItems		contains=juliaBaseTypeBasic,juliaBaseTypeNum,juliaBaseTypeC,juliaBaseTypeError,juliaBaseTypeIter,juliaBaseTypeString,juliaBaseTypeArray,juliaBaseTypeDict,juliaBaseTypeSet,juliaBaseTypeIO,juliaBaseTypeProcess,juliaBaseTypeRange,juliaBaseTypeRegex,juliaBaseTypeFact,juliaBaseTypeFact,juliaBaseTypeSort,juliaBaseTypeRound,juliaBaseTypeSpecial,juliaBaseTypeRandom,juliaBaseTypeDisplay,juliaBaseTypeTime,juliaBaseTypeOther

syntax cluster juliaConstItems  	contains=juliaConstNum,juliaConstBool,juliaConstEnv,juliaConstMMap,juliaConstC,juliaConstGeneric,juliaConstIO,juliaPossibleEuler

syntax cluster juliaMacroItems		contains=juliaPossibleMacro,juliaDollarVar,juliaDollarPar,juliaDollarSqBra
syntax cluster juliaSymbolItems		contains=juliaPossibleSymbol
syntax cluster juliaNumberItems		contains=juliaNumbers
syntax cluster juliaStringItems		contains=juliaChar,juliaString,juliaStringPrefixed,juliabString,juliasString,juliavString,juliaipString,juliabigString,juliaMIMEString,juliarawString,juliatextString,juliahtmlString,juliaint128String,juliaShellString,juliaDocString,juliaRegEx
syntax cluster juliaPrintfItems		contains=juliaPrintfParBlock,juliaPrintfString
syntax cluster juliaOperatorItems	contains=juliaOperator,juliaRangeOperator,juliaCTransOperator,juliaTernaryRegion,juliaColon,juliaSemicolon,juliaComma
syntax cluster juliaCommentItems	contains=juliaCommentL,juliaCommentM
syntax cluster juliaErrorItems		contains=juliaErrorPar,juliaErrorEnd,juliaErrorElse,juliaErrorCatch,juliaErrorFinally

syntax cluster juliaSpellcheckStrings		contains=@spell
syntax cluster juliaSpellcheckDocStrings	contains=@spell
syntax cluster juliaSpellcheckComments		contains=@spell

if !s:julia_spellcheck_docstrings
  syntax cluster juliaSpellcheckDocStrings	remove=@spell
endif
if !s:julia_spellcheck_strings
  syntax cluster juliaSpellcheckStrings		remove=@spell
endif
if !s:julia_spellcheck_comments
  syntax cluster juliaSpellcheckComments	remove=@spell
endif

syntax match   juliaSemicolon		display ";"
syntax match   juliaComma		display ","
syntax match   juliaColon		display ":"

" This is really ugly. It would be better to mask most keywords when a dot is
" found, introducing some kind of dot-environment
let s:nodot = '\%(\.\)\@'.s:d(1).'<!'

syntax match   juliaErrorPar		display "[])}]"
exec 'syntax match   juliaErrorEnd	display "'.s:nodot.'\<end\>"'
exec 'syntax match   juliaErrorElse	display "'.s:nodot.'\<\%(else\|elseif\)\>"'
exec 'syntax match   juliaErrorCatch	display "'.s:nodot.'\<catch\>"'
exec 'syntax match   juliaErrorFinally	display "'.s:nodot.'\<finally\>"'
syntax match   juliaErrorSemicol	display contained ";"

syntax region  juliaParBlock		matchgroup=juliaParDelim start="(" end=")" contains=@juliaExpressions,juliaComprehensionFor
syntax region  juliaParBlockInRange	matchgroup=juliaParDelim contained start="(" end=")" contains=@juliaExpressions,juliaParBlockInRange,juliaRangeKeyword,juliaComprehensionFor
syntax region  juliaSqBraIdxBlock	matchgroup=juliaParDelim start="\[" end="\]" contains=@juliaExpressions,juliaParBlockInRange,juliaRangeKeyword,juliaComprehensionFor,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS
exec 'syntax region  juliaSqBraBlock	matchgroup=juliaParDelim start="\%(^\|\s\|' . s:operators . '\)\@'.s:d(3).'<=\[" end="\]" contains=@juliaExpressions,juliaComprehensionFor,juliaSymbolS,juliaQuotedParBlockS,juliaQuotedQMarkParS'
syntax region  juliaCurBraBlock		matchgroup=juliaParDelim start="{" end="}" contains=@juliaExpressions

exec 'syntax match   juliaKeyword		display "'.s:nodot.'\<\%(return\|local\|global\|const\|where\)\>"'
syntax match   juliaInfixKeyword	display "\%(=\s*\)\@<!\<\%(in\|isa\)\>\S\@!\%(\s*=\)\@!"

" The import/export/using keywords introduce a sort of special parsing
" environment with its own rules
exec 'syntax region  juliaImportLine		matchgroup=juliaKeyword excludenl start="'.s:nodot.'\<\%(import\|using\|export\)\>" skip="\%(\%(\<\%(import\|using\|export\)\>\)\|^\)\@'.s:d(6).'<=$" end="$" end="\%([])}]\)\@=" contains=@juliaExpressions,juliaAsKeyword,@juliaContinuationItems,juliaMacroName'
syntax match   juliaAsKeyword		display contained "\<as\>"

exec 'syntax match   juliaRepKeyword		display "'.s:nodot.'\<\%(break\|continue\)\>"'
exec 'syntax region  juliaConditionalBlock	matchgroup=juliaConditional start="'.s:nodot.'\<if\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions,juliaConditionalEIBlock,juliaConditionalEBlock fold'
exec 'syntax region  juliaConditionalEIBlock	matchgroup=juliaConditional transparent contained start="'.s:nodot.'\<elseif\>" end="'.s:nodot.'\<\%(end\|else\|elseif\)\>"me=s-1 contains=@juliaExpressions,juliaConditionalEIBlock,juliaConditionalEBlock'
exec 'syntax region  juliaConditionalEBlock	matchgroup=juliaConditional transparent contained start="'.s:nodot.'\<else\>" end="'.s:nodot.'\<end\>"me=s-1 contains=@juliaExpressions'
exec 'syntax region  juliaWhileBlock		matchgroup=juliaRepeat start="'.s:nodot.'\<while\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaForBlock		matchgroup=juliaRepeat start="'.s:nodot.'\<for\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions,juliaOuter fold'
exec 'syntax region  juliaBeginBlock		matchgroup=juliaBlKeyword start="'.s:nodot.'\<begin\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaFunctionBlock		matchgroup=juliaBlKeyword start="'.s:nodot.'\<function\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions,juliaFunctionDef,juliaFunctionDefP fold'
exec 'syntax region  juliaMacroBlock		matchgroup=juliaBlKeyword start="'.s:nodot.'\<macro\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaQuoteBlock		matchgroup=juliaBlKeyword start="'.s:nodot.'\<quote\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaStructBlock		matchgroup=juliaBlKeyword start="'.s:nodot.'\<struct\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaMutableStructBlock	matchgroup=juliaBlKeyword start="'.s:nodot.'\<mutable\s\+struct\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaLetBlock		matchgroup=juliaBlKeyword start="'.s:nodot.'\<let\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaDoBlock		matchgroup=juliaBlKeyword start="'.s:nodot.'\<do\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaModuleBlock		matchgroup=juliaBlKeyword start="\%(\%(\.\s*\)\@'.s:d(6).'<!\|\%(@\s*\.\s*\)\@'.s:d(6).'<=\)\<\%(bare\)\?module\>" end="\<end\>" contains=@juliaExpressions fold'
exec 'syntax region  juliaExceptionBlock	matchgroup=juliaException start="'.s:nodot.'\<try\>" end="'.s:nodot.'\<end\>" contains=@juliaExpressions,juliaCatchBlock,juliaFinallyBlock fold'
exec 'syntax region  juliaCatchBlock		matchgroup=juliaException transparent contained start="'.s:nodot.'\<catch\>" end="'.s:nodot.'\<end\>"me=s-1 contains=@juliaExpressions,juliaFinallyBlock'
exec 'syntax region  juliaFinallyBlock	matchgroup=juliaException transparent contained start="'.s:nodot.'\<finally\>" end="'.s:nodot.'\<end\>"me=s-1 contains=@juliaExpressions'
" AbstractBlock needs to come after to take precedence
exec 'syntax region  juliaAbstractBlock	matchgroup=juliaBlKeyword start="'.s:nodot.'\<abstract\s\+type\>" end="'.s:nodot.'\<end\>" fold contains=@juliaExpressions'
exec 'syntax region  juliaPrimitiveBlock	matchgroup=juliaBlKeyword start="'.s:nodot.'\<primitive\s\+type\>" end="'.s:nodot.'\<end\>" fold contains=@juliaExpressions'

exec 'syntax region  juliaComprehensionFor	matchgroup=juliaComprehensionFor transparent contained start="\%([^[:space:],;:({[]\_s*\)\@'.s:d(80).'<=\<for\>" end="\ze[]);]" contains=@juliaExpressions,juliaComprehensionIf,juliaComprehensionFor'
exec 'syntax match   juliaComprehensionIf	contained "'.s:nodot.'\<if\>"'

exec 'syntax match   juliaOuter		contained "\<outer\ze\s\+' . s:idregex . '\>"'

syntax match   juliaRangeKeyword	display contained "\<\%(begin\|end\)\>"

syntax match   juliaBaseTypeBasic	display "\<\%(\%(N\|Named\)\?Tuple\|Symbol\|Function\|Union\%(All\)\?\|Type\%(Name\|Var\)\?\|Any\|ANY\|Vararg\|Ptr\|Exception\|Module\|Expr\|DataType\|\%(LineNumber\|Quote\)Node\|\%(Weak\|Global\)\?Ref\|Method\|Pair\|Val\|Nothing\|Some\|Missing\)\>"
syntax match   juliaBaseTypeNum		display "\<\%(U\?Int\%(8\|16\|32\|64\|128\)\?\|Float\%(16\|32\|64\)\|Complex\|Bool\|Char\|Number\|Signed\|Unsigned\|Integer\|AbstractFloat\|Real\|Rational\|\%(Abstract\)\?Irrational\|Enum\|BigInt\|BigFloat\|MathConst\|ComplexF\%(16\|32\|64\)\)\>"
syntax match   juliaBaseTypeC		display "\<\%(FileOffset\|C\%(u\?\%(char\|short\|int\|long\(long\)\?\|w\?string\)\|float\|double\|\%(ptrdiff\|s\?size\|wchar\|off\|u\?intmax\)_t\|void\)\)\>"
syntax match   juliaBaseTypeError	display "\<\%(\%(Bounds\|Divide\|Domain\|\%(Stack\)\?Overflow\|EOF\|Undef\%(Ref\|Var\)\|System\|Type\|Parse\|Argument\|Key\|Load\|Method\|Inexact\|OutOfMemory\|Init\|Assertion\|ReadOnlyMemory\|StringIndex\)Error\|\%(Interrupt\|Error\|ProcessExited\|Captured\|Composite\|InvalidState\|Missing\|\%(Process\|Task\)Failed\)Exception\|DimensionMismatch\|SegmentationFault\)\>"
syntax match   juliaBaseTypeIter	display "\<\%(EachLine\|Enumerate\|Cartesian\%(Index\|Range\)\|LinSpace\|CartesianIndices\)\>"
syntax match   juliaBaseTypeString	display "\<\%(DirectIndex\|Sub\|Rep\|Rev\|Abstract\|Substitution\)\?String\>"
syntax match   juliaBaseTypeArray	display "\<\%(\%(Sub\)\?Array\|\%(Abstract\|Dense\|Strided\)\?\%(Array\|Matrix\|Vec\%(tor\|OrMat\)\)\|SparseMatrixCSC\|\%(AbstractSparse\|Bit\|Shared\)\%(Array\|Vector\|Matrix\)\|\%\(D\|Bid\|\%(Sym\)\?Trid\)iagonal\|Hermitian\|Symmetric\|UniformScaling\|\%(Lower\|Upper\)Triangular\|\%(Sparse\|Row\)Vector\|VecElement\|Conj\%(Array\|Matrix\|Vector\)\|Index\%(Cartesian\|Linear\|Style\)\|PermutedDimsArray\|Broadcasted\|Adjoint\|Transpose\|LinearIndices\)\>"
syntax match   juliaBaseTypeDict	display "\<\%(WeakKey\|Id\|Abstract\)\?Dict\>"
syntax match   juliaBaseTypeSet		display "\<\%(\%(Abstract\|Bit\)\?Set\)\>"
syntax match   juliaBaseTypeIO		display "\<\%(IO\%(Stream\|Buffer\|Context\)\?\|RawFD\|StatStruct\|FileMonitor\|PollingFileWatcher\|Timer\|Base64\%(Decode\|Encode\)Pipe\|\%(UDP\|TCP\)Socket\|\%(Abstract\)\?Channel\|BufferStream\|ReentrantLock\|GenericIOBuffer\)\>"
syntax match   juliaBaseTypeProcess	display "\<\%(Pipe\|Cmd\|PipeBuffer\)\>"
syntax match   juliaBaseTypeRange	display "\<\%(Dims\|RangeIndex\|\%(Abstract\|Lin\|Ordinal\|Step\|\%(Abstract\)\?Unit\)Range\|Colon\|ExponentialBackOff\|StepRangeLen\)\>"
syntax match   juliaBaseTypeRegex	display "\<Regex\%(Match\)\?\>"
syntax match   juliaBaseTypeFact	display "\<\%(Factorization\|BunchKaufman\|\%(Cholesky\|QR\)\%(Pivoted\)\?\|\%(Generalized\)\?\%(Eigen\|SVD\|Schur\)\|Hessenberg\|LDLt\|LQ\|LU\)\>"
syntax match   juliaBaseTypeSort	display "\<\%(Insertion\|\(Partial\)\?Quick\|Merge\)Sort\>"
syntax match   juliaBaseTypeRound	display "\<Round\%(ingMode\|FromZero\|Down\|Nearest\%(Ties\%(Away\|Up\)\)\?\|ToZero\|Up\)\>"
syntax match   juliaBaseTypeSpecial	display "\<\%(LocalProcess\|ClusterManager\)\>"
syntax match   juliaBaseTypeRandom	display "\<\%(AbstractRNG\|MersenneTwister\|RandomDevice\)\>"
syntax match   juliaBaseTypeDisplay	display "\<\%(Text\(Display\)\?\|\%(Abstract\)\?Display\|MIME\|HTML\)\>"
syntax match   juliaBaseTypeTime	display "\<\%(Date\%(Time\)\?\|DateFormat\)\>"
syntax match   juliaBaseTypeOther	display "\<\%(RemoteRef\|Task\|Condition\|VersionNumber\|IPv[46]\|SerializationState\|WorkerConfig\|Future\|RemoteChannel\|IPAddr\|Stack\%(Trace\|Frame\)\|\(Caching\|Worker\)Pool\|AbstractSerializer\)\>"

syntax match   juliaConstNum		display "\%(\<\%(\%(NaN\|Inf\)\%(16\|32\|64\)\?\|pi\|π\)\>\)"
" Note: recognition of ℯ, which Vim does not consider a valid identifier, is
" complicated. We detect possible uses by just looking for the character (for
" performance) and then check that it's actually used by its own.
" (This also tries to detect preceding number constants; it does so in a crude
" way.)
syntax match   juliaPossibleEuler	"ℯ" contains=juliaEuler
exec 'syntax match   juliaEuler		contained "\%(\%(^\|[' . s:nonidS_chars . ']\|' . s:operators . '\)\%([.0-9eEf_]*\d\)\?\)\@'.s:d(80).'<=ℯ\ze\%($\|[' . s:nonidS_chars . ']\|' . s:operators . '\)"'
syntax match   juliaConstBool		display "\<\%(true\|false\)\>"
syntax match   juliaConstEnv		display "\<\%(ARGS\|ENV\|ENDIAN_BOM\|LOAD_PATH\|VERSION\|PROGRAM_FILE\|DEPOT_PATH\)\>"
syntax match   juliaConstIO		display "\<\%(std\%(out\|in\|err\)\|devnull\)\>"
syntax match   juliaConstC		display "\<\%(C_NULL\)\>"
syntax match   juliaConstGeneric	display "\<\%(nothing\|Main\|undef\|missing\)\>"

exec 'syntax match   juliaFunctionDef	contained transparent "\%(\<function\s\+\)\@'.s:d(20).'<=' . s:idregex . '\%(\.' . s:idregex . '\)*\ze\s\+\%(end\>\|$\)" contains=juliaFunctionName'
exec 'syntax region  juliaFunctionDefP	contained transparent start="\%(\<function\s\+\)\@'.s:d(20).'<=' . s:idregex . '\%(\.' . s:idregex . '\)*\s*(" end=")\@'.s:d(1).'<=" contains=juliaFunctionName,juliaParBlock'
exec 'syntax match   juliaFunctionName	contained "\%(\<function\s\+\)\@'.s:d(20).'<=' . s:idregex . '\%(\.' . s:idregex . '\)*"'

syntax match   juliaPossibleMacro	transparent "@" contains=juliaMacroCall,juliaMacroCallP,juliaPrintfMacro

exec 'syntax match   juliaMacro		contained "@' . s:idregex . '\%(\.' . s:idregex . '\)*"'
syntax match   juliaMacro		contained "@[!.~$%^*/\\|<>+-]\ze[^0-9]"
exec 'syntax region  juliaMacroCall	contained transparent start="\(@' . s:idregex . '\%(\.' . s:idregex . '\)*\)\@=\1\%([^(]\|$\)" end="\ze\%([])};#]\|$\|\<for\>\|\<end\>\)" contains=@juliaExpressions,juliaMacro,juliaSymbolS,juliaQuotedParBlockS'
exec 'syntax region  juliaMacroCall	contained transparent start="\(@.\)\@=\1\%([^(]\|$\)" end="\ze\%([])};#]\|$\|\<for\>\|\<end\>\)" contains=@juliaExpressions,juliaMacro,juliaSymbolS,juliaQuotedParBlockS'
exec 'syntax region  juliaMacroCallP	contained transparent start="@' . s:idregex . '\%(\.' . s:idregex . '\)*(" end=")\@'.s:d(1).'<=" contains=juliaMacro,juliaParBlock'
exec 'syntax region  juliaMacroCallP	contained transparent start="@.(" end=")\@'.s:d(1).'<=" contains=juliaMacro,juliaParBlock'

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
exec 'syntax region  juliaTernaryRegion	matchgroup=juliaTernaryOperator start="\s\zs?\ze\s" skip="\%(:\(:\|[^:[:space:]'."'".'"({[]\+\s*\ze:\)\|\%(?\s*\)\@'.s:d(6).'<=:(\)" end=":" contains=@juliaExpressions,juliaErrorSemicol'

let s:interp_dollar = '\([' . s:nonidS_chars . s:uniop_chars . s:binop_chars . '!?]\|^\)\@'.s:d(1).'<=\$'

exec 'syntax match   juliaDollarVar	display contained "' . s:interp_dollar . s:idregex . '"'
exec 'syntax region  juliaDollarPar	matchgroup=juliaDollarVar contained start="' .s:interp_dollar . '(" end=")" contains=@juliaExpressions'
exec 'syntax region  juliaDollarSqBra	matchgroup=juliaDollarVar contained start="' .s:interp_dollar . '\[" end="\]" contains=@juliaExpressions,juliaComprehensionFor,juliaSymbolS,juliaQuotedParBlockS'

syntax match   juliaChar		"'\\\?.'" contains=juliaSpecialChar
syntax match   juliaChar		display "'\\\o\{3\}'" contains=juliaOctalEscapeChar
syntax match   juliaChar		display "'\\x\x\{2\}'" contains=juliaHexEscapeChar
syntax match   juliaChar		display "'\\u\x\{1,4\}'" contains=juliaUniCharSmall
syntax match   juliaChar		display "'\\U\x\{1,8\}'" contains=juliaUniCharLarge

exec 'syntax match   juliaCTransOperator	"[[:space:]}' . s:nonid_chars . s:uniop_chars . s:binop_chars . '!?]\@'.s:d(1).'<!\.\?' . "'" . '"'

" TODO: some of these might be specialized; the rest could be just left to the
"       generic juliaStringPrefixed fallback
syntax region  juliaString		matchgroup=juliaStringDelim start=+\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaStringVars,@juliaSpecialChars,@juliaSpellcheckStrings
exec 'syntax region  juliaStringPrefixed	matchgroup=juliaStringDelim start=+\<' . s:idregex . '\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw'
syntax region  juliabString		matchgroup=juliaStringDelim start=+\<b\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialChars
syntax region  juliasString		matchgroup=juliaStringDelim start=+\<s\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialChars
syntax region  juliavString		matchgroup=juliaStringDelim start=+\<v\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw
syntax region  juliaipString		matchgroup=juliaStringDelim start=+\<ip\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw
syntax region  juliabigString		matchgroup=juliaStringDelim start=+\<big\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw
syntax region  juliaMIMEString		matchgroup=juliaStringDelim start=+\<MIME\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialChars
syntax region  juliarawString		matchgroup=juliaStringDelim start=+\<raw\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw
syntax region  juliatextString		matchgroup=juliaStringDelim start=+\<text\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw
syntax region  juliahtmlString		matchgroup=juliaStringDelim start=+\<html\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw
syntax region  juliaint128String	matchgroup=juliaStringDelim start=+\<u\?int128\z("\(""\)\?\)+ skip=+\%(\\\\\)*\\"+ end=+\z1+ contains=@juliaSpecialCharsRaw

syntax region  juliaDocString		matchgroup=juliaDocStringDelim fold start=+^"""+ skip=+\%(\\\\\)*\\"+ end=+"""+ contains=@juliaStringVars,@juliaSpecialChars,@juliaSpellcheckDocStrings

exec 'syntax region  juliaPrintfMacro		contained transparent start="@s\?printf(" end=")\@'.s:d(1).'<=" contains=juliaMacro,juliaPrintfParBlock'
syntax region  juliaPrintfMacro		contained transparent start="@s\?printf\s\+" end="\ze\%([])};#]\|$\|\<for\>\)" contains=@juliaExprsPrintf,juliaMacro,juliaSymbolS,juliaQuotedParBlockS
syntax region  juliaPrintfParBlock	contained matchgroup=juliaParDelim start="(" end=")" contains=@juliaExprsPrintf
syntax region  juliaPrintfString	contained matchgroup=juliaStringDelim start=+"+ skip=+\%(\\\\\)*\\"+ end=+"+ contains=@juliaSpecialChars,@juliaPrintfChars

syntax region  juliaShellString		matchgroup=juliaStringDelim start=+`+ skip=+\%(\\\\\)*\\`+ end=+`+ contains=@juliaStringVars,juliaSpecialChar

syntax cluster juliaStringVars		contains=juliaStringVarsPar,juliaStringVarsSqBra,juliaStringVarsCurBra,juliaStringVarsPla
syntax region  juliaStringVarsPar	contained matchgroup=juliaStringVarDelim start="$(" end=")" contains=@juliaExpressions
syntax region  juliaStringVarsSqBra	contained matchgroup=juliaStringVarDelim start="$\[" end="\]" contains=@juliaExpressions,juliaComprehensionFor,juliaSymbolS,juliaQuotedParBlockS
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
syntax cluster juliaSpecialCharsRaw	contains=juliaDoubleBackslash,juliaEscapedQuote
syntax match   juliaDoubleBackslash	display contained "\\\\"
syntax match   juliaEscapedQuote	display contained "\\\""

syntax cluster juliaPrintfChars		contains=juliaErrorPrintfFmt,juliaPrintfFmt
syntax match   juliaErrorPrintfFmt	display contained "\\\?%."
syntax match   juliaPrintfFmt		display contained "%\%(\d\+\$\)\=[-+' #0]*\%(\d*\|\*\|\*\d\+\$\)\%(\.\%(\d*\|\*\|\*\d\+\$\)\)\=\%([hlLjqzt]\|ll\|hh\)\=[aAbdiuoxXDOUfFeEgGcCsSpn]"
syntax match   juliaPrintfFmt		display contained "%%"
syntax match   juliaPrintfFmt		display contained "\\%\%(\d\+\$\)\=[-+' #0]*\%(\d*\|\*\|\*\d\+\$\)\%(\.\%(\d*\|\*\|\*\d\+\$\)\)\=\%([hlLjqzt]\|ll\|hh\)\=[aAbdiuoxXDOUfFeEgGcCsSpn]"hs=s+1
syntax match   juliaPrintfFmt		display contained "\\%%"hs=s+1

" this is used to restrict the search for Symbols to when colons appear at all
" (for performance reasons)
syntax match   juliaPossibleSymbol	transparent ":\ze[^:]" contains=juliaSymbol,juliaQuotedParBlock,juliaQuotedQMarkPar,juliaColon

let s:quotable = '\%(' . s:idregex . '\|?\|' . s:operators . '\|' . s:float_regex . '\|' . s:int_regex . '\)'
let s:quoting_colon = '\%(\%(^\s*\|\s\{6,\}\|[' . s:nonid_chars . s:uniop_chars . s:binop_chars . '?]\s*\)\@'.s:d(6).'<=\|\%(\<\%(return\|if\|else\%(if\)\?\|while\|try\|begin\)\s\+\)\@'.s:d(9).'<=\)\zs:'
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
exec 'syntax region   juliaQuotedParBlock	matchgroup=juliaQParDelim start="' . s:quoting_colon . '(" end=")" contains=@juliaExpressions'
exec 'syntax match    juliaQuotedQMarkPar	"' . s:quoting_colon . '(\s*?\s*)" contains=juliaQuotedQMark'
exec 'syntax region   juliaQuotedParBlockS	matchgroup=juliaQParDelim contained start="' . s:quoting_colonS . '(" end=")" contains=@juliaExpressions'


" force precedence over Symbols
syntax match   juliaOperator		display "::"

syntax region  juliaCommentL		matchgroup=juliaCommentDelim excludenl start="#\ze\%([^=]\|$\)" end="$" contains=juliaTodo,@juliaSpellcheckComments
syntax region  juliaCommentM		matchgroup=juliaCommentDelim fold start="#=\ze\%([^#]\|$\)" end="=#" contains=juliaTodo,juliaCommentM,@juliaSpellcheckComments
syntax keyword juliaTodo		contained TODO FIXME XXX

" detect an end-of-line with only whitespace or comments before it
let s:eol = '\s*\%(\%(\%(#=\%(=#\@!\|[^=]\|\n\)\{-}=#\)\s*\)\+\)\?\%(#=\@!.*\)\?\n'

" a trailing comma, or colon, or an empty line in an import/using/export
" multi-line command. Used to recognize the as keyword, and for indentation
" (this needs to take precedence over normal commas and colons, and comments)
syntax cluster juliaContinuationItems	contains=juliaContinuationComma,juliaContinuationColon,juliaContinuationNone
exec 'syntax region  juliaContinuationComma	matchgroup=juliaComma contained start=",\ze'.s:eol.'" end="\n\+\ze." contains=@juliaCommentItems'
exec 'syntax region  juliaContinuationColon	matchgroup=juliaColon contained start=":\ze'.s:eol.'" end="\n\+\ze." contains=@juliaCommentItems'
exec 'syntax region  juliaContinuationNone	matchgroup=NONE contained start="\%(\<\%(import\|using\|export\)\>\|^\)\@'.s:d(6).'<=\ze'.s:eol.'" end="\n\+\ze." contains=@juliaCommentItems,juliaAsKeyword'
exec 'syntax match   juliaMacroName		"@' . s:idregex . '\%(\.' . s:idregex . '\)*"'

" the following are disabled by default, but
" can be enabled by entering e.g.
"   :hi link juliaParDelim Delimiter
hi def link juliaParDelim		juliaNone
hi def link juliaSemicolon		juliaNone
hi def link juliaComma			juliaNone

hi def link juliaColon			juliaOperator

hi def link juliaFunctionName		juliaFunction
hi def link juliaMacroName		juliaMacro


hi def link juliaKeyword		Keyword
hi def link juliaInfixKeyword		Keyword
hi def link juliaAsKeyword		Keyword
hi def link juliaRepKeyword		Keyword
hi def link juliaBlKeyword		Keyword
hi def link juliaConditional		Conditional
hi def link juliaRepeat			Repeat
hi def link juliaException		Exception
hi def link juliaOuter			Keyword
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

" NOTE: deprecated constants are not highlighted as such. For once,
" one can still legitimately use them by importing Base.MathConstants.
" Plus, one-letter variables like `e` and `γ` can be used with other
" meanings.
hi def link juliaConstNum		Constant
hi def link juliaEuler			Constant

hi def link juliaConstEnv		Constant
hi def link juliaConstC			Constant
hi def link juliaConstLimits		Constant
hi def link juliaConstGeneric		Constant
hi def link juliaRangeKeyword		Constant
hi def link juliaConstBool		Boolean
hi def link juliaConstIO		Boolean

hi def link juliaComprehensionFor	Keyword
hi def link juliaComprehensionIf	Keyword

hi def link juliaDollarVar		Identifier

hi def link juliaFunction		Function
hi def link juliaMacro			Macro
hi def link juliaSymbol			Identifier
hi def link juliaSymbolS		Identifier
hi def link juliaQParDelim		Identifier
hi def link juliaQuotedQMarkPar		Identifier
hi def link juliaQuotedQMark		juliaOperatorHL

hi def link juliaNumber			Number
hi def link juliaFloat			Float
hi def link juliaComplexUnit		Constant

hi def link juliaChar			Character

hi def link juliaString			String
hi def link juliaStringPrefixed		juliaString
hi def link juliabString		juliaString
hi def link juliasString		juliaString
hi def link juliavString		juliaString
hi def link juliarString		juliaString
hi def link juliaipString		juliaString
hi def link juliabigString		juliaString
hi def link juliaMIMEString		juliaString
hi def link juliarawString		juliaString
hi def link juliatestString		juliaString
hi def link juliahtmlString		juliaString
hi def link juliaint128String		juliaString
hi def link juliaPrintfString		juliaString
hi def link juliaShellString		juliaString
hi def link juliaDocString		juliaString
hi def link juliaStringDelim		juliaString
hi def link juliaDocStringDelim		juliaDocString
hi def link juliaStringVarsPla		Identifier
hi def link juliaStringVarDelim		Identifier

hi def link juliaRegEx			String

hi def link juliaSpecialChar		SpecialChar
hi def link juliaOctalEscapeChar	SpecialChar
hi def link juliaHexEscapeChar		SpecialChar
hi def link juliaUniCharSmall		SpecialChar
hi def link juliaUniCharLarge		SpecialChar
hi def link juliaDoubleBackslash	SpecialChar
hi def link juliaEscapedQuote		SpecialChar

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

syntax sync fromstart

let b:current_syntax = "julia"
