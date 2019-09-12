if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

" Vim syntax file
" Language:	OMakefile

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match omakeRuleOption +:\(optional\|exists\|effects\|scanner\|value\):+
syn match omakeKeyword "^\s*\(case\|catch\|class\|declare\|default\|do\|elseif\|else\|export\|extends\|finally\|if\|import\|include\|match\|open\|raise\|return\|section\|switch\|try\|value\|when\|while\)\s*"
syn match omakeOperator "\[\]\|=\|+="

" some special characters
syn match makeSpecial	"^\s*[@+-]\+"
syn match makeNextLine	"\\\n\s*"

" some directives
syn match makeInclude	"^ *[-s]\=include"
syn match makeStatement	"^ *vpath"
syn match makeExport    "^ *\(export\|unexport\)\>"
syn match makeSection "^\s*section\s*$"
syn match makeOverride	"^ *override"
hi link makeOverride makeStatement
hi link makeExport makeStatement
hi link makeSection makeStatement

" Koehler: catch unmatched define/endef keywords.  endef only matches it is by itself on a line
syn region makeDefine start="^\s*define\s" end="^\s*endef\s*$" contains=makeStatement,makeIdent,makeDefine

" Microsoft Makefile specials
syn case ignore
syn match makeInclude	"^! *include"
syn case match

" identifiers
syn region makeIdent	start="\$(" skip="\\)\|\\\\" end=")" contains=makeStatement,makeIdent,makeSString,makeDString,omakeDoubleQuoteString,omakeSingleQuoteString
syn region makeIdent	start="\${" skip="\\}\|\\\\" end="}" contains=makeStatement,makeIdent,makeSString,makeDString,omakeDoubleQuoteString,omakeSingleQuoteString
syn match makeIdent	"\$\$\w*"
syn match makeIdent	"\$[^({]"
syn match makeIdent	"^ *\a\w*\s*[:+?!*]="me=e-2
syn match makeIdent	"^ *\a\w*\s*="me=e-1
syn match makeIdent	"%"

" Makefile.in variables
syn match makeConfig "@[A-Za-z0-9_]\+@"

" make targets
" syn match makeSpecTarget	"^\.\(STATIC\|PHONY\|DEFAULT\|MEMO\|INCLUDE\|ORDER\|SCANNER\|SUBDIRS\|BUILD_BEGIN\|BUILD_FAILURE\|BUILD_SUCCESS\|BUILDORDER\)\>"
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:[^=]"me=e-2 nextgroup=makeSource
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:$"me=e-1 nextgroup=makeSource

syn region makeTarget	transparent matchgroup=makeTarget start="^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}[^:=]"rs=e-1 end=";"re=e-1,me=e-1 end="[^\\]$" keepend contains=makeIdent,makeSpecTarget,makeNextLine skipnl nextGroup=makeCommands
syn match makeTarget		"^[A-Za-z0-9_./$()%*@-][A-Za-z0-9_./\t $()%*@-]*::\=\s*$" contains=makeIdent,makeSpecTarget skipnl nextgroup=makeCommands

syn region makeSpecTarget	transparent matchgroup=makeSpecTarget start="^\s*\.\(STATIC\|PHONY\|DEFAULT\|MEMO\|INCLUDE\|ORDER\|SCANNER\|SUBDIRS\|BUILD_BEGIN\|BUILD_FAILURE\|BUILD_SUCCESS\|BUILDORDER\)\>\s*:\{1,2}[^:=]"rs=e-1 end="[^\\]$" keepend contains=makeIdent,makeSpecTarget,makeNextLine skipnl nextGroup=makeCommands
syn match makeSpecTarget		"^\s*\.\(STATIC\|PHONY\|DEFAULT\|MEMO\|INCLUDE\|ORDER\|SCANNER\|SUBDIRS\|BUILD_BEGIN\|BUILD_FAILURE\|BUILD_SUCCESS\|BUILDORDER\)\>\s*::\=\s*$" contains=makeIdent skipnl nextgroup=makeCommands

syn region makeCommands start=";"hs=s+1 start="^\t" end="^[^\t#]"me=e-1,re=e-1 end="^$" contained contains=makeCmdNextLine,makeSpecial,makeComment,makeIdent,makeDefine,makeDString,makeSString
syn match makeCmdNextLine	"\\\n."he=e-1 contained


" Statements / Functions (GNU make)
syn match makeStatement contained "(\(subst\|abspath\|addprefix\|addsuffix\|and\|basename\|call\|dir\|error\|eval\|filter-out\|filter\|findstring\|firstword\|flavor\|foreach\|if\|info\|join\|lastword\|notdir\|or\|origin\|patsubst\|realpath\|shell\|sort\|strip\|suffix\|value\|warning\|wildcard\|word\|wordlist\|words\)\>"ms=s+1

" Comment
syn region  makeComment	start="#" end="^$" end="[^\\]$" keepend contains=@Spell,makeTodo
syn match   makeComment	"#$" contains=@Spell
syn keyword makeTodo TODO FIXME XXX contained

" match escaped quotes and any other escaped character
" except for $, as a backslash in front of a $ does
" not make it a standard character, but instead it will
" still act as the beginning of a variable
" The escaped char is not highlighted currently
syn match makeEscapedChar	"\\[^$]"

syn match omakeCallExpr "\$(\h[a-zA-Z0-9_-]*\s\+[^(]\+)" contains=@omakeExpr
syn match omakeVar "\$(\h[a-zA-Z0-9_-]*)"
syn cluster omakeExpr contains=omakeVar,omakeCallExpr

syn region omakeSingleQuoteString start=+\$'+ skip=+[^']+ end=+'+
syn region omakeDoubleQuoteString start=+\$"+ skip=+\\.+ end=+"+
syn region omakeDoubleQuoteString start=+\$"""+ skip=+\\.+ end=+"""+

syn region  makeDString start=+\(\\\)\@<!"+  skip=+\\.+  end=+"+  contains=makeIdent
syn region  makeSString start=+\(\\\)\@<!'+  skip=+\\.+  end=+'+  contains=makeIdent
syn region  makeBString start=+\(\\\)\@<!`+  skip=+\\.+  end=+`+  contains=makeIdent,makeSString,makeDString,makeNextLine

" Syncing
syn sync minlines=20 maxlines=200

" Sync on Make command block region: When searching backwards hits a line that
" can't be a command or a comment, use makeCommands if it looks like a target,
" NONE otherwise.
syn sync match makeCommandSync groupthere NONE "^[^\t#]"
syn sync match makeCommandSync groupthere makeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}[^:=]"
syn sync match makeCommandSync groupthere makeCommands "^[A-Za-z0-9_./$()%-][A-Za-z0-9_./\t $()%-]*:\{1,2}\s*$"

hi def link makeNextLine		makeSpecial
hi def link makeCmdNextLine	makeSpecial
hi def link makeSpecTarget		Statement
hi def link makeCommands		Number
hi def link makeImplicit		Function
hi def link makeTarget		Function
hi def link makeInclude		Include
hi def link makeStatement		Statement
hi def link makeIdent		Identifier
hi def link makeSpecial		Special
hi def link makeComment		Comment
hi def link makeDString		String
hi def link makeSString		String
hi def link makeBString		Function
hi def link makeError		Error
hi def link makeTodo		Todo
hi def link makeDefine		Define
hi def link makeConfig		PreCondit

hi def link omakeOperator Operator
hi def link omakeDoubleQuoteString String
hi def link omakeSingleQuoteString String
hi def link omakeVar Identifier
hi def link omakeCallExpr Statement
hi def link omakeKeyword Keyword
hi def link omakeRuleOption Type

let b:current_syntax = "omake"
" vim: ts=8

endif
