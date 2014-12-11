" Vim syntax file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327"
"
" The following settings are available for tuning syntax highlighting:
"    let ps1_nofold_blocks = 1
"    let ps1_nofold_sig = 1

" Compatible VIM syntax file start
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" PowerShell doesn't care about case
syn case ignore

" Sync-ing method
syn sync minlines=100

" Certain tokens can't appear at the top level of the document
syn cluster ps1NotTop contains=@ps1Comment,ps1CDocParam,ps1Function

" Comments and special comment words
syn keyword ps1CommentTodo TODO FIXME XXX TBD HACK NOTE contained
syn match ps1CDocParam /.*/ contained
syn match ps1CommentDoc /^\s*\zs\.\w\+\>/ nextgroup=ps1CDocParam contained
syn match ps1CommentDoc /#\s*\zs\.\w\+\>/ nextgroup=ps1CDocParam contained
syn match ps1Comment /#.*/ contains=ps1CommentTodo,ps1CommentDoc,@Spell
syn region ps1Comment start="<#" end="#>" contains=ps1CommentTodo,ps1CommentDoc,@Spell

" Language keywords and elements
syn keyword ps1Conditional if else elseif switch default
syn keyword ps1Repeat while for do until break continue foreach in
syn match ps1Repeat /\<foreach\>/ nextgroup=ps1Block skipwhite
syn match ps1Keyword /\<while\>/ nextgroup=ps1Block skipwhite
syn match ps1Keyword /\<where\>/ nextgroup=ps1Block skipwhite

syn keyword ps1Exception begin process end exit
syn keyword ps1Keyword try catch finally throw
syn keyword ps1Keyword return filter in trap param data dynamicparam 
syn match ps1Keyword /&/
syn keyword ps1Constant $true $false $null
syn match ps1Constant +\$?+
syn match ps1Constant +\$_+
syn match ps1Constant +\$\$+
syn match ps1Constant +\$^+

" Keywords reserved for future use
syn keyword ps1Keyword class define from using var

" Functions and Cmdlets
syn match ps1Cmdlet /\w\+-\w\+/
syn keyword ps1Keyword function nextgroup=ps1Function skipwhite
syn keyword ps1Keyword filter nextgroup=ps1Function skipwhite
syn match ps1Function /\w\+-*\w*/ contained

" Type declarations
syn match ps1Type /\[[a-z0-9_:.]\+\(\[\]\)\?\]/
syn match ps1StandaloneType /[a-z0-9_.]\+/ contained
syn keyword ps1Scope global local private script contained

" Variables and other user defined items
syn match ps1Variable /\$\w\+/
syn match ps1Variable /\${\w\+:\\\w\+}/
syn match ps1ScopedVariable /\$\w\+:\w\+/ contains=ps1Scope
syn match ps1VariableName /\w\+/ contained

" Operators all start w/ dash
syn match ps1OperatorStart /-c\?/ nextgroup=ps1Operator
syn keyword ps1Operator eq ne ge gt lt le like notlike match notmatch replace split /contains/ notcontains contained
syn keyword ps1Operator ieq ine ige igt ile ilt ilike inotlike imatch inotmatch ireplace isplit icontains inotcontains contained
syn keyword ps1Operator ceq cne cge cgt clt cle clike cnotlike cmatch cnotmatch creplace csplit ccontains cnotcontains contained
syn keyword ps1Operator is isnot as join contained
syn keyword ps1Operator and or not xor band bor bnot bxor contained
syn keyword ps1Operator f contained

" Regular Strings
" These aren't precisely correct and could use some work
syn region ps1String start=/"/ skip=/`"/ end=/"/ contains=@ps1StringSpecial 
syn region ps1String start=/'/ skip=/''/ end=/'/

" Here-Strings
syn region ps1String start=/@"$/ end=/^"@/ contains=@ps1StringSpecial
syn region ps1String start=/@'$/ end=/^'@/

" Interpolation
syn match ps1Escape /`./ contained
syn region ps1Interpolation matchgroup=ps1InterpolationDelimiter start="$(" end=")" contained contains=ALLBUT,@ps1NotTop
syn region ps1NestedParentheses start="(" skip="\\\\\|\\)" matchgroup=ps1Interpolation end=")" transparent contained
syn cluster ps1StringSpecial contains=ps1Escape,ps1Interpolation,ps1Variable,ps1Boolean,ps1Constant,ps1BuiltIn

" Numbers
syn match   ps1Number		"\<\(0[xX]\x\+\|\d\+\)\([KMGTP][B]\)\=\>"
syn match   ps1Number		"\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[dD]\="
syn match   ps1Number		"\<\d\+[eE][-+]\=\d\+[dD]\=\>"
syn match   ps1Number		"\<\d\+\([eE][-+]\=\d\+\)\=[dD]\>"

" Constants
syn match ps1Boolean "$\%(true\|false\)\>"
syn match ps1Constant /\$null\>/
syn match ps1BuiltIn "$^\|$?\|$_\|$\$"
syn match ps1BuiltIn "$\%(args\|error\|foreach\|home\|input\)\>"
syn match ps1BuiltIn "$\%(match\(es\)\?\|myinvocation\|host\|lastexitcode\)\>"
syn match ps1BuiltIn "$\%(ofs\|shellid\|stacktrace\)\>"

" Folding blocks
if !exists('g:ps1_nofold_blocks')
	syn region ps1Block start=/{/ end=/}/ transparent fold
endif

if !exists('g:ps1_nofold_sig')
	syn region ps1Signature start=/# SIG # Begin signature block/ end=/# SIG # End signature block/ transparent fold
endif

" Setup default color highlighting
if version >= 508 || !exists("did_ps1_syn_inits")
	if version < 508
		let did_ps1_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink ps1Number Number
	HiLink ps1Block Block
	HiLink ps1Exception Exception
	HiLink ps1Constant Constant
	HiLink ps1String String
	HiLink ps1Escape SpecialChar
	HiLink ps1InterpolationDelimiter Delimiter
	HiLink ps1Conditional Conditional
	HiLink ps1Function Function
	HiLink ps1Variable Identifier
	HiLink ps1ScopedVariable Identifier
	HiLink ps1VariableName Identifier
	HiLink ps1Boolean Boolean
	HiLink ps1Constant Constant
	HiLink ps1BuiltIn StorageClass
	HiLink ps1Type Type
	HiLink ps1Scope Type
	HiLink ps1StandaloneType Type
	HiLink ps1Number Number
	HiLink ps1Comment Comment
	HiLink ps1CommentTodo Todo
	HiLink ps1CommentDoc Tag
	HiLink ps1CDocParam Todo
	HiLink ps1Operator Operator
	HiLink ps1Repeat Repeat
	HiLink ps1RepeatAndCmdlet Repeat
	HiLink ps1Keyword Keyword
	HiLink ps1KeywordAndCmdlet Keyword
	HiLink ps1Cmdlet Statement
	delcommand HiLink
endif

let b:current_syntax = "ps1"

