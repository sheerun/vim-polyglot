if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vala') == -1

" Vim syntax file
" Language:	Vala
" Maintainers:	Emmanuele Bassi <ebassi@gnome.org>
" 		Hans Vercammen <hveso3@gmail.com>
" 		pancake <pancake@nopcode.org>
" 		Sebastian Reichel <sre@ring0.de>
" 		Adrià Arrufat <adria.arrufat@protonmail.ch>
" Filenames: 	*.vala *.vapi *.valadoc
"
" REFERENCES:
" [1] http://live.gnome.org/Vala
"
" TODO: Possibly when reaching vala 1.0 release
" 	- validate code attributes
" 	- better error checking for known errors
" 	- full support for valadoc
"
" 	add vala in /usr/share/vim/vim80/scripts.vim below ruby
" 	to have shebang support

if exists("b:current_syntax")
  finish
endif

let s:vala_cpo_save = &cpo
set cpo&vim

" Types
syn keyword valaType			bool char double float size_t ssize_t string unichar void
syn keyword valaType 			int int8 int16 int32 int64 long short
syn keyword valaType 			uchar uint uint8 uint16 uint32 uint64 ulong ushort
" Storage keywords
syn keyword valaStorage			class delegate enum errordomain interface namespace struct
" repeat / condition / label
syn keyword valaRepeat			break continue do for foreach return while
syn keyword valaConditional		else if switch assert
" User Labels
syn keyword valaLabel			case default

" Modifiers
syn keyword valaModifier		abstract const dynamic ensures extern inline internal override 
syn keyword valaModifier 		private protected public requires signal static virtual volatile weak
syn keyword valaModifier 		async owned unowned
" Constants
syn keyword valaConstant		false null true
" Exceptions
syn keyword valaException		try catch finally throw
" Unspecified Statements
syn keyword valaUnspecifiedStatement	as base construct delete get in is lock new out params ref sizeof set this throws typeof using value var yield
" Arrays and Lists
syn match   valaArray			"\(\w\(\w\)*\(\s\+\)\?<\)\+\(\(\s\+\)\?\w\(\w\)*\(?\|\*\)\?\(\,\)\?\)\+>\+"
" Methods
syn match   valaMethod			"\(@\)\?\w\(\w\)*\(\s\+\)\?("he=e-1,me=e-1
" Operators
syn match   valaOperator		display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\|?\)=\?"
" Delimiters
syn match   valaDelimiter		display "(\|)\|\[\|\]\|,\|;\|:\|{\|}\|\k\@<!_\k\@!\|[[:punct:]]\@<!@[[:punct:]]\@!"
" Enum Fields
syn match   valaEnumField		"\.\([A-Z_]\)\+\([A-Z_0-9]\)\+"hs=s+1 " ensure there are at least 2 CAPS or 1 CAP and 1 number

" Comments
syn cluster valaCommentGroup 		contains=valaTodo
syn keyword valaTodo 			contained TODO FIXME XXX NOTE

" valadoc Comments (ported from javadoc comments in java.vim)
if !exists("vala_ignore_valadoc")
  syn cluster valaDocCommentGroup	contains=valaDocTags,valaDocSeeTag
  syn region  valaDocTags 		contained start="{@\(link\|inherit[Dd]oc\)" end="}"
  syn match   valaDocTags 		contained "@\(param\|exception\|throws\|since\|[Vv]ersion\)\s\+\S\+" contains=valaDocParam
  syn match   valaDocParam 		contained "\s\S\+"
  syn match   valaDocTags 		contained "@\(return\)\>"
  syn region  valaDocSeeTag		contained matchgroup=valaDocTags start="@see\s\+" matchgroup=NONE end="\_."re=e-1 contains=valaDocSeeTagParam
  syn match   valaDocSeeTagParam	contained @"\_[^"]\+"\|<a\s\+\_.\{-}</a>\|\(\k\|\.\)*\(#\k\+\((\_[^)]\+)\)\=\)\=@ extend
endif

" Comment Strings (ported from c.vim)
if exists("vala_comment_strings")
  syn match  	valaCommentSkip		contained "^\s*\*\($\|\s\+\)"
  syn region 	valaCommentString	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=valaSpecialChar,valaCommentSkip
  syn region 	valaComment2String	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=valaSpecialChar
  syn cluster 	valaCommentStringGroup 	contains=valaCommentString,valaCharacter,valaNumber

  syn region 	valaCommentL		start="//" end="$" keepend contains=@valaCommentGroup,valaComment2String,valaCharacter,valaNumber,valaSpaceError,@Spell
  syn region 	valaComment		matchgroup=valaCommentStart start="/\*" end="\*/" contains=@valaCommentGroup,@valaCommentStringGroup,valaCommentStartError,valaSpaceError,@Spell extend fold
  if !exists("vala_ignore_valadoc")
    syn region 	valaDocComment 		matchgroup=valaCommentStart start="/\*\*" end="\*/" keepend contains=@valaCommentGroup,@valaDocCommentGroup,@valaCommentStringGroup,valaCommentStartError,valaSpaceError,@Spell
  endif
else
  syn region	valaCommentL		start="//" end="$" keepend contains=@valaCommentGroup,valaSpaceError,@Spell
  syn region	valaComment		matchgroup=valaCommentStart start="/\*" end="\*/" fold contains=@valaCommentGroup,valaCommentStartError,valaSpaceError,@Spell
  if !exists("vala_ignore_valadoc")
    syn region 	valaDocComment 		matchgroup=valaCommentStart start="/\*\*" end="\*/" fold keepend contains=@valaCommentGroup,@valaDocCommentGroup,valaCommentStartError,valaSpaceError,@Spell
  endif
endif

syn region	valaPreCondit		start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1
syn match	valaPreCondit		display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"

" Comment if 0 blocks (ported from c.vim)
if !exists("vala_no_if0")
  syn region	valaCppOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=valaCppOut2 fold
  syn region	valaCppOut2		contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=valaSpaceError,valaCppSkip
  syn region	valaCppSkip		contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=valaSpaceError,valaCppSkip
endif

" match comment errors
syntax match valaCommentError 		display "\*/"
syntax match valaCommentStartError 	display "/\*"me=e-1 contained
" match the special comment /**/
syn match   valaComment		 	"/\*\*/"

" comment script lines
syn region   valaScript			start="^#!" end="$"

" Vala Code Attributes
syn region  valaAttribute 		start="^\s*\[" end="\]" contains=valaComment,valaString keepend
syn region  valaAttribute 		start="\[CCode" end="\]" contains=valaComment,valaString

" Avoid escaped keyword matching
syn match   valaUserContent 		display "@\I*"

" Strings and constants
syn match   valaSpecialError		contained "\\."
syn match   valaSpecialCharError	contained "[^']"
syn match   valaSpecialChar		contained +\\["\\'0abfnrtvx]+
syn match   valaFormatChar		contained +%\(%\|\([-]\)\?\([+]\)\?\([0-9]\+\)\?\(\.\)\?\([0-9]\+\)\?\(l\?[dfiu]\|ll\?[diu]\|c\|g\|hh\?[iu]\|s\)\)+
syn match   valaTemplateVariable	contained +\($\w\(\w\)*\)+
syn region  valaTemplateExpression	start=+$(+ end=")"
syn region  valaString			start=+"+  end=+"+ end=+$+ contains=valaSpecialChar,valaSpecialError,valaUnicodeNumber,@Spell,valaFormatChar
syn region  valaTemplateString		start=+@"+  end=+"+ end=+$+ contains=valaSpecialChar,valaSpecialError,valaUnicodeNumber,@Spell,valaFormatChar,valaTemplateVariable,valaTemplateExpression
syn region  valaVerbatimString		start=+"""+ end=+"""+ contains=@Spell,valaFormatChar
syn match   valaUnicodeNumber		+\\\(u\x\{4}\|U\x\{8}\)+ contained contains=valaUnicodeSpecifier
syn match   valaUnicodeSpecifier	+\\[uU]+ contained
syn match   valaCharacter		"'[^']*'" contains=valaSpecialChar,valaSpecialCharError
syn match   valaCharacter		"'\\''" contains=valaSpecialChar
syn match   valaCharacter		"'[^\\]'"
syn match   valaNumber			display "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   valaNumber			display "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   valaNumber			display "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   valaNumber			display "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

" when wanted, highlight trailing white space
if exists("vala_space_errors")
  if !exists("vala_no_trail_space_error")
    syn match valaSpaceError		display excludenl "\s\+$"
  endif
  if !exists("vala_no_tab_space_error")
    syn match valaSpaceError 		display " \+\t"me=e-1
  endif
endif

" when wanted, set minimum lines for comment syntax syncing
if exists("vala_minlines")
  let b:vala_minlines = vala_minlines
else
  let b:vala_minlines = 50
endif
exec "syn sync ccomment valaComment minlines=" . b:vala_minlines

" code folding
syn region valaBlock			start="{" end="}" transparent fold

" The default highlighting.
hi def link valaType			Type
hi def link valaStorage			StorageClass
hi def link valaRepeat			Repeat
hi def link valaConditional		Conditional
hi def link valaLabel			Label
hi def link valaModifier		StorageClass
hi def link valaConstant		Constant
hi def link valaException		Exception
hi def link valaUnspecifiedStatement	Statement
hi def link valaUnspecifiedKeyword	Keyword
hi def link valaContextualStatement	Statement
hi def link valaArray			StorageClass
hi def link valaMethod			Function
hi def link valaOperator		Operator
hi def link valaDelimiter		Delimiter
hi def link valaEnumField		Constant

hi def link valaCommentError		Error
hi def link valaCommentStartError	Error
hi def link valaSpecialError		Error
hi def link valaSpecialCharError	Error
hi def link valaSpaceError 		Error

hi def link valaTodo			Todo
hi def link valaCommentL		valaComment
hi def link valaCommentStart		valaComment
hi def link valaCommentSkip		valaComment
hi def link valaComment			Comment
hi def link valaScript			Comment
hi def link valaDocComment		Comment
hi def link valaDocTags 		Special
hi def link valaDocParam 		Function
hi def link valaDocSeeTagParam 		Function
hi def link valaAttribute 		PreCondit

hi def link valaCommentString		valaString
hi def link valaComment2String		valaString
hi def link valaString			String
hi def link valaTemplateString		String
hi def link valaVerbatimString		String
hi def link valaCharacter		Character
hi def link valaSpecialChar		SpecialChar
hi def link valaFormatChar		SpecialChar
hi def link valaTemplateVariable	SpecialChar
hi def link valaTemplateExpression	SpecialChar
hi def link valaNumber			Number
hi def link valaUnicodeNumber		SpecialChar
hi def link valaUnicodeSpecifier	SpecialChar

hi def link valaPreCondit		PreCondit

if !exists("vala_no_if0")
  hi def link valaCppSkip		valaCppOut
  hi def link valaCppOut2		valaCppOut
  hi def link valaCppOut		Comment
endif

let b:current_syntax = "vala"

let &cpo = s:vala_cpo_save
unlet s:vala_cpo_save

" vim: ts=8

endif
