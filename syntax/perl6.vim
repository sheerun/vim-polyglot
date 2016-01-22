if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1
  
" Vim syntax file
" Language:      Perl 6
" Maintainer:    vim-perl <vim-perl@googlegroups.com>
" Homepage:      http://github.com/vim-perl/vim-perl/tree/master
" Bugs/requests: http://github.com/vim-perl/vim-perl/issues
" Last Change:   {{LAST_CHANGE}}

" Contributors:  Luke Palmer <fibonaci@babylonia.flatirons.org>
"                Moritz Lenz <moritz@faui2k3.org>
"                Hinrik Örn Sigurðsson <hinrik.sig@gmail.com>
"
" This is a big undertaking. Perl 6 is the sort of language that only Perl
" can parse. But I'll do my best to get vim to.
"
" The ftdetect/perl11.vim file in this repository takes care of setting the
" right filetype for Perl 6 files. To set it explicitly you can also add this
" line near the bottom of your source file:
"   # vim: filetype=perl6

" TODO:
"   * Go over the list of keywords/types to see what's deprecated/missing
"   * Add more support for folding (:help syn-fold)
"
" If you want to have Pir code inside Q:PIR// strings highlighted, do:
"   let perl6_embedded_pir=1
"
" The above requires pir.vim, which you can find in Parrot's repository:
" https://github.com/parrot/parrot/tree/master/editor
"
" To highlight Perl 5 regexes (m:P5//):
"   let perl6_perl5_regexes=1
"
" To enable folding:
"   let perl6_fold=1

if version < 704 | throw "perl6.vim uses regex syntax which Vim <7.4 doesn't support. Try 'make fix_old_vim' in the vim-perl repository." | endif

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif
let s:keepcpo= &cpo
set cpo&vim

" Patterns which will be interpolated by the preprocessor (tools/preproc.pl):
"
" @@IDENT_NONDIGIT@@     "[A-Za-z_\xC0-\xFF]"
" @@IDENT_CHAR@@         "[A-Za-z_\xC0-\xFF0-9]"
" @@IDENTIFIER@@         "\%(@@IDENT_NONDIGIT@@\%(@@IDENT_CHAR@@\|[-']@@IDENT_NONDIGIT@@\@=\)*\)"
" @@IDENTIFIER_START@@   "@@IDENT_CHAR@@\@1<!\%(@@IDENT_NONDIGIT@@[-']\)\@2<!"
" @@IDENTIFIER_END@@     "\%(@@IDENT_CHAR@@\|[-']@@IDENT_NONDIGIT@@\)\@!"
" @@METAOP@@             #\%(\d\|[@%$][.?^=[:alpha:]]\)\@!\%(\.\|[^[{('".[:space:]]\)\+#
" @@ADVERBS@@            "\%(\_s*:!\?@@IDENTIFIER@@\%(([^)]*)\)\?\)*"
"
" Same but escaped, for use in string eval
" @@IDENT_NONDIGIT_Q@@   "[A-Za-z_\\xC0-\\xFF]"
" @@IDENT_CHAR_Q@@       "[A-Za-z_\\xC0-\\xFF0-9]"
" @@IDENTIFIER_Q@@       "\\%(@@IDENT_NONDIGIT_Q@@\\%(@@IDENT_CHAR_Q@@\\|[-']@@IDENT_NONDIGIT_Q@@\\@=\\)*\\)"
" @@IDENTIFIER_START_Q@@ "@@IDENT_CHAR_Q@@\\@1<!\\%(@@IDENT_NONDIGIT_Q@@[-']\\)\\@2<!"
" @@IDENTIFIER_END_Q@@   "\\%(@@IDENT_CHAR_Q@@\\|[-']@@IDENT_NONDIGIT_Q@@\\)\\@!"

" Identifiers (subroutines, methods, constants, classes, roles, etc)
syn match p6Identifier display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"

let s:keywords = {
 \ "p6DeclareRoutine": [
 \   "macro sub submethod method multi proto only category unit",
 \ ],
 \ "p6Module": [
 \   "module class role package enum grammar slang subset",
 \ ],
 \ "p6Include": [
 \   "use require",
 \ ],
 \ "p6Conditional": [
 \   "if else elsif unless",
 \ ],
 \ "p6VarStorage": [
 \   "let my our state temp has constant",
 \ ],
 \ "p6Repeat": [
 \   "for loop repeat while until gather given",
 \ ],
 \ "p6FlowControl": [
 \   "take do when next last redo return contend maybe defer start",
 \   "default exit make continue break goto leave async lift",
 \ ],
 \ "p6ClosureTrait": [
 \   "BEGIN CHECK INIT START FIRST ENTER LEAVE KEEP",
 \   "UNDO NEXT LAST PRE POST END CATCH CONTROL TEMP",
 \ ],
 \ "p6Exception": [
 \   "die fail try warn",
 \ ],
 \ "p6Pragma": [
 \   "oo fatal",
 \ ],
 \ "p6Operator": [
 \   "div xx x mod also leg cmp before after eq ne le lt not",
 \   "gt ge eqv ff fff and andthen or xor orelse extra lcm gcd o",
 \ ],
 \ "p6Type": [
 \   "int int1 int2 int4 int8 int16 int32 int64",
 \   "rat rat1 rat2 rat4 rat8 rat16 rat32 rat64",
 \   "buf buf1 buf2 buf4 buf8 buf16 buf32 buf64",
 \   "uint uint1 uint2 uint4 uint8 uint16 uint32 bit bool",
 \   "uint64 utf8 utf16 utf32 bag set mix num complex",
 \ ],
\ }

" These can be immediately followed by parentheses
let s:types = [
 \ "Object Any Junction Whatever Capture Match",
 \ "Signature Proxy Matcher Package Module Class",
 \ "Grammar Scalar Array Hash KeyHash KeySet KeyBag",
 \ "Pair List Seq Range Set Bag Mapping Void Undef",
 \ "Failure Exception Code Block Routine Sub Macro",
 \ "Method Submethod Regex Str Blob Char Byte Parcel",
 \ "Codepoint Grapheme StrPos StrLen Version Num",
 \ "Complex Bit True False Order Same Less More",
 \ "Increasing Decreasing Ordered Callable AnyChar",
 \ "Positional Associative Ordering KeyExtractor",
 \ "Comparator OrderingPair IO KitchenSink Role",
 \ "Int Rat Buf UInt Abstraction Numeric Real",
 \ "Nil Mu",
\ ]

" We explicitly enumerate the alphanumeric infix operators allowed after [RSXZ]
" to avoid matching package names that start with those letters.
let s:alpha_metaops = [
 \ "div mod gcd lcm xx x does but cmp leg eq ne gt ge lt le before after eqv",
 \ "min max not so andthen and or orelse",
\ ]
let s:words_space = join(s:alpha_metaops, " ")
let s:temp = split(s:words_space)
let s:alpha_metaops_or = join(s:temp, "\\|")

" We don't use "syn keyword" here because that always has higher priority
" than matches/regions, which would prevent these words from matching as
" autoquoted strings before "=>" or "p5=>".
syn match p6KeywordStart display "\%(\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\)\@!\)\@=[A-Za-z_\xC0-\xFF0-9]\@1<!\%([A-Za-z_\xC0-\xFF][-']\)\@2<!"
    \ nextgroup=p6Attention,p6DeclareRoutine,p6Module,p6Variable,p6Include,p6Conditional,p6VarStorage,p6Repeat,p6FlowControl,p6ClosureTrait,p6Exception,p6Number,p6Pragma,p6Type,p6Operator,p6Identifier

for [group, words] in items(s:keywords)
    let s:words_space = join(words, " ")
    let s:temp = split(s:words_space)
    let s:words = join(s:temp, "\\|")
    exec "syn match ". group ." display \"[.^]\\@1<!\\%(". s:words . "\\)(\\@!\\%([A-Za-z_\\xC0-\\xFF0-9]\\|[-'][A-Za-z_\\xC0-\\xFF]\\)\\@!\" contained"
endfor

let s:words_space = join(s:types, " ")
let s:temp = split(s:words_space)
let s:words = join(s:temp, "\\|")
exec "syn match p6Type display \"\\%(". s:words . "\\)\\%([A-Za-z_\\xC0-\\xFF0-9]\\|[-'][A-Za-z_\\xC0-\\xFF]\\)\\@!\" contained"
unlet s:keywords s:types s:words_space s:temp s:words

syn match p6TypeConstraint  display "\%([.^]\|^\s*\)\@<!\a\@=\%(does\|as\|but\|trusts\|of\|returns\|handles\|where\|augment\|supersede\)\>"
syn match p6TypeConstraint  display "\%([.^]\|^\s*\)\@<![A-Za-z_\xC0-\xFF0-9]\@1<!\%([A-Za-z_\xC0-\xFF][-']\)\@2<!is\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\)\@!" skipwhite skipempty nextgroup=p6Property
syn match p6Property        display "\a\@=\%(signature\|context\|also\|shape\|prec\|irs\|ofs\|ors\|export\|deep\|binary\|unary\|reparsed\|rw\|parsed\|cached\|readonly\|defequiv\|will\|ref\|copy\|inline\|tighter\|looser\|equiv\|assoc\|required\)" contained

" packages, must come after all the keywords
syn match p6Identifier display "\%(::\)\@2<=\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)*"
syn match p6Identifier display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(::\)\@="

" The sigil in ::*Package
syn match p6PackageTwigil display "\%(::\)\@2<=\*"

" some standard packages
syn match p6Type display "\%(::\)\@2<!\%(Order\%(::Same\|::More\|::Less\)\?\|Bool\%(::True\|::False\)\?\)\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\)\@!"

" Don't put a "\+" at the end of the character class. That makes it so
" greedy that the "%" " in "+%foo" won't be allowed to match as a sigil,
" among other things
syn match p6Operator display "[-+/*~?|=^!%&,<>».;\\∈∉∋∌∩∪≼≽⊂⊃⊄⊅⊆⊇⊈⊉⊍⊎⊖∅∘]"
syn match p6Operator display "\%(:\@1<!::\@2!\|::=\|\.::\)"
" these require whitespace on the left side
syn match p6Operator display "\%(\s\|^\)\@1<=\%(xx=\|p5=>\)"
" index overloading
syn match p6Operator display "\%(&\.(\@=\|@\.\[\@=\|%\.{\@=\)"

" Reduce metaoperators like [+]
syn match p6ReduceOp display "\%(^\|\s\|(\)\@1<=!*\%([RSXZ\[]\)*[&RSXZ]\?\[\+(\?\%(\d\|[@%$][.?^=[:alpha:]]\)\@!\%(\.\|[^[{('".[:space:]]\)\+)\?]\+"
syn match p6SetOp    display "R\?(\%([-^.+|&]\|[<>][=+]\?\|cont\|elem\))"

" Reverse, cross, and zip metaoperators
exec "syn match p6RSXZOp display \"[RSXZ]:\\@!\\%(\\a\\@=\\%(". s:alpha_metaops_or . "\\)\\>\\|[[:alnum:]]\\@!\\%([.,]\\|[^[,.[:space:]]\\)\\+\\|\\s\\@=\\|$\\)\""

syn match p6BlockLabel display "^\s*\zs\h\w*\s*::\@!\_s\@="

syn match p6Number     display "[A-Za-z_\xC0-\xFF0-9]\@1<!\%(\%(\%(\_^\|\s\|[^*\a]\)\@1<=[-+]\)\?Inf\|NaN\)"
syn match p6Number     display "[A-Za-z_\xC0-\xFF0-9]\@1<!\%(\%(\_^\|\s\|[^*\a]\)\@1<=[-+]\)\?\%(\%(\d\|__\@!\)*[._]\@1<!\.\)\?_\@!\%(\d\|_\)\+_\@1<!\%([eE]-\?_\@!\%(\d\|_\)\+\)\?i\?"
syn match p6Number     display "[A-Za-z_\xC0-\xFF0-9]\@1<!\%(\%(\_^\|\s\|[^*\a]\)\@1<=[-+]\)\?0[obxd]\@="  nextgroup=p6OctBase,p6BinBase,p6HexBase,p6DecBase
syn match p6OctBase    display "o" contained nextgroup=p6OctNumber
syn match p6BinBase    display "b" contained nextgroup=p6BinNumber
syn match p6HexBase    display "x" contained nextgroup=p6HexNumber
syn match p6DecBase    display "d" contained nextgroup=p6DecNumber
syn match p6OctNumber  display "[0-7][0-7_]*" contained
syn match p6BinNumber  display "[01][01_]*" contained
syn match p6HexNumber  display "\x[[:xdigit:]_]*" contained
syn match p6DecNumber  display "\d[[:digit:]_]*" contained

syn match p6Version    display "\<v\d\+\%(\.\%(\*\|\d\+\)\)*+\?"

" Contextualizers
syn match p6Context display "\<\%(item\|list\|slice\|hash\)\>"
syn match p6Context display "\%(\$\|@\|%\|&\)(\@="

" Quoting

" one cluster for every quote adverb
syn cluster p6Interp_scalar
    \ add=p6InterpScalar

syn cluster p6Interp_array
    \ add=p6InterpArray

syn cluster p6Interp_hash
    \ add=p6InterpHash

syn cluster p6Interp_function
    \ add=p6InterpFunction

syn cluster p6Interp_closure
    \ add=p6InterpClosure

syn cluster p6Interp_q
    \ add=p6EscQQ
    \ add=p6EscBackSlash

syn cluster p6Interp_backslash
    \ add=@p6Interp_q
    \ add=p6Escape
    \ add=p6EscOpenCurly
    \ add=p6EscCodePoint
    \ add=p6EscHex
    \ add=p6EscOct
    \ add=p6EscOctOld
    \ add=p6EscNull

syn cluster p6Interp_qq
    \ add=@p6Interp_scalar
    \ add=@p6Interp_array
    \ add=@p6Interp_hash
    \ add=@p6Interp_function
    \ add=@p6Interp_closure
    \ add=@p6Interp_backslash
    \ add=p6MatchVarSigil

syn region p6InterpScalar
    \ start="\ze\z(\$\%(\%(\%(\d\+\|!\|/\|¢\)\|\%(\%(\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\@=\)\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)\%(\.\^\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\|\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)*\)\.\?\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)\)"
    \ start="\ze\z(\$\%(\%(\%(\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\@=\)\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)\|\%(\d\+\|!\|/\|¢\)\)\)"
    \ end="\z1\zs"
    \ contained keepend
    \ contains=TOP

syn region p6InterpScalar
    \ matchgroup=p6Context
    \ start="\$\ze()\@!"
    \ skip="([^)]*)"
    \ end=")\zs"
    \ contained
    \ contains=TOP

syn region p6InterpArray
    \ start="\ze\z(@\$*\%(\%(\%(!\|/\|¢\)\|\%(\%(\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\@=\)\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)\%(\.\^\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\|\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)*\)\.\?\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)\)"
    \ end="\z1\zs"
    \ contained keepend
    \ contains=TOP

syn region p6InterpArray
    \ matchgroup=p6Context
    \ start="@\ze()\@!"
    \ skip="([^)]*)"
    \ end=")\zs"
    \ contained
    \ contains=TOP

syn region p6InterpHash
    \ start="\ze\z(%\$*\%(\%(\%(!\|/\|¢\)\|\%(\%(\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\@=\)\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)\%(\.\^\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\|\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)*\)\.\?\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)\)"
    \ end="\z1\zs"
    \ contained keepend
    \ contains=TOP

syn region p6InterpHash
    \ matchgroup=p6Context
    \ start="%\ze()\@!"
    \ skip="([^)]*)"
    \ end=")\zs"
    \ contained
    \ contains=TOP

syn region p6InterpFunction
    \ start="\ze\z(&\%(\%(!\|/\|¢\)\|\%(\%(\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\@=\)\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(\.\^\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\|\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)*\)\.\?\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\)\)"
    \ end="\z1\zs"
    \ contained keepend
    \ contains=TOP

syn region p6InterpFunction
    \ matchgroup=p6Context
    \ start="&\ze()\@!"
    \ skip="([^)]*)"
    \ end=")\zs"
    \ contained
    \ contains=TOP

syn region p6InterpClosure
    \ start="\\\@1<!{}\@!"
    \ skip="{[^}]*}"
    \ end="}"
    \ contained keepend
    \ contains=TOP

" generic escape
syn match p6Escape          display "\\\S" contained

" escaped closing delimiters
syn match p6EscQuote        display "\\'" contained
syn match p6EscDoubleQuote  display "\\\"" contained
syn match p6EscCloseAngle   display "\\>" contained
syn match p6EscCloseFrench  display "\\»" contained
syn match p6EscBackTick     display "\\`" contained
syn match p6EscForwardSlash display "\\/" contained
syn match p6EscVerticalBar  display "\\|" contained
syn match p6EscExclamation  display "\\!" contained
syn match p6EscComma        display "\\," contained
syn match p6EscDollar       display "\\\$" contained
syn match p6EscCloseCurly   display "\\}" contained
syn match p6EscCloseBracket display "\\\]" contained

" matches :key, :!key, :$var, :key<var>, etc
" Since we don't know in advance how the adverb ends, we use a trick.
" Consume nothing with the start pattern (\ze at the beginning),
" while capturing the whole adverb into \z1 and then putting it before
" the match start (\zs) of the end pattern.
syn region p6Adverb
    \ start="\ze\z(:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\|\[[^\]]*]\|<[^>]*>\|«[^»]*»\|{[^}]*}\)\?\)"
    \ start="\ze\z(:!\?[@$%]\$*\%(::\|\%(\$\@1<=\d\+\|!\|/\|¢\)\|\%(\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\)\|\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)\)"
    \ end="\z1\zs"
    \ contained keepend
    \ contains=TOP

" <words>
" Distinguishing this from the "less than" operator is tricky. For now,
" it matches if any of the following is true:
"
" * There is whitespace missing on either side of the "<", since
"   people tend to put spaces around "less than". We make an exception
"   for " = < ... >" assignments though.
" * It comes after "enum", "for", "any", "all", or "none"
" * It's the first or last thing on a line (ignoring whitespace)
" * It's preceded by "(\s*" or "=\s\+"
" * It's empty and terminated on the same line (e.g. <> and < >)
"
" It never matches when:
"
" * Preceded by [<+~=!] (e.g. <<foo>>, =<$foo>, * !< 3)
" * Followed by [-=] (e.g. <--, <=, <==, <->)
syn region p6StringAngle
    \ matchgroup=p6Quote
    \ start="\%(\<\%(enum\|for\|any\|all\|none\)\>\s*(\?\s*\)\@<=<\%(<\|=>\|[-=]\{1,2}>\@!\)\@!"
    \ start="\%(\s\|[<+~=!]\)\@<!<\%(<\|=>\|[-=]\{1,2}>\@!\)\@!"
    \ start="[<+~=!]\@1<!<\%(\s\|<\|=>\|[-=]\{1,2}\)\@!"
    \ start="\%(^\s*\)\@<=<\%(<\|=>\|[-=]\{1,2}>\@!\)\@!"
    \ start="[<+~=!]\@1<!<\%(\s*$\)\@="
    \ start="\%((\s*\|=\s\+\)\@<=<\%(<\|=>\|[-=]\{1,2}>\@!\)\@!"
    \ start="<\%(\s*>\)\@="
    \ skip="\\\@1<!\\>"
    \ end=">"
    \ contains=p6InnerAnglesOne,p6EscBackSlash,p6EscCloseAngle

syn region p6StringAngleFixed
    \ matchgroup=p6Quote
    \ start="<"
    \ skip="\\\@1<!\\>"
    \ end=">"
    \ contains=p6InnerAnglesOne,p6EscBackSlash,p6EscCloseAngle
    \ contained

syn region p6InnerAnglesOne
    \ matchgroup=p6StringAngle
    \ start="\\\@1<!<"
    \ skip="\\\@1<!\\>"
    \ end=">"
    \ transparent contained
    \ contains=p6InnerAnglesOne

" <<words>>
syn region p6StringAngles
    \ matchgroup=p6Quote
    \ start="<<=\@!"
    \ skip="\\\@1<!\\>"
    \ end=">>"
    \ contains=p6InnerAnglesTwo,@p6Interp_qq,p6Comment,p6BracketComment,p6EscHash,p6EscCloseAngle,p6Adverb,p6StringSQ,p6StringDQ

syn region p6InnerAnglesTwo
    \ matchgroup=p6StringAngles
    \ start="<<"
    \ skip="\\\@1<!\\>"
    \ end=">>"
    \ transparent contained
    \ contains=p6InnerAnglesTwo

" «words»
syn region p6StringFrench
    \ matchgroup=p6Quote
    \ start="«"
    \ skip="\\\@1<!\\»"
    \ end="»"
    \ contains=p6InnerFrench,@p6Interp_qq,p6Comment,p6BracketComment,p6EscHash,p6EscCloseFrench,p6Adverb,p6StringSQ,p6StringDQ

syn region p6InnerFrench
    \ matchgroup=p6StringFrench
    \ start="\\\@1<!«"
    \ skip="\\\@1<!\\»"
    \ end="»"
    \ transparent contained
    \ contains=p6InnerFrench

" Hyperops. They need to come after "<>" and "«»" strings in order to override
" them, but before other types of strings, to avoid matching those delimiters
" as parts of hyperops.
syn match p6HyperOp display #[^[:digit:][{('",:[:space:]][^[{('",:[:space:]]*\%(«\|<<\)#
syn match p6HyperOp display "«\%(\d\|[@%$][.?^=[:alpha:]]\)\@!\%(\.\|[^[{('".[:space:]]\)\+[«»]"
syn match p6HyperOp display "»\%(\d\|[@%$][.?^=[:alpha:]]\)\@!\%(\.\|[^[{('".[:space:]]\)\+\%(«\|»\?\)"
syn match p6HyperOp display "<<\%(\d\|[@%$][.?^=[:alpha:]]\)\@!\%(\.\|[^[{('".[:space:]]\)\+\%(<<\|>>\)"
syn match p6HyperOp display ">>\%(\d\|[@%$][.?^=[:alpha:]]\)\@!\%(\.\|[^[{('".[:space:]]\)\+\%(<<\|\%(>>\)\?\)"

" 'string'
syn region p6StringSQ
    \ matchgroup=p6Quote
    \ start="'"
    \ skip="\\\@1<!\\'"
    \ end="'"
    \ contains=@p6Interp_q,p6EscQuote
    \ keepend extend

" "string"
syn region p6StringDQ
    \ matchgroup=p6Quote
    \ start=+"+
    \ skip=+\\\@1<!\\"+
    \ end=+"+
    \ contains=@p6Interp_qq,p6EscDoubleQuote
    \ keepend extend

" Q// and friends

syn match p6QuoteQStart display "\%(:\|\%(sub\|role\)\s\)\@5<![Qq]\@=" nextgroup=p6QuoteQ,p6QuoteQ_q,p6QuoteQ_qww,p6QuoteQ_qq,p6QuoteQ_qto,p6QuoteQ_qqto,p6Identifier
syn match p6QuoteQ      display "Q\%(qq\|ww\|[abcfhpsqvwx]\)\?[A-Za-z(]\@!" nextgroup=p6PairsQ skipwhite skipempty contained
syn match p6QuoteQ_q    display "q[abcfhpsvwx]\?[A-Za-z(]\@!" nextgroup=p6PairsQ_q skipwhite skipempty contained
syn match p6QuoteQ_qww  display "qww[A-Za-z(]\@!" nextgroup=p6PairsQ_qww skipwhite skipempty contained
syn match p6QuoteQ_qq   display "qq[pwx]\?[A-Za-z(]\@!" nextgroup=p6PairsQ_qq skipwhite skipempty contained
syn match p6QuoteQ_qto  display "qto[A-Za-z(]\@!" nextgroup=p6StringQ_qto skipwhite skipempty contained
syn match p6QuoteQ_qqto display "qqto[A-Za-z(]\@!" nextgroup=p6StringQ_qqto skipwhite skipempty contained
syn match p6QuoteQ_qto  display "q\_s*\%(\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*:\%(to\|heredoc\)\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*(\@!\)\@=" nextgroup=p6PairsQ_qto skipwhite skipempty contained
syn match p6QuoteQ_qqto display "qq\_s*\%(\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*:\%(to\|heredoc\)\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*(\@!\)\@=" nextgroup=p6PairsQ_qqto skipwhite skipempty contained
syn match p6PairsQ      "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6StringQ
syn match p6PairsQ_q    "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6StringQ_q
syn match p6PairsQ_qww  "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6StringQ_qww
syn match p6PairsQ_qq   "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6StringQ_qq
syn match p6PairsQ_qto  "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6StringQ_qto
syn match p6PairsQ_qqto "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6StringQ_qqto


if exists("perl6_embedded_pir") || exists("perl6_extended_all")
    syn include @p6PIR syntax/pir.vim
    syn match p6Quote_QPIR display "Q[A-Za-z(]\@!\%(\_s*:PIR\)\@=" nextgroup=p6PairsQ_PIR skipwhite skipempty
    syn match p6Pairs_QPIR contained "\_s*:PIR" transparent skipwhite skipempty nextgroup=p6StringQ_PIR
endif

" hardcoded set of delimiters
let s:plain_delims = [
  \ ["DQ",          "\\\"",         "\\\"", "p6EscDoubleQuote",  "\\\\\\@1<!\\\\\\\""],
  \ ["SQ",          "'",            "'",    "p6EscQuote",        "\\\\\\@1<!\\\\'"],
  \ ["Slash",       "/",            "/",    "p6EscForwardSlash", "\\\\\\@1<!\\\\/"],
  \ ["BackTick",    "`",            "`",    "p6EscBackTick",     "\\\\\\@1<!\\\\`"],
  \ ["Bar",         "|",            "|",    "p6EscVerticalBar",  "\\\\\\@1<!\\\\|"],
  \ ["Exclamation", "!",            "!",    "p6EscExclamation",  "\\\\\\@1<!\\\\!"],
  \ ["Comma",       ",",            ",",    "p6EscComma",        "\\\\\\@1<!\\\\,"],
  \ ["Dollar",      "\\$",          "\\$",  "p6EscDollar",       "\\\\\\@1<!\\\\\\$"],
\ ]
let s:bracketing_delims = [
  \ ["Curly",   "{",            "}",    "p6EscCloseCurly",   "\\%(\\\\\\@1<!\\\\}\\|{[^}]*}\\)"],
  \ ["Angle",   "<",            ">",    "p6EscCloseAngle",   "\\%(\\\\\\@1<!\\\\>\\|<[^>]*>\\)"],
  \ ["French",  "«",            "»",    "p6EscCloseFrench",  "\\%(\\\\\\@1<!\\\\»\\|«[^»]*»\\)"],
  \ ["Bracket", "\\\[",         "]",    "p6EscCloseBracket", "\\%(\\\\\\@1<!\\\\]\\|\\[^\\]]*]\\)"],
  \ ["Paren",   "\\s\\@1<=(",   ")",    "p6EscCloseParen",   "\\%(\\\\\\@1<!\\\\)\\|([^)]*)\\)"],
\ ]
let s:all_delims = s:plain_delims + s:bracketing_delims

for [name, start_delim, end_delim, end_group, skip] in s:all_delims
    exec "syn region p6StringQ matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contains=".end_group." contained"
    exec "syn region p6StringQ_q matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contains=@p6Interp_q,".end_group." contained"
    exec "syn region p6StringQ_qww matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contains=@p6Interp_q,p6StringSQ,p6StringDQ".end_group." contained"
    exec "syn region p6StringQ_qq matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contains=@p6Interp_qq,".end_group." contained"
    exec "syn region p6StringQ_qto matchgroup=p6Quote start=\"".start_delim."\\z([^".end_delim."]\\+\\)".end_delim."\" skip=\"".skip."\" end=\"^\\s*\\z1$\" contains=@p6Interp_q,".end_group." contained"
    exec "syn region p6StringQ_qqto matchgroup=p6Quote start=\"".start_delim."\\z(\[^".end_delim."]\\+\\)".end_delim."\" skip=\"".skip."\" end=\"^\\s*\\z1$\" contains=@p6Interp_qq,".end_group." contained"

    if exists("perl6_embedded_pir") || exists("perl6_extended_all")
        exec "syn region p6StringQ_PIR matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contains=@p6PIR,".end_group." contained"
    endif
endfor
unlet s:plain_delims s:all_delims

" :key
syn match p6Operator display ":\@1<!::\@!!\?" nextgroup=p6Key,p6StringAngleFixed,p6StringAngles,p6StringFrench
syn match p6Key display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)" contained nextgroup=p6StringAngleFixed,p6StringAngles,p6StringFrench

" Regexes and grammars

syn match p6DeclareRegex display "\%(regex\|rule\|token\)" nextgroup=p6RegexName skipwhite skipempty
syn match p6RegexName    display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\?" nextgroup=p6RegexBlockCrap skipwhite skipempty contained
syn match p6RegexBlockCrap "[^{]*" nextgroup=p6RegexBlock skipwhite skipempty transparent contained

syn region p6RegexBlock
    \ matchgroup=p6Normal
    \ start="{"
    \ end="}"
    \ contained
    \ contains=@p6Regexen,@p6Variables

" Perl 6 regex bits

syn cluster p6Regexen
    \ add=p6RxMeta
    \ add=p6RxEscape
    \ add=p6EscCodePoint
    \ add=p6EscHex
    \ add=p6EscOct
    \ add=p6EscNull
    \ add=p6RxAnchor
    \ add=p6RxCapture
    \ add=p6RxGroup
    \ add=p6RxAlternation
    \ add=p6RxBoundary
    \ add=p6RxAdverb
    \ add=p6RxAdverbArg
    \ add=p6RxStorage
    \ add=p6RxAssertion
    \ add=p6RxAssertGroup
    \ add=p6RxQuoteWords
    \ add=p6RxClosure
    \ add=p6RxStringSQ
    \ add=p6RxStringDQ
    \ add=p6Comment
    \ add=p6BracketComment
    \ add=p6MatchVarSigil

syn match p6RxMeta        display contained ".\%([A-Za-z_\xC0-\xFF0-9]\|\s\)\@1<!"
syn match p6RxAnchor      display contained "[$^]"
syn match p6RxEscape      display contained "\\\S"
syn match p6RxCapture     display contained "[()]"
syn match p6RxAlternation display contained "|"
syn match p6RxRange       display contained "\.\."

" misc escapes
syn match p6EscOctOld    display "\\[1-9]\d\{1,2}" contained
syn match p6EscNull      display "\\0\d\@!" contained
syn match p6EscCodePoint display "\\[cC]" contained nextgroup=p6CodePoint
syn match p6EscHex       display "\\[xX]" contained nextgroup=p6HexSequence
syn match p6EscOct       display "\\o" contained nextgroup=p6OctSequence
syn match p6EscQQ        display "\\qq" contained nextgroup=p6QQSequence
syn match p6EscOpenCurly display "\\{" contained
syn match p6EscHash      display "\\#" contained
syn match p6EscBackSlash display "\\\\" contained

syn region p6QQSequence
    \ matchgroup=p6Escape
    \ start="\["
    \ skip="\[[^\]]*]"
    \ end="]"
    \ contained transparent
    \ contains=@p6Interp_qq

syn match p6CodePoint   display "\%(\d\+\|\S\)" contained
syn region p6CodePoint
    \ matchgroup=p6Escape
    \ start="\["
    \ end="]"
    \ contained

syn match p6HexSequence display "\x\+" contained
syn region p6HexSequence
    \ matchgroup=p6Escape
    \ start="\["
    \ end="]"
    \ contained

syn match p6OctSequence display "\o\+" contained
syn region p6OctSequence
    \ matchgroup=p6Escape
    \ start="\["
    \ end="]"
    \ contained

" $<match>, @<match>
syn region p6MatchVarSigil
    \ matchgroup=p6Variable
    \ start="[$@]\%(<<\@!\)\@="
    \ end=">\@1<="
    \ contains=p6MatchVar

syn region p6MatchVar
    \ matchgroup=p6Twigil
    \ start="<"
    \ end=">"
    \ contained

syn region p6RxClosure
    \ matchgroup=p6Normal
    \ start="{"
    \ end="}"
    \ contained
    \ containedin=p6RxClosure
    \ contains=TOP
syn region p6RxGroup
    \ matchgroup=p6StringSpecial2
    \ start="\["
    \ end="]"
    \ contained
    \ contains=@p6Regexen,@p6Variables,p6MatchVarSigil
syn region p6RxAssertion
    \ matchgroup=p6StringSpecial2
    \ start="<\%(?\?\%(before\|after\)\|\%(\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)=\)\|[+?*]\)\?"
    \ end=">"
    \ contained
    \ contains=@p6Regexen,p6Identifier,@p6Variables,p6RxCharClass,p6RxAssertCall
syn region p6RxAssertGroup
    \ matchgroup=p6StringSpecial2
    \ start="<\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)=\["
    \ skip="\\\@1<!\\]"
    \ end="]"
    \ contained
syn match p6RxAssertCall display "\%(::\|\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)" contained nextgroup=p6RxAssertArgs
syn region p6RxAssertArgs
    \ start="("
    \ end=")"
    \ contained keepend
    \ contains=TOP
syn region p6RxAssertArgs
    \ start=":"
    \ end="\ze>"
    \ contained keepend
    \ contains=TOP
syn match p6RxBoundary display contained "\%([«»]\|<<\|>>\)"
syn region p6RxCharClass
    \ matchgroup=p6StringSpecial2
    \ start="\%(<[-!+?]\?\)\@2<=\["
    \ skip="\\]"
    \ end="]"
    \ contained
    \ contains=p6RxRange,p6RxEscape,p6EscHex,p6EscOct,p6EscCodePoint,p6EscNull
syn region p6RxQuoteWords
    \ matchgroup=p6StringSpecial2
    \ start="<\s"
    \ end="\s\?>"
    \ contained
syn region p6RxAdverb
    \ start="\ze\z(:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)"
    \ end="\z1\zs"
    \ contained keepend
    \ contains=TOP
syn region p6RxAdverbArg
    \ start="\%(:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\)\@<=("
    \ skip="([^)]\{-})"
    \ end=")"
    \ contained
    \ keepend
    \ contains=TOP
syn region p6RxStorage
    \ matchgroup=p6Operator
    \ start="\%(^\s*\)\@<=:\%(my\>\|temp\>\)\@="
    \ end="$"
    \ contains=TOP
    \ contained
    \ keepend

" 'string' inside a regex
syn region p6RxStringSQ
    \ matchgroup=p6Quote
    \ start="'"
    \ skip="\\\@1<!\\'"
    \ end="'"
    \ contained
    \ contains=p6EscQuote,p6EscBackSlash

" "string" inside a regex
syn region p6RxStringDQ
    \ matchgroup=p6Quote
    \ start=+"+
    \ skip=+\\\@1<!\\"+
    \ end=+"+
    \ contained
    \ contains=p6EscDoubleQuote,p6EscBackSlash,@p6Interp_qq

" $!, $var, $!var, $::var, $package::var $*::package::var, etc
" Thus must come after the matches for the "$" regex anchor, but before
" the match for the $ regex delimiter
syn cluster p6Variables
    \ add=p6VarSlash
    \ add=p6VarExclam
    \ add=p6VarMatch
    \ add=p6VarNum
    \ add=p6Variable

syn match p6BareSigil    display "[@$%&]\%(\s*\%([,)}=]\|where\>\)\)\@="
syn match p6VarSlash     display "\$/"
syn match p6VarExclam    display "\$!"
syn match p6VarMatch     display "\$¢"
syn match p6VarNum       display "\$\d\+"
syn match p6Variable     display "self"
syn match p6Variable     display "[@$%&]\?[@&$%]\$*\%(::\|\%(\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\)\|[A-Za-z_\xC0-\xFF]\)\@=" nextgroup=p6Twigil,p6VarName,p6PackageScope
syn match p6VarName      display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)" nextgroup=p6PostHyperOp contained
syn match p6Close        display "[\])]" nextgroup=p6PostHyperOp
syn match p6PostHyperOp  display "\%(»\|>>\)" contained
syn match p6Twigil       display "\%([.^*?=!~]\|:\@1<!::\@!\)[A-Za-z_\xC0-\xFF]\@=" nextgroup=p6PackageScope,p6VarName contained
syn match p6PackageScope display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\?::" nextgroup=p6PackageScope,p6VarName contained

" Perl 6 regex regions

syn match p6MatchStart_m    display "\.\@1<!\<\%(mm\?\|rx\)\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\)\@!" skipwhite skipempty nextgroup=p6MatchAdverbs_m
syn match p6MatchStart_s    display "\.\@1<!\<s\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\)\@!" skipwhite skipempty nextgroup=p6MatchAdverbs_s
syn match p6MatchStart_tr   display "\.\@1<!\<tr\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\)\@!" skipwhite skipempty nextgroup=p6MatchAdverbs_tr
syn match p6MatchAdverbs_m  "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6Match
syn match p6MatchAdverbs_s  "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6Substitution
syn match p6MatchAdverbs_tr "\%(\_s*:!\?\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\%(([^)]*)\)\?\)*" contained transparent skipwhite skipempty nextgroup=p6Transliteration

" /foo/
syn region p6MatchBare
    \ matchgroup=p6Quote
    \ start="/\@1<!\%(\%(\_^\|[!\[,=~|&/:({]\|\^\?fff\?\^\?\|=>\|\<\%(if\|unless\|while\|when\|where\|so\)\)\s*\)\@<=/[/=]\@!"
    \ skip="\\/"
    \ end="/"
    \ contains=@p6Regexen,p6Variable,p6VarExclam,p6VarMatch,p6VarNum

" m/foo/, m$foo$, m!foo!, etc
syn region p6Match
    \ matchgroup=p6Quote
    \ start=+\z([/!$,|`"]\)+
    \ skip="\\\z1"
    \ end="\z1"
    \ contained
    \ contains=@p6Regexen,p6Variable,p6VarNum

" m<foo>, m«foo», m{foo}, etc
for [name, start_delim, end_delim, end_group, skip] in s:bracketing_delims
    exec "syn region p6Match matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contained keepend contains=@p6Regexen,@p6Variables"
endfor

" Substitutions

" s/foo//, s$foo$$, s!foo!!, etc
syn region p6Substitution
    \ matchgroup=p6Quote
    \ start=+\z([/!$,|`"]\)+
    \ skip="\\\z1"
    \ end="\z1"me=e-1
    \ contained
    \ contains=@p6Regexen,p6Variable,p6VarNum
    \ nextgroup=p6Replacement

syn region p6Replacement
    \ matchgroup=p6Quote
    \ start="\z(.\)"
    \ skip="\\\z1"
    \ end="\z1"
    \ contained
    \ contains=@p6Interp_qq

" s<foo><bar>, s«foo»«bar», s{foo}{bar}, etc
for [name, start_delim, end_delim, end_group, skip] in s:bracketing_delims
    exec "syn region p6Substitution matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contained keepend contains=@p6Regexen,@p6Variables nextgroup=p6Repl".name
    exec "syn region p6Repl".name." matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contained keepend contains=@p6Interp_qq"
endfor

" Transliteration

" tr/foo/bar/, tr|foo|bar, etc
syn region p6Transliteration
    \ matchgroup=p6Quote
    \ start=+\z([/!$,|`"]\)+
    \ skip="\\\z1"
    \ end="\z1"me=e-1
    \ contained
    \ contains=p6RxRange
    \ nextgroup=p6TransRepl

syn region p6TransRepl
    \ matchgroup=p6Quote
    \ start="\z(.\)"
    \ skip="\\\z1"
    \ end="\z1"
    \ contained
    \ contains=@p6Interp_qq,p6RxRange

" tr<foo><bar>, tr«foo»«bar», tr{foo}{bar}, etc
for [name, start_delim, end_delim, end_group, skip] in s:bracketing_delims
    exec "syn region p6Transliteration matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contained keepend contains=p6RxRange nextgroup=p6TransRepl".name
    exec "syn region p6TransRepl".name." matchgroup=p6Quote start=\"".start_delim."\" skip=\"".skip."\" end=\"".end_delim."\" contained keepend contains=@p6Interp_qq,p6RxRange"
endfor
unlet s:bracketing_delims

if exists("perl6_perl5_regexes") || exists("perl6_extended_all")

" Perl 5 regex regions

syn cluster p6RegexP5Base
    \ add=p6RxP5Escape
    \ add=p6RxP5Oct
    \ add=p6RxP5Hex
    \ add=p6RxP5EscMeta
    \ add=p6RxP5CodePoint
    \ add=p6RxP5Prop

" normal regex stuff
syn cluster p6RegexP5
    \ add=@p6RegexP5Base
    \ add=p6RxP5Quantifier
    \ add=p6RxP5Meta
    \ add=p6RxP5QuoteMeta
    \ add=p6RxP5ParenMod
    \ add=p6RxP5Verb
    \ add=p6RxP5Count
    \ add=p6RxP5Named
    \ add=p6RxP5ReadRef
    \ add=p6RxP5WriteRef
    \ add=p6RxP5CharClass
    \ add=p6RxP5Anchor

" inside character classes
syn cluster p6RegexP5Class
    \ add=@p6RegexP5Base
    \ add=p6RxP5Posix
    \ add=p6RxP5Range

syn match p6RxP5Escape     display contained "\\\S"
syn match p6RxP5CodePoint  display contained "\\c\S\@=" nextgroup=p6RxP5CPId
syn match p6RxP5CPId       display contained "\S"
syn match p6RxP5Oct        display contained "\\\%(\o\{1,3}\)\@=" nextgroup=p6RxP5OctSeq
syn match p6RxP5OctSeq     display contained "\o\{1,3}"
syn match p6RxP5Anchor     display contained "[\^$]"
syn match p6RxP5Hex        display contained "\\x\%({\x\+}\|\x\{1,2}\)\@=" nextgroup=p6RxP5HexSeq
syn match p6RxP5HexSeq     display contained "\x\{1,2}"
syn region p6RxP5HexSeq
    \ matchgroup=p6RxP5Escape
    \ start="{"
    \ end="}"
    \ contained
syn region p6RxP5Named
    \ matchgroup=p6RxP5Escape
    \ start="\%(\\N\)\@2<={"
    \ end="}"
    \ contained
syn match p6RxP5Quantifier display contained "\%([+*]\|(\@1<!?\)"
syn match p6RxP5ReadRef    display contained "\\[1-9]\d\@!"
syn match p6RxP5ReadRef    display contained "\[A-Za-z_\xC0-\xFF0-9]<\@=" nextgroup=p6RxP5ReadRefId
syn region p6RxP5ReadRefId
    \ matchgroup=p6RxP5Escape
    \ start="<"
    \ end=">"
    \ contained
syn match p6RxP5WriteRef   display contained "\\g\%(\d\|{\)\@=" nextgroup=p6RxP5WriteRefId
syn match p6RxP5WriteRefId display contained "\d\+"
syn region p6RxP5WriteRefId
    \ matchgroup=p6RxP5Escape
    \ start="{"
    \ end="}"
    \ contained
syn match p6RxP5Prop       display contained "\\[pP]\%(\a\|{\)\@=" nextgroup=p6RxP5PropId
syn match p6RxP5PropId     display contained "\a"
syn region p6RxP5PropId
    \ matchgroup=p6RxP5Escape
    \ start="{"
    \ end="}"
    \ contained
syn match p6RxP5Meta       display contained "[(|).]"
syn match p6RxP5ParenMod   display contained "(\@1<=?\@=" nextgroup=p6RxP5Mod,p6RxP5ModName,p6RxP5Code
syn match p6RxP5Mod        display contained "?\%(<\?=\|<\?!\|[#:|]\)"
syn match p6RxP5Mod        display contained "?-\?[impsx]\+"
syn match p6RxP5Mod        display contained "?\%([-+]\?\d\+\|R\)"
syn match p6RxP5Mod        display contained "?(DEFINE)"
syn match p6RxP5Mod        display contained "?\%(&\|P[>=]\)" nextgroup=p6RxP5ModDef
syn match p6RxP5ModDef     display contained "\h\w*"
syn region p6RxP5ModName
    \ matchgroup=p6StringSpecial
    \ start="?'"
    \ end="'"
    \ contained
syn region p6RxP5ModName
    \ matchgroup=p6StringSpecial
    \ start="?P\?<"
    \ end=">"
    \ contained
syn region p6RxP5Code
    \ matchgroup=p6StringSpecial
    \ start="??\?{"
    \ end="})\@="
    \ contained
    \ contains=TOP
syn match p6RxP5EscMeta    display contained "\\[?*.{}()[\]|\^$]"
syn match p6RxP5Count      display contained "\%({\d\+\%(,\%(\d\+\)\?\)\?}\)\@=" nextgroup=p6RxP5CountId
syn region p6RxP5CountId
    \ matchgroup=p6RxP5Escape
    \ start="{"
    \ end="}"
    \ contained
syn match p6RxP5Verb       display contained "(\@1<=\*\%(\%(PRUNE\|SKIP\|THEN\)\%(:[^)]*\)\?\|\%(MARK\|\):[^)]*\|COMMIT\|F\%(AIL\)\?\|ACCEPT\)"
syn region p6RxP5QuoteMeta
    \ matchgroup=p6RxP5Escape
    \ start="\\Q"
    \ end="\\E"
    \ contained
    \ contains=@p6Variables,p6EscBackSlash
syn region p6RxP5CharClass
    \ matchgroup=p6StringSpecial
    \ start="\[\^\?"
    \ skip="\\]"
    \ end="]"
    \ contained
    \ contains=@p6RegexP5Class
syn region p6RxP5Posix
    \ matchgroup=p6RxP5Escape
    \ start="\[:"
    \ end=":]"
    \ contained
syn match p6RxP5Range      display contained "-"

" m:P5//
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s*\)\@<=/"
    \ skip="\\/"
    \ end="/"
    \ contains=@p6RegexP5,p6Variable,p6VarExclam,p6VarMatch,p6VarNum

" m:P5!!
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s*\)\@<=!"
    \ skip="\\!"
    \ end="!"
    \ contains=@p6RegexP5,p6Variable,p6VarSlash,p6VarMatch,p6VarNum

" m:P5$$, m:P5||, etc
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s*\)\@<=\z([\"'`|,$]\)"
    \ skip="\\\z1"
    \ end="\z1"
    \ contains=@p6RegexP5,@p6Variables

" m:P5 ()
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s\+\)\@<=()\@!"
    \ skip="\\)"
    \ end=")"
    \ contains=@p6RegexP5,@p6Variables

" m:P5[]
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s*\)\@<=[]\@!"
    \ skip="\\]"
    \ end="]"
    \ contains=@p6RegexP5,@p6Variables

" m:P5{}
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s*\)\@<={}\@!"
    \ skip="\\}"
    \ end="}"
    \ contains=@p6RegexP5,p6Variables

" m:P5<>
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s*\)\@<=<>\@!"
    \ skip="\\>"
    \ end=">"
    \ contains=@p6RegexP5,p6Variables

" m:P5«»
syn region p6Match
    \ matchgroup=p6Quote
    \ start="\%(\%(::\|[$@%&][.!^:*?]\?\|\.\)\@2<!\<m\s*:P\%(erl\)\?5\s*\)\@<=«»\@!"
    \ skip="\\»"
    \ end="»"
    \ contains=@p6RegexP5,p6Variables

endif

" Comments

syn match p6Attention display "\<\%(ACHTUNG\|ATTN\|ATTENTION\|FIXME\|NB\|TODO\|TBD\|WTF\|XXX\|NOTE\)" contained

" normal end-of-line comment
syn match p6Comment display "#.*" contains=p6Attention

" Multiline comments. Arbitrary numbers of opening brackets are allowed,
" but we only define regions for 1 to 3
syn region p6BracketComment
    \ start="#[`|=]("
    \ skip="([^)]*)"
    \ end=")"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ start="#[`|=]\["
    \ skip="\[[^\]]*]"
    \ end="]"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ start="#[`|=]{"
    \ skip="{[^}]*}"
    \ end="}"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ start="#[`|=]<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ start="#[`|=]«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contains=p6Attention,p6BracketComment

" Comments with double and triple delimiters
syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=](("
    \ skip="((\%([^)\|))\@!]\)*))"
    \ end="))"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]((("
    \ skip="(((\%([^)]\|)\%())\)\@!\)*)))"
    \ end=")))"
    \ contains=p6Attention,p6BracketComment

syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]\[\["
    \ skip="\[\[\%([^\]]\|]]\@!\)*]]"
    \ end="]]"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]\[\[\["
    \ skip="\[\[\[\%([^\]]\|]\%(]]\)\@!\)*]]]"
    \ end="]]]"
    \ contains=p6Attention,p6BracketComment

syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]{{"
    \ skip="{{\%([^}]\|}}\@!\)*}}"
    \ end="}}"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]{{{"
    \ skip="{{{\%([^}]\|}\%(}}\)\@!\)*}}}"
    \ end="}}}"
    \ contains=p6Attention,p6BracketComment

syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]<<"
    \ skip="<<\%([^>]\|>>\@!\)*>>"
    \ end=">>"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]<<<"
    \ skip="<<<\%([^>]\|>\%(>>\)\@!\)*>>>"
    \ end=">>>"
    \ contains=p6Attention,p6BracketComment

syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]««"
    \ skip="««\%([^»]\|»»\@!\)*»»"
    \ end="»»"
    \ contains=p6Attention,p6BracketComment
syn region p6BracketComment
    \ matchgroup=p6BracketComment
    \ start="#[`|=]«««"
    \ skip="«««\%([^»]\|»\%(»»\)\@!\)*»»»"
    \ end="»»»"
    \ contains=p6Attention,p6BracketComment

syn match p6Shebang display "\%^#!.*"

" => and p5=> autoquoting
syn match p6StringP5Auto display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\ze\s\+p5=>"
syn match p6StringAuto   display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\ze\%(p5\)\@2<![RSXZ]\@1<!=>"
syn match p6StringAuto   display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\ze\s\+=>"
syn match p6StringAuto   display "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)p5\ze=>"

" Pod

" Abbreviated blocks (implicit code forbidden)
syn region p6PodAbbrRegion
    \ matchgroup=p6PodPrefix
    \ start="^\s*\zs=\ze\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contains=p6PodAbbrNoCodeType
    \ keepend

syn region p6PodAbbrNoCodeType
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=p6PodName,p6PodAbbrNoCode

syn match p6PodName contained ".\+" contains=@p6PodFormat
syn match p6PodComment contained ".\+"

syn region p6PodAbbrNoCode
    \ start="^"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=@p6PodFormat

" Abbreviated blocks (everything is code)
syn region p6PodAbbrRegion
    \ matchgroup=p6PodPrefix
    \ start="^\s*\zs=\zecode\>"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contains=p6PodAbbrCodeType
    \ keepend

syn region p6PodAbbrCodeType
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=p6PodName,p6PodAbbrCode

syn region p6PodAbbrCode
    \ start="^"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained

" Abbreviated blocks (everything is a comment)
syn region p6PodAbbrRegion
    \ matchgroup=p6PodPrefix
    \ start="^=\zecomment\>"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contains=p6PodAbbrCommentType
    \ keepend

syn region p6PodAbbrCommentType
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=p6PodComment,p6PodAbbrNoCode

" Abbreviated blocks (implicit code allowed)
syn region p6PodAbbrRegion
    \ matchgroup=p6PodPrefix
    \ start="^=\ze\%(pod\|item\|nested\|\u\+\)\>"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contains=p6PodAbbrType
    \ keepend

syn region p6PodAbbrType
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=p6PodName,p6PodAbbr

syn region p6PodAbbr
    \ start="^"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=@p6PodFormat,p6PodImplicitCode

" Abbreviated block to end-of-file
syn region p6PodAbbrRegion
    \ matchgroup=p6PodPrefix
    \ start="^=\zeEND\>"
    \ end="\%$"
    \ contains=p6PodAbbrEOFType
    \ keepend

syn region p6PodAbbrEOFType
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="\%$"
    \ contained
    \ contains=p6PodName,p6PodAbbrEOF

syn region p6PodAbbrEOF
    \ start="^"
    \ end="\%$"
    \ contained
    \ contains=@p6PodNestedBlocks,@p6PodFormat,p6PodImplicitCode

" Directives
syn region p6PodDirectRegion
    \ matchgroup=p6PodPrefix
    \ start="^=\%(config\|use\)\>"
    \ end="^\ze\%([^=]\|=[A-Za-z_\xC0-\xFF]\|\s*$\)"
    \ contains=p6PodDirectArgRegion
    \ keepend

syn region p6PodDirectArgRegion
    \ matchgroup=p6PodType
    \ start="\S\+"
    \ end="^\ze\%([^=]\|=[A-Za-z_\xC0-\xFF]\|\s*$\)"
    \ contained
    \ contains=p6PodDirectConfigRegion

syn region p6PodDirectConfigRegion
    \ start=""
    \ end="^\ze\%([^=]\|=[A-Za-z_\xC0-\xFF]\|\s*$\)"
    \ contained
    \ contains=@p6PodConfig

" =encoding is a special directive
syn region p6PodDirectRegion
    \ matchgroup=p6PodPrefix
    \ start="^=encoding\>"
    \ end="^\ze\%([^=]\|=[A-Za-z_\xC0-\xFF]\|\s*$\)"
    \ contains=p6PodEncodingArgRegion
    \ keepend

syn region p6PodEncodingArgRegion
    \ matchgroup=p6PodName
    \ start="\S\+"
    \ end="^\ze\%([^=]\|=[A-Za-z_\xC0-\xFF]\|\s*$\)"
    \ contained

" Paragraph blocks (implicit code forbidden)
syn region p6PodParaRegion
    \ matchgroup=p6PodPrefix
    \ start="^\s*\zs=for\>"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contains=p6PodParaNoCodeTypeRegion
    \ keepend extend

syn region p6PodParaNoCodeTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\s*\zs\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=p6PodParaNoCode,p6PodParaConfigRegion

syn region p6PodParaConfigRegion
    \ start=""
    \ end="^\ze\%([^=]\|=[A-Za-z_\xC0-\xFF]\@1<!\)"
    \ contained
    \ contains=@p6PodConfig

syn region p6PodParaNoCode
    \ start="^[^=]"
    \ end="^\s*\zs\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=@p6PodFormat

" Paragraph blocks (everything is code)
syn region p6PodParaRegion
    \ matchgroup=p6PodPrefix
    \ start="^\s*\zs=for\>\ze\s*code\>"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contains=p6PodParaCodeTypeRegion
    \ keepend extend

syn region p6PodParaCodeTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\s*\zs\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=p6PodParaCode,p6PodParaConfigRegion

syn region p6PodParaCode
    \ start="^[^=]"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained

" Paragraph blocks (implicit code allowed)
syn region p6PodParaRegion
    \ matchgroup=p6PodPrefix
    \ start="^\s*\zs=for\>\ze\s*\%(pod\|item\|nested\|\u\+\)\>"
    \ end="^\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contains=p6PodParaTypeRegion
    \ keepend extend

syn region p6PodParaTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\s*\zs\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=p6PodPara,p6PodParaConfigRegion

syn region p6PodPara
    \ start="^[^=]"
    \ end="^\s*\zs\ze\%(\s*$\|=[A-Za-z_\xC0-\xFF]\)"
    \ contained
    \ contains=@p6PodFormat,p6PodImplicitCode

" Paragraph block to end-of-file
syn region p6PodParaRegion
    \ matchgroup=p6PodPrefix
    \ start="^=for\>\ze\s\+END\>"
    \ end="\%$"
    \ contains=p6PodParaEOFTypeRegion
    \ keepend extend

syn region p6PodParaEOFTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="\%$"
    \ contained
    \ contains=p6PodParaEOF,p6PodParaConfigRegion

syn region p6PodParaEOF
    \ start="^[^=]"
    \ end="\%$"
    \ contained
    \ contains=@p6PodNestedBlocks,@p6PodFormat,p6PodImplicitCode

" Delimited blocks (implicit code forbidden)
syn region p6PodDelimRegion
    \ matchgroup=p6PodPrefix
    \ start="^\z(\s*\)\zs=begin\>"
    \ end="^\z1\zs=end\>"
    \ contains=p6PodDelimNoCodeTypeRegion
    \ keepend extend skipwhite
    \ nextgroup=p6PodType

syn region p6PodDelimNoCodeTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\s*\zs\ze=end\>"
    \ contained
    \ contains=p6PodDelimNoCode,p6PodDelimConfigRegion

syn region p6PodDelimConfigRegion
    \ start=""
    \ end="^\s*\zs\ze\%([^=]\|=[A-Za-z_\xC0-\xFF]\|\s*$\)"
    \ contained
    \ contains=@p6PodConfig

syn region p6PodDelimNoCode
    \ start="^"
    \ end="^\s*\zs\ze=end\>"
    \ contained
    \ contains=@p6PodNestedBlocks,@p6PodFormat

" Delimited blocks (everything is code)
syn region p6PodDelimRegion
    \ matchgroup=p6PodPrefix
    \ start="^\z(\s*\)\zs=begin\>\ze\s*code\>"
    \ end="^\z1\zs=end\>"
    \ contains=p6PodDelimCodeTypeRegion
    \ keepend extend skipwhite
    \ nextgroup=p6PodType

syn region p6PodDelimCodeTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\s*\zs\ze=end\>"
    \ contained
    \ contains=p6PodDelimCode,p6PodDelimConfigRegion

syn region p6PodDelimCode
    \ start="^"
    \ end="^\s*\zs\ze=end\>"
    \ contained
    \ contains=@p6PodNestedBlocks

" Delimited blocks (implicit code allowed)
syn region p6PodDelimRegion
    \ matchgroup=p6PodPrefix
    \ start="^\z(\s*\)\zs=begin\>\ze\s*\%(pod\|item\|nested\|\u\+\)\>"
    \ end="^\z1\zs=end\>"
    \ contains=p6PodDelimTypeRegion
    \ keepend extend skipwhite
    \ nextgroup=p6PodType

syn region p6PodDelimTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="^\s*\zs\ze=end\>"
    \ contained
    \ contains=p6PodDelim,p6PodDelimConfigRegion

syn region p6PodDelim
    \ start="^"
    \ end="^\s*\zs\ze=end\>"
    \ contained
    \ contains=@p6PodNestedBlocks,@p6PodFormat,p6PodImplicitCode

" Delimited block to end-of-file
syn region p6PodDelimRegion
    \ matchgroup=p6PodPrefix
    \ start="^=begin\>\ze\s\+END\>"
    \ end="\%$"
    \ extend
    \ contains=p6PodDelimEOFTypeRegion

syn region p6PodDelimEOFTypeRegion
    \ matchgroup=p6PodType
    \ start="\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"
    \ end="\%$"
    \ contained
    \ contains=p6PodDelimEOF,p6PodDelimConfigRegion

syn region p6PodDelimEOF
    \ start="^"
    \ end="\%$"
    \ contained
    \ contains=@p6PodNestedBlocks,@p6PodFormat,p6PodImplicitCode

syn cluster p6PodConfig
    \ add=p6PodConfigOperator
    \ add=p6PodExtraConfig
    \ add=p6StringAuto
    \ add=p6PodAutoQuote
    \ add=p6StringSQ

syn region p6PodParens
    \ start="("
    \ end=")"
    \ contained
    \ contains=p6Number,p6StringSQ

syn match p6PodAutoQuote      display contained "=>"
syn match p6PodConfigOperator display contained ":!\?" nextgroup=p6PodConfigOption
syn match p6PodConfigOption   display contained "[^[:space:](<]\+" nextgroup=p6PodParens,p6StringAngle
syn match p6PodExtraConfig    display contained "^="
syn match p6PodVerticalBar    display contained "|"
syn match p6PodColon          display contained ":"
syn match p6PodSemicolon      display contained ";"
syn match p6PodComma          display contained ","
syn match p6PodImplicitCode   display contained "^\s.*"
syn match p6PodType           display contained "\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)"

" These may appear inside delimited blocks
syn cluster p6PodNestedBlocks
    \ add=p6PodAbbrRegion
    \ add=p6PodDirectRegion
    \ add=p6PodParaRegion
    \ add=p6PodDelimRegion

" Pod formatting codes

syn cluster p6PodFormat
    \ add=p6PodFormatOne
    \ add=p6PodFormatTwo
    \ add=p6PodFormatThree
    \ add=p6PodFormatFrench

" Balanced angles found inside formatting codes. Ensures proper nesting.

syn region p6PodFormatAnglesOne
    \ matchgroup=p6PodFormat
    \ start="<"
    \ skip="<[^>]*>"
    \ end=">"
    \ transparent contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatAnglesOne

syn region p6PodFormatAnglesTwo
    \ matchgroup=p6PodFormat
    \ start="<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ transparent contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatAnglesOne,p6PodFormatAnglesTwo

syn region p6PodFormatAnglesThree
    \ matchgroup=p6PodFormat
    \ start="<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ transparent contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatAnglesOne,p6PodFormatAnglesTwo,p6PodFormatAnglesThree

syn region p6PodFormatAnglesFrench
    \ matchgroup=p6PodFormat
    \ start="«"
    \ skip="«[^»]*»"
    \ end="»"
    \ transparent contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatAnglesOne,p6PodFormatAnglesTwo,p6PodFormatAnglesThree

" All formatting codes

syn region p6PodFormatOne
    \ matchgroup=p6PodFormatCode
    \ start="\u<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contained
    \ contains=p6PodFormatAnglesOne,p6PodFormatFrench,p6PodFormatOne

syn region p6PodFormatTwo
    \ matchgroup=p6PodFormatCode
    \ start="\u<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ contained
    \ contains=p6PodFormatAnglesTwo,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo

syn region p6PodFormatThree
    \ matchgroup=p6PodFormatCode
    \ start="\u<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ contained
    \ contains=p6PodFormatAnglesThree,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree

syn region p6PodFormatFrench
    \ matchgroup=p6PodFormatCode
    \ start="\u«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree

" C<> and V<> don't allow nested formatting formatting codes

syn region p6PodFormatOne
    \ matchgroup=p6PodFormatCode
    \ start="[CV]<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contained
    \ contains=p6PodFormatAnglesOne

syn region p6PodFormatTwo
    \ matchgroup=p6PodFormatCode
    \ start="[CV]<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ contained
    \ contains=p6PodFormatAnglesTwo

syn region p6PodFormatThree
    \ matchgroup=p6PodFormatCode
    \ start="[CV]<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ contained
    \ contains=p6PodFormatAnglesThree

syn region p6PodFormatFrench
    \ matchgroup=p6PodFormatCode
    \ start="[CV]«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contained
    \ contains=p6PodFormatAnglesFrench

" L<> can have a "|" separator

syn region p6PodFormatOne
    \ matchgroup=p6PodFormatCode
    \ start="L<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contained
    \ contains=p6PodFormatAnglesOne,p6PodFormatFrench,p6PodFormatOne,p6PodVerticalBar

syn region p6PodFormatTwo
    \ matchgroup=p6PodFormatCode
    \ start="L<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ contained
    \ contains=p6PodFormatAnglesTwo,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodVerticalBar

syn region p6PodFormatThree
    \ matchgroup=p6PodFormatCode
    \ start="L<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ contained
    \ contains=p6PodFormatAnglesThree,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodVerticalBar

syn region p6PodFormatFrench
    \ matchgroup=p6PodFormatCode
    \ start="L«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodVerticalBar

" E<> can have a ";" separator

syn region p6PodFormatOne
    \ matchgroup=p6PodFormatCode
    \ start="E<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contained
    \ contains=p6PodFormatAnglesOne,p6PodFormatFrench,p6PodFormatOne,p6PodSemiColon

syn region p6PodFormatTwo
    \ matchgroup=p6PodFormatCode
    \ start="E<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ contained
    \ contains=p6PodFormatAnglesTwo,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodSemiColon

syn region p6PodFormatThree
    \ matchgroup=p6PodFormatCode
    \ start="E<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ contained
    \ contains=p6PodFormatAnglesThree,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodSemiColon

syn region p6PodFormatFrench
    \ matchgroup=p6PodFormatCode
    \ start="E«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodSemiColon

" M<> can have a ":" separator

syn region p6PodFormatOne
    \ matchgroup=p6PodFormatCode
    \ start="M<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contained
    \ contains=p6PodFormatAnglesOne,p6PodFormatFrench,p6PodFormatOne,p6PodColon

syn region p6PodFormatTwo
    \ matchgroup=p6PodFormatCode
    \ start="M<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ contained
    \ contains=p6PodFormatAnglesTwo,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodColon

syn region p6PodFormatThree
    \ matchgroup=p6PodFormatCode
    \ start="M<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ contained
    \ contains=p6PodFormatAnglesThree,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodColon

syn region p6PodFormatFrench
    \ matchgroup=p6PodFormatCode
    \ start="M«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodColon

" D<> can have "|" and ";" separators

syn region p6PodFormatOne
    \ matchgroup=p6PodFormatCode
    \ start="D<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contained
    \ contains=p6PodFormatAnglesOne,p6PodFormatFrench,p6PodFormatOne,p6PodVerticalBar,p6PodSemiColon

syn region p6PodFormatTwo
    \ matchgroup=p6PodFormatCode
    \ start="D<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ contained
    \ contains=p6PodFormatAngleTwo,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodVerticalBar,p6PodSemiColon

syn region p6PodFormatThree
    \ matchgroup=p6PodFormatCode
    \ start="D<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ contained
    \ contains=p6PodFormatAnglesThree,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodVerticalBar,p6PodSemiColon

syn region p6PodFormatFrench
    \ matchgroup=p6PodFormatCode
    \ start="D«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodVerticalBar,p6PodSemiColon

" X<> can have "|", "," and ";" separators

syn region p6PodFormatOne
    \ matchgroup=p6PodFormatCode
    \ start="X<"
    \ skip="<[^>]*>"
    \ end=">"
    \ contained
    \ contains=p6PodFormatAnglesOne,p6PodFormatFrench,p6PodFormatOne,p6PodVerticalBar,p6PodSemiColon,p6PodComma

syn region p6PodFormatTwo
    \ matchgroup=p6PodFormatCode
    \ start="X<<"
    \ skip="<<[^>]*>>"
    \ end=">>"
    \ contained
    \ contains=p6PodFormatAnglesTwo,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodVerticalBar,p6PodSemiColon,p6PodComma

syn region p6PodFormatThree
    \ matchgroup=p6PodFormatCode
    \ start="X<<<"
    \ skip="<<<[^>]*>>>"
    \ end=">>>"
    \ contained
    \ contains=p6PodFormatAnglesThree,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodVerticalBar,p6PodSemiColon,p6PodComma

syn region p6PodFormatFrench
    \ matchgroup=p6PodFormatCode
    \ start="X«"
    \ skip="«[^»]*»"
    \ end="»"
    \ contained
    \ contains=p6PodFormatAnglesFrench,p6PodFormatFrench,p6PodFormatOne,p6PodFormatTwo,p6PodFormatThree,p6PodVerticalBar,p6PodSemiColon,p6PodComma

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_perl6_syntax_inits")
    if version < 508
        let did_perl6_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink p6EscOctOld        p6Error
    HiLink p6PackageTwigil    p6Twigil
    HiLink p6StringAngle      p6String
    HiLink p6StringAngleFixed p6String
    HiLink p6StringFrench     p6String
    HiLink p6StringAngles     p6String
    HiLink p6StringSQ         p6String
    HiLink p6StringDQ         p6String
    HiLink p6StringQ          p6String
    HiLink p6StringQ_q        p6String
    HiLink p6StringQ_qww      p6String
    HiLink p6StringQ_qq       p6String
    HiLink p6StringQ_qto      p6String
    HiLink p6StringQ_qqto     p6String
    HiLink p6RxStringSQ       p6String
    HiLink p6RxStringDQ       p6String
    HiLink p6Replacement      p6String
    HiLink p6ReplCurly        p6String
    HiLink p6ReplAngle        p6String
    HiLink p6ReplFrench       p6String
    HiLink p6ReplBracket      p6String
    HiLink p6ReplParen        p6String
    HiLink p6Transliteration  p6String
    HiLink p6TransRepl        p6String
    HiLink p6TransReplCurly   p6String
    HiLink p6TransReplAngle   p6String
    HiLink p6TransReplFrench  p6String
    HiLink p6TransReplBracket p6String
    HiLink p6TransReplParen   p6String
    HiLink p6StringAuto       p6String
    HiLink p6StringP5Auto     p6String
    HiLink p6Key              p6String
    HiLink p6Match            p6String
    HiLink p6Substitution     p6String
    HiLink p6MatchBare        p6String
    HiLink p6RegexBlock       p6String
    HiLink p6RxP5CharClass    p6String
    HiLink p6RxP5QuoteMeta    p6String
    HiLink p6RxCharClass      p6String
    HiLink p6RxQuoteWords     p6String
    HiLink p6ReduceOp         p6Operator
    HiLink p6SetOp            p6Operator
    HiLink p6RSXZOp           p6Operator
    HiLink p6HyperOp          p6Operator
    HiLink p6PostHyperOp      p6Operator
    HiLink p6QuoteQ           p6Quote
    HiLink p6QuoteQ_q         p6Quote
    HiLink p6QuoteQ_qww       p6Quote
    HiLink p6QuoteQ_qq        p6Quote
    HiLink p6QuoteQ_qto       p6Quote
    HiLink p6QuoteQ_qqto      p6Quote
    HiLink p6QuoteQ_PIR       p6Quote
    HiLink p6MatchStart_m     p6Quote
    HiLink p6MatchStart_s     p6Quote
    HiLink p6MatchStart_tr    p6Quote
    HiLink p6BareSigil        p6Variable
    HiLink p6RxRange          p6StringSpecial
    HiLink p6RxAnchor         p6StringSpecial
    HiLink p6RxBoundary       p6StringSpecial
    HiLink p6RxP5Anchor       p6StringSpecial
    HiLink p6CodePoint        p6StringSpecial
    HiLink p6RxMeta           p6StringSpecial
    HiLink p6RxP5Range        p6StringSpecial
    HiLink p6RxP5CPId         p6StringSpecial
    HiLink p6RxP5Posix        p6StringSpecial
    HiLink p6RxP5Mod          p6StringSpecial
    HiLink p6RxP5HexSeq       p6StringSpecial
    HiLink p6RxP5OctSeq       p6StringSpecial
    HiLink p6RxP5WriteRefId   p6StringSpecial
    HiLink p6HexSequence      p6StringSpecial
    HiLink p6OctSequence      p6StringSpecial
    HiLink p6RxP5Named        p6StringSpecial
    HiLink p6RxP5PropId       p6StringSpecial
    HiLink p6RxP5Quantifier   p6StringSpecial
    HiLink p6RxP5CountId      p6StringSpecial
    HiLink p6RxP5Verb         p6StringSpecial
    HiLink p6RxAssertGroup    p6StringSpecial2
    HiLink p6Escape           p6StringSpecial2
    HiLink p6EscNull          p6StringSpecial2
    HiLink p6EscHash          p6StringSpecial2
    HiLink p6EscQQ            p6StringSpecial2
    HiLink p6EscQuote         p6StringSpecial2
    HiLink p6EscDoubleQuote   p6StringSpecial2
    HiLink p6EscBackTick      p6StringSpecial2
    HiLink p6EscForwardSlash  p6StringSpecial2
    HiLink p6EscVerticalBar   p6StringSpecial2
    HiLink p6EscExclamation   p6StringSpecial2
    HiLink p6EscDollar        p6StringSpecial2
    HiLink p6EscOpenCurly     p6StringSpecial2
    HiLink p6EscCloseCurly    p6StringSpecial2
    HiLink p6EscCloseBracket  p6StringSpecial2
    HiLink p6EscCloseAngle    p6StringSpecial2
    HiLink p6EscCloseFrench   p6StringSpecial2
    HiLink p6EscBackSlash     p6StringSpecial2
    HiLink p6EscCodePoint     p6StringSpecial2
    HiLink p6EscOct           p6StringSpecial2
    HiLink p6EscHex           p6StringSpecial2
    HiLink p6RxEscape         p6StringSpecial2
    HiLink p6RxCapture        p6StringSpecial2
    HiLink p6RxAlternation    p6StringSpecial2
    HiLink p6RxP5             p6StringSpecial2
    HiLink p6RxP5ReadRef      p6StringSpecial2
    HiLink p6RxP5Oct          p6StringSpecial2
    HiLink p6RxP5Hex          p6StringSpecial2
    HiLink p6RxP5EscMeta      p6StringSpecial2
    HiLink p6RxP5Meta         p6StringSpecial2
    HiLink p6RxP5Escape       p6StringSpecial2
    HiLink p6RxP5CodePoint    p6StringSpecial2
    HiLink p6RxP5WriteRef     p6StringSpecial2
    HiLink p6RxP5Prop         p6StringSpecial2

    HiLink p6Property       Tag
    HiLink p6Attention      Todo
    HiLink p6Type           Type
    HiLink p6Error          Error
    HiLink p6BlockLabel     Label
    HiLink p6Normal         Normal
    HiLink p6Identifier     Normal
    HiLink p6Package        Normal
    HiLink p6PackageScope   Normal
    HiLink p6Number         Number
    HiLink p6OctNumber      Number
    HiLink p6BinNumber      Number
    HiLink p6HexNumber      Number
    HiLink p6DecNumber      Number
    HiLink p6String         String
    HiLink p6Repeat         Repeat
    HiLink p6Pragma         Keyword
    HiLink p6Module         Keyword
    HiLink p6DeclareRoutine Keyword
    HiLink p6DeclareRegex   Keyword
    HiLink p6VarStorage     Special
    HiLink p6FlowControl    Special
    HiLink p6OctBase        Special
    HiLink p6BinBase        Special
    HiLink p6HexBase        Special
    HiLink p6DecBase        Special
    HiLink p6Twigil         Special
    HiLink p6StringSpecial2 Special
    HiLink p6Version        Special
    HiLink p6Comment        Comment
    HiLink p6BracketComment Comment
    HiLink p6Include        Include
    HiLink p6Shebang        PreProc
    HiLink p6ClosureTrait   PreProc
    HiLink p6Operator       Operator
    HiLink p6Context        Operator
    HiLink p6Quote          Delimiter
    HiLink p6TypeConstraint PreCondit
    HiLink p6Exception      Exception
    HiLink p6Variable       Identifier
    HiLink p6VarSlash       Identifier
    HiLink p6VarNum         Identifier
    HiLink p6VarExclam      Identifier
    HiLink p6VarMatch       Identifier
    HiLink p6VarName        Identifier
    HiLink p6MatchVar       Identifier
    HiLink p6RxP5ReadRefId  Identifier
    HiLink p6RxP5ModDef     Identifier
    HiLink p6RxP5ModName    Identifier
    HiLink p6Conditional    Conditional
    HiLink p6StringSpecial  SpecialChar

    HiLink p6PodAbbr         p6Pod
    HiLink p6PodAbbrEOF      p6Pod
    HiLink p6PodAbbrNoCode   p6Pod
    HiLink p6PodAbbrCode     p6PodCode
    HiLink p6PodPara         p6Pod
    HiLink p6PodParaEOF      p6Pod
    HiLink p6PodParaNoCode   p6Pod
    HiLink p6PodParaCode     p6PodCode
    HiLink p6PodDelim        p6Pod
    HiLink p6PodDelimEOF     p6Pod
    HiLink p6PodDelimNoCode  p6Pod
    HiLink p6PodDelimCode    p6PodCode
    HiLink p6PodImplicitCode p6PodCode
    HiLink p6PodExtraConfig  p6PodPrefix
    HiLink p6PodVerticalBar  p6PodFormatCode
    HiLink p6PodColon        p6PodFormatCode
    HiLink p6PodSemicolon    p6PodFormatCode
    HiLink p6PodComma        p6PodFormatCode
    HiLink p6PodFormatOne    p6PodFormat
    HiLink p6PodFormatTwo    p6PodFormat
    HiLink p6PodFormatThree  p6PodFormat
    HiLink p6PodFormatFrench p6PodFormat

    HiLink p6PodType           Type
    HiLink p6PodConfigOption   String
    HiLink p6PodCode           PreProc
    HiLink p6Pod               Comment
    HiLink p6PodComment        Comment
    HiLink p6PodAutoQuote      Operator
    HiLink p6PodConfigOperator Operator
    HiLink p6PodPrefix         Statement
    HiLink p6PodName           Identifier
    HiLink p6PodFormatCode     SpecialChar
    HiLink p6PodFormat         SpecialComment

    delcommand HiLink
endif

if exists("perl6_fold") || exists("perl6_extended_all")
    setl foldmethod=syntax
    syn region p6BlockFold
        \ start="^\z(\s*\)\%(my\|our\|augment\|multi\|proto\|only\)\?\s*\%(\%([A-Za-z_\xC0-\xFF]\%([A-Za-z_\xC0-\xFF0-9]\|[-'][A-Za-z_\xC0-\xFF]\@=\)*\)\s\+\)\?\<\%(CATCH\|try\|ENTER\|LEAVE\|CHECK\|INIT\|BEGIN\|END\|KEEP\|UNDO\|PRE\|POST\|module\|package\|enum\|subset\|class\|sub\%(method\)\?\|multi\|method\|slang\|grammar\|regex\|token\|rule\)\>[^{]\+\%({\s*\%(#.*\)\?\)\?$"
        \ end="^\z1}"
        \ transparent fold keepend extend
endif

let b:current_syntax = "perl6"

let &cpo = s:keepcpo
unlet s:keepcpo

" vim:ts=8:sts=4:sw=4:expandtab:ft=vim

endif
