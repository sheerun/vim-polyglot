if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'carp') == -1

" Vim syntax file
" Language:     Carp
" Maintainer:   Veit Heller <veit@veitheller.de>
" URL:          http://github.com/hellerve/carp-vim.git
" Description:  Contains all of the keywords in #lang carp

if exists("b:current_syntax")
  finish
endif

syn match carpError ,[]})],

if version < 600
  set iskeyword=33,35-39,42-43,45-58,60-63,65-90,94,95,97-122,124,126,_
else
  setlocal iskeyword=33,35-39,42-43,45-58,60-63,65-90,94,95,97-122,124,126,_
endif

syn keyword carpSyntax def defn let do if while ref address set! the
syn keyword carpSyntax defmacro defdynamic defndynamic quote cons list array fn
syn keyword carpSyntax expand deftype register system-include register-type
syn keyword carpSyntax defmodule copy use module defalias definterface eval
syn keyword carpSyntax expand instantiate type info help quit env build run
syn keyword carpSyntax cat project-set! local-include cons-last
syn keyword carpSyntax add-cflag add-lib project load reload let-do ignore
syn keyword carpSyntax fmt mac-only linux-only windows-only use-all when
syn keyword carpSyntax unless defn-do comment forever-do case and* or*
syn keyword carpSyntax str* println* break doc sig hidden private
syn keyword carpSyntax while-do const-assert save-docs defproject
syn keyword carpSyntax relative-include not-on-windows load-and-use
syn keyword carpSyntax deftest
syn match carpSyntax "\vc(a|d){1,4}r"

syn keyword carpFunc λ
syn keyword carpFunc not or and + - * / = /= >= <= > < inc dec
syn keyword carpFunc println print get-line from-string mod random
syn keyword carpFunc random-between str mask delete append length duplicate
syn keyword carpFunc cstr chars from-chars to-int from-int sin cos sqrt acos
syn keyword carpFunc atan2 exit time seed-random for cond floor abs sort-with
syn keyword carpFunc subarray prefix-array suffix-array reverse sum min max
syn keyword carpFunc first last reduce format zero read-file bit-shift-left
syn keyword carpFunc bit-shift-right bit-and bit-or bit-xor bit-not safe-add
syn keyword carpFunc safe-sub safe-mul even? odd? cmp allocate repeat-indexed
syn keyword carpFunc sanitize-addresses memory-balance reset-memory-balance!
syn keyword carpFunc log-memory-balance! memory-logged assert-balanced trace
syn keyword carpFunc assert
syn keyword carpFunc pi e swap! update! char-at tail head split-by words lines
syn keyword carpFunc pad-left pad-right count-char empty? random-sized substring
syn keyword carpFunc prefix-string suffix-string starts-with? ends-with?
syn keyword carpFunc string-join free sleep-seconds sleep-micros substitute
syn keyword carpFunc neg to-float match matches? find global-match match-str
syn keyword carpFunc from-float tan asin atan cosh sinh tanh exp frexp ldexp
syn keyword carpFunc log log10 modf pow ceil clamp approx refstr foreach
syn keyword carpFunc => ==> repeat nth replicate range raw aset aset!
syn keyword carpFunc push-back pop-back sort index-of element-count
syn keyword carpFunc apply unsafe-from from just? nothing? ptr from-ptr 
syn keyword carpFunc map and-then unwrap-or-zero or-else unwrap-or-else
syn keyword carpFunc unsafe-from-success from-success unsafe-from-error
syn keyword carpFunc from-error to-maybe success? error? to-result
syn keyword carpFunc create create-with-len put put! get-with-default get
syn keyword carpFunc get-maybe update update-with-default contains? remove
syn keyword carpFunc all? for-each endo-map kv-reduce vals keys from-array
syn keyword carpFunc to-array subset? union difference intersection
syn keyword carpFunc init-from-refs
syn keyword carpFunc car cdr caar cadr cdar cddr caaar caadr cadar cdaar caddr
syn keyword carpFunc cdadr cddar cdddr caaaar caaadr caaddr cadaar cadadr caddar
syn keyword carpFunc cadddr cdaaar cdaadr cdadar cdaddr cddaar cddadr cdddar 
syn keyword carpFunc cddddr
syn keyword carpFunc private? hidden?
syn keyword carpFunc print-sig print-doc
syn keyword carpFunc assert-op assert-equal assert-not-equal assert-true
syn keyword carpFunc assert-false assert-exit print-test-results with-test
syn keyword carpFunc dir-from-path file-from-path

syn match carpFunc "[A-Z]\w\+"

syn match carpSymbol ,\k+,  contained
syn match carpTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE)/ containedin=carpComment,carpString

syn cluster carpNormal  contains=carpSyntax,carpFunc,carpDelimiter
syn cluster carpQuotedStuff  contains=carpSymbol
syn cluster carpQuotedOrNormal  contains=carpDelimiter

syn region carpQuotedStruc start="@("rs=s+2 end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained
syn region carpQuotedStruc start="&("rs=s+2 end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained
syn region carpQuotedStruc start="("rs=s+1 end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained
syn region carpQuotedStruc start="{"rs=s+1 end="}"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained
syn region carpQuotedStruc start="\["rs=s+1 end="\]"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal contained

syn cluster carpQuotedStuff add=carpQuotedStruc

syn region carpStruc matchgroup=Delimiter start="@("rs=s+2 matchgroup=Delimiter end=")"re=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="&("rs=s+2 matchgroup=Delimiter end=")"re=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="&"rs=s+1 end=![ \t()\[\]";]!me=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="@"rs=s+1 end=![ \t()\[\]";]!me=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="("rs=s+1 matchgroup=Delimiter end=")"re=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="{"rs=s+1 matchgroup=Delimiter end="}"re=e-1 contains=@carpNormal
syn region carpStruc matchgroup=Delimiter start="\["rs=s+1 matchgroup=Delimiter end="\]"re=e-1 contains=@carpNormal

syn region carpString start=/\%(\\\)\@<!"/ skip=/\\[\\"]/ end=/"/
syn region carpPattern start=/\%(\\\)\@<!\#"/ skip=/\\[\\"]/ end=/"/

syn cluster carpNormal          add=carpError,carpStruc,carpString,carpPattern
syn cluster carpQuotedOrNormal  add=carpString

syn match carpNumber    "\<[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?[lfb]\?\>" contains=carpContainedNumberError
syn match carpNumber    "\<[-+]\?\d\+/\d\+[lfb]\?\>" contains=carpContainedNumberError


syn keyword carpBoolean  true false

syn match carpChar    "\<\\.\w\@!"

syn region carpQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal
syn region carpQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=@carpQuotedStuff,@carpQuotedOrNormal

syn cluster carpNormal  add=carpNumber,carpBoolean,carpChar
syn cluster carpQuotedOrNormal  add=carpNumber,carpBoolean

syn match carpComment /;.*$/ contains=@Spell

syn region carpQuoted matchgroup=Delimiter start="#['`]"rs=s+2 end=![ \t()\[\]";]!re=e-1,me=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal
syn region carpQuoted matchgroup=Delimiter start="#['`]("rs=s+3 matchgroup=Delimiter end=")"re=e-1 contains=@carpQuotedStuff,@carpQuotedOrNormal

syn cluster carpNormal  add=carpQuoted,carpComment
syn cluster carpQuotedOrNormal  add=carpComment

syn sync match matchPlace grouphere NONE "^[^ \t]"

if version >= 508 || !exists("carp_syntax_init")
  if version < 508
    let carp_syntax_init = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink carpSyntax             Statement
  HiLink carpFunc               Function
  HiLink carpCopy               Function

  HiLink carpString             String
  HiLink carpPattern            String
  HiLink carpChar               Character
  HiLink carpBoolean            Boolean

  HiLink carpNumber             Number
  HiLink carpNumberError        Error
  HiLink carpContainedNumberError Error

  HiLink carpQuoted             Structure
  HiLink carpQuotedStruc        Structure
  HiLink carpSymbol             Structure
  HiLink carpAtom               Structure

  HiLink carpDelimiter          Delimiter
  HiLink carpConstant           Constant

  HiLink carpTodo               Todo
  HiLink carpComment            Comment
  HiLink carpError              Error
  delcommand HiLink
endif

let b:current_syntax = "carp"

endif
