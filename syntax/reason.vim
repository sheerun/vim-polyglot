if has_key(g:polyglot_is_disabled, 'reason')
  finish
endif

" Vim syntax file
" Language:     Reason (Forked from Rust)
" Maintainer:   (Jordan - for Reason changes) Patrick Walton <pcwalton@mozilla.com>
" Maintainer:   Ben Blum <bblum@cs.cmu.edu>
" Maintainer:   Chris Morgan <me@chrismorgan.info>
" Last Change:  January 29, 2015
" Portions Copyright (c) 2015-present, Facebook, Inc. All rights reserved.

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   reasonConditional switch match if else for in when fun
syn keyword   reasonOperator    as

syn match     reasonAssert      "\<assert\(\w\)*!" contained
syn match     reasonPanic       "\<panic\(\w\)*!" contained
syn keyword   reasonKeyword     box nextgroup=reasonBoxPlacement skipwhite skipempty
syn keyword   reasonKeyword     extern nextgroup=reasonExternCrate,reasonObsoleteExternMod skipwhite skipempty
" syn keyword   reasonKeyword     fun nextgroup=reasonFuncName skipwhite skipempty
syn keyword   reasonKeyword     unsafe where while lazy
syn keyword   reasonStorage     and class constraint exception external include inherit let method module nonrec open private rec type val with
" FIXME: Scoped impl's name is also fallen in this category
" syn keyword   reasonStorageIdent   let and module type nextgroup=reasonIdentifier skipwhite skipempty

syn keyword   reasonExternCrate crate contained nextgroup=reasonIdentifier,reasonExternCrateString skipwhite skipempty
" This is to get the `bar` part of `extern crate "foo" as bar;` highlighting.
syn match   reasonExternCrateString /".*"\_s*as/ contained nextgroup=reasonIdentifier skipwhite transparent skipempty contains=reasonString,reasonOperator
syn keyword   reasonObsoleteExternMod mod contained nextgroup=reasonIdentifier skipwhite skipempty

syn match     reasonIdentifier  contains=reasonIdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     reasonFuncName    "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
"
syn match labelArgument "\(\l\|_\)\(\w\|'\)*::\(?\)\?"lc=0   "Allows any space between label name and ::
syn match labelArgumentPunned "::\(?\)\?\(\l\|_\)\(\w\|'\)*"lc=0   "Allows any space between label name and ::

syn match    reasonEnumVariant  "\<\u\(\w\|'\)*\>[^\.]"me=e-1
" Polymorphic variants
syn match    reasonEnumVariant  "`\w\(\w\|'\)*\>"

syn match    reasonModPath  "\<\u\w*\."


syn region    reasonBoxPlacement matchgroup=reasonBoxPlacementParens start="(" end=")" contains=TOP contained
" Ideally we'd have syntax rules set up to match arbitrary expressions. Since
" we don't, we'll just define temporary contained rules to handle balancing
" delimiters.
syn region    reasonBoxPlacementBalance start="(" end=")" containedin=reasonBoxPlacement transparent
syn region    reasonBoxPlacementBalance start="\[" end="\]" containedin=reasonBoxPlacement transparent
" {} are handled by reasonFoldBraces


syn region reasonMacroRepeat matchgroup=reasonMacroRepeatDelimiters start="$(" end=")" contains=TOP nextgroup=reasonMacroRepeatCount
syn match reasonMacroRepeatCount ".\?[*+]" contained
syn match reasonMacroVariable "$\w\+"

" Reserved (but not yet used) keywords {{{2
syn keyword   reasonReservedKeyword alignof become do offsetof priv pure sizeof typeof unsized yield abstract virtual final override macro

" Built-in types {{{2
syn keyword   reasonType        int float option list array unit ref bool string

" Things from the libstd v1 prelude (src/libstd/prelude/v1.rs) {{{2
" This section is just straight transformation of the contents of the prelude,
" to make it easy to update.

" Reexported core operators {{{3
syn keyword   reasonTrait       Copy Send Sized Sync
syn keyword   reasonTrait       Drop Fn FnMut FnOnce

" Reexported functions {{{3
" There’s no point in highlighting these; when one writes drop( or drop::< it
" gets the same highlighting anyway, and if someone writes `let drop = …;` we
" don’t really want *that* drop to be highlighted.
"syn keyword reasonFunction drop

" Reexported types and traits {{{3
syn keyword reasonTrait Box
syn keyword reasonTrait ToOwned
syn keyword reasonTrait Clone
syn keyword reasonTrait PartialEq PartialOrd Eq Ord
syn keyword reasonTrait AsRef AsMut Into From
syn keyword reasonTrait Default
syn keyword reasonTrait Iterator Extend IntoIterator
syn keyword reasonTrait DoubleEndedIterator ExactSizeIterator
syn keyword reasonEnum Option
syn keyword reasonEnumVariant Some None
syn keyword reasonEnum Result
syn keyword reasonEnumVariant Ok Err
syn keyword reasonTrait SliceConcatExt
syn keyword reasonTrait String ToString
syn keyword reasonTrait Vec

" Other syntax {{{2
syn keyword   reasonSelf        self
syn keyword   reasonBoolean     true false

" This is merely a convention; note also the use of [A-Z], restricting it to
" latin identifiers rather than the full Unicode uppercase. I have not used
" [:upper:] as it depends upon 'noignorecase'
"syn match     reasonCapsIdent    display "[A-Z]\w\(\w\)*"

syn match     reasonOperator     display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"
" This one isn't *quite* right, as we could have binary-& with a reference

" This isn't actually correct; a closure with no arguments can be `|| { }`.
" Last, because the & in && isn't a sigil
syn match     reasonOperator     display "&&\|||"
" This is reasonArrowCharacter rather than reasonArrow for the sake of matchparen,
" so it skips the ->; see http://stackoverflow.com/a/30309949 for details.
syn match     reasonArrowCharacter display "=>"

syn match     reasonEscapeError   display contained /\\./
syn match     reasonEscape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     reasonEscapeUnicode display contained /\\\(u\x\{4}\|U\x\{8}\)/
syn match     reasonEscapeUnicode display contained /\\u{\x\{1,6}}/
syn match     reasonStringContinuation display contained /\\\n\s*/
syn region    reasonString      start='{j|' end='|j}' contains=reasonMacroVariable,@Spell
syn region    reasonString      start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=reasonEscape,reasonEscapeError,reasonStringContinuation
syn region    reasonString      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=reasonEscape,reasonEscapeUnicode,reasonEscapeError,reasonStringContinuation,@Spell
syn region    reasonString      start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

syn region    reasonAttribute   start="#!\?\[" end="\]" contains=reasonString,reasonDerive
syn region    reasonDerive      start="derive(" end=")" contained contains=reasonDeriveTrait
" This list comes from src/libsyntax/ext/deriving/mod.rs
" Some are deprecated (Encodable, Decodable) or to be removed after a new snapshot (Show).
syn keyword   reasonDeriveTrait contained Clone Hash RustcEncodable RustcDecodable Encodable Decodable PartialEq Eq PartialOrd Ord Rand Show Debug Default FromPrimitive Send Sync Copy

" Number literals
syn match     reasonDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\)\)\="
syn match     reasonHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\)\)\="
syn match     reasonOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\)\)\="
syn match     reasonBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\)\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access,
" or by another ".", which makes them integer literals followed by the ".." token.
" (This must go first so the others take precedence.)
syn match     reasonFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     reasonFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     reasonFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     reasonFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

" For the benefit of delimitMate

syn match   reasonCharacterInvalid   display contained /b\?'\zs[\n\r\t']\ze'/
" The groups negated here add up to 0-255 but nothing else (they do not seem to go beyond ASCII).
syn match   reasonCharacterInvalidUnicode   display contained /b'\zs[^[:cntrl:][:graph:][:alnum:][:space:]]\ze'/
syn match   reasonCharacter   /b'\([^\\]\|\\\(.\|x\x\{2}\)\)'/ contains=reasonEscape,reasonEscapeError,reasonCharacterInvalid,reasonCharacterInvalidUnicode
syn match   reasonCharacter   /'\([^\\]\|\\\(.\|x\x\{2}\|u\x\{4}\|U\x\{8}\|u{\x\{1,6}}\)\)'/ contains=reasonEscape,reasonEscapeUnicode,reasonEscapeError,reasonCharacterInvalid

syn match reasonShebang /\%^#![^[].*/
syn region reasonCommentLine                                        start="//"                      end="$"   contains=reasonTodo,@Spell
syn region reasonCommentLineDoc                                     start="//\%(//\@!\|!\)"         end="$"   contains=reasonTodo,@Spell
syn region reasonCommentBlock    matchgroup=reasonCommentBlock        start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=reasonTodo,reasonCommentBlockNest,@Spell
syn region reasonCommentBlockDoc matchgroup=reasonCommentBlockDoc     start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=reasonTodo,reasonCommentBlockDocNest,@Spell
syn region reasonCommentBlockNest matchgroup=reasonCommentBlock       start="/\*"                     end="\*/" contains=reasonTodo,reasonCommentBlockNest,@Spell contained transparent
syn region reasonCommentBlockDocNest matchgroup=reasonCommentBlockDoc start="/\*"                     end="\*/" contains=reasonTodo,reasonCommentBlockDocNest,@Spell contained transparent
" FIXME: this is a really ugly and not fully correct implementation. Most
" importantly, a case like ``/* */*`` should have the final ``*`` not being in
" a comment, but in practice at present it leaves comments open two levels
" deep. But as long as you stay away from that particular case, I *believe*
" the highlighting is correct. Due to the way Vim's syntax engine works
" (greedy for start matches, unlike Rust's tokeniser which is searching for
" the earliest-starting match, start or end), I believe this cannot be solved.
" Oh you who would fix it, don't bother with things like duplicating the Block
" rules and putting ``\*\@<!`` at the start of them; it makes it worse, as
" then you must deal with cases like ``/*/**/*/``. And don't try making it
" worse with ``\%(/\@<!\*\)\@<!``, either...

syn keyword reasonTodo contained TODO FIXME XXX NB NOTE

" Folding rules {{{2
" Trivial folding rules to begin with.
" FIXME: use the AST to make really good folding
syn region reasonFoldBraces start="{" end="}" transparent fold

" Default highlighting {{{1
hi def link labelArgument       Special
hi def link labelArgumentPunned Special
hi def link reasonDecNumber       reasonNumber
hi def link reasonHexNumber       reasonNumber
hi def link reasonOctNumber       reasonNumber
hi def link reasonBinNumber       reasonNumber
hi def link reasonIdentifierPrime reasonIdentifier
hi def link reasonTrait           reasonType
hi def link reasonDeriveTrait     reasonTrait

hi def link reasonMacroRepeatCount   reasonMacroRepeatDelimiters
hi def link reasonMacroRepeatDelimiters   Macro
hi def link reasonMacroVariable Define
hi def link reasonEscape        Special
hi def link reasonEscapeUnicode reasonEscape
hi def link reasonEscapeError   Error
hi def link reasonStringContinuation Special
hi def link reasonString        String
hi def link reasonCharacterInvalid Error
hi def link reasonCharacterInvalidUnicode reasonCharacterInvalid
hi def link reasonCharacter     Character
hi def link reasonNumber        Number
hi def link reasonBoolean       Boolean
hi def link reasonEnum          reasonType
hi def link reasonEnumVariant   Function
hi def link reasonModPath       Macro
hi def link reasonConstant      Constant
hi def link reasonSelf          Constant
hi def link reasonFloat         Float
hi def link reasonArrowCharacter reasonOperator
hi def link reasonOperator      Keyword
hi def link reasonKeyword       Keyword
hi def link reasonReservedKeyword Error
hi def link reasonConditional   StorageClass
hi def link reasonIdentifier    Identifier
hi def link reasonCapsIdent     reasonIdentifier
hi def link reasonFunction      Function
hi def link reasonFuncName      Function
hi def link reasonShebang       Comment
hi def link reasonCommentLine   Comment
hi def link reasonCommentLineDoc Comment
hi def link reasonCommentBlock  reasonCommentLine
hi def link reasonCommentBlockDoc reasonCommentLineDoc
hi def link reasonAssert        PreCondit
hi def link reasonPanic         PreCondit
hi def link reasonType          Type
hi def link reasonTodo          Todo
hi def link reasonAttribute     PreProc
hi def link reasonDerive        PreProc
hi def link reasonStorage       Conditional
hi def link reasonStorageIdent StorageClass
hi def link reasonObsoleteStorage Error
hi def link reasonExternCrate   reasonKeyword
hi def link reasonObsoleteExternMod Error
hi def link reasonBoxPlacementParens Delimiter

" Other Suggestions:
" hi reasonAttribute ctermfg=cyan
" hi reasonDerive ctermfg=cyan
" hi reasonAssert ctermfg=yellow
" hi reasonPanic ctermfg=red

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "reason"
