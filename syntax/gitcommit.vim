if polyglot#init#is_disabled(expand('<sfile>:p'), 'git', 'syntax/gitcommit.vim')
  finish
endif

" Vim syntax file
" Language:	git commit file
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Filenames:	*.git/COMMIT_EDITMSG
" Last Change:	2019 Dec 05

if exists("b:current_syntax")
  finish
endif

syn case match
syn sync minlines=50
syn sync linebreaks=1

if has("spell")
  syn spell toplevel
endif

syn include @gitcommitDiff syntax/diff.vim
syn region gitcommitDiff start=/\%(^diff --\%(git\|cc\|combined\) \)\@=/ end=/^\%(diff --\|$\|#\)\@=/ fold contains=@gitcommitDiff

syn match   gitcommitSummary	"^.*\%<51v." contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
syn match   gitcommitOverflow	".*" contained contains=@Spell
syn match   gitcommitBlank	"^[^#].*" contained contains=@Spell

syn match   gitcommitTrailers	"\n\@<=\n\%([[:alnum:]-]\+\s*:.*\|(cherry picked from commit .*\)\%(\n\s.*\|\n[[:alnum:]-]\+\s*:.*\|\n(cherry picked from commit .*\)*\%(\n\n*#\|\n*\%$\)\@="
syn match   gitcommitTrailerToken "^[[:alnum:]-]\+\s*:" contained containedin=gitcommitTrailers

if get(b:, "gitcommit_cleanup", get(g:, "gitcommit_cleanup", "")) is# "scissors"
  syn match gitcommitFirstLine	"\%^.*" nextgroup=gitcommitBlank skipnl
  syn region gitcommitComment start=/^# -\+ >8 -\+$/ end=/\%$/ contains=gitcommitDiff
else
  syn match gitcommitFirstLine	"\%^[^#].*" nextgroup=gitcommitBlank skipnl
  syn match gitcommitComment	"^#.*"
endif

syn match   gitcommitHash	"\<\x\{40,}\>" contains=@NoSpell display
syn match   gitcommitHead	"^\%(#   .*\n\)\+#$" contained transparent
syn match   gitcommitOnBranch	"\%(^# \)\@<=On branch" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite
syn match   gitcommitOnBranch	"\%(^# \)\@<=Your branch .\{-\} '" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite
syn match   gitcommitBranch	"[^ ']\+" contained
syn match   gitcommitNoBranch	"\%(^# \)\@<=Not currently on any branch." contained containedin=gitcommitComment
syn match   gitcommitHeader	"\%(^# \)\@<=.*:$"	contained containedin=gitcommitComment
syn region  gitcommitAuthor	matchgroup=gitCommitHeader start=/\%(^# \)\@<=\%(Author\|Committer\):/ end=/$/ keepend oneline contained containedin=gitcommitComment transparent
syn match   gitcommitNoChanges	"\%(^# \)\@<=No changes$" contained containedin=gitcommitComment

syn region  gitcommitUntracked	start=/^# Untracked files:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUntrackedFile fold
syn match   gitcommitUntrackedFile  "\t\@<=.*"	contained

syn region  gitcommitDiscarded	start=/^# Change\%(s not staged for commit\|d but not updated\):/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitDiscardedType fold
syn region  gitcommitSelected	start=/^# Changes to be committed:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitSelectedType fold
syn region  gitcommitUnmerged	start=/^# Unmerged paths:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUnmergedType fold


syn match   gitcommitDiscardedType	"\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2	contained containedin=gitcommitComment nextgroup=gitcommitDiscardedFile skipwhite
syn match   gitcommitSelectedType	"\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2	contained containedin=gitcommitComment nextgroup=gitcommitSelectedFile skipwhite
syn match   gitcommitUnmergedType	"\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2	contained containedin=gitcommitComment nextgroup=gitcommitUnmergedFile skipwhite
syn match   gitcommitDiscardedFile	".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitDiscardedArrow
syn match   gitcommitSelectedFile	".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitSelectedArrow
syn match   gitcommitUnmergedFile	".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitSelectedArrow
syn match   gitcommitDiscardedArrow	" -> " contained nextgroup=gitcommitDiscardedFile
syn match   gitcommitSelectedArrow	" -> " contained nextgroup=gitcommitSelectedFile
syn match   gitcommitUnmergedArrow	" -> " contained nextgroup=gitcommitSelectedFile

syn match   gitcommitWarning		"\%^[^#].*: needs merge$" nextgroup=gitcommitWarning skipnl
syn match   gitcommitWarning		"^[^#].*: needs merge$" nextgroup=gitcommitWarning skipnl contained
syn match   gitcommitWarning		"^\%(no changes added to commit\|nothing \%(added \)\=to commit\)\>.*\%$"

hi def link gitcommitSummary		Keyword
hi def link gitcommitTrailerToken	Label
hi def link gitcommitComment		Comment
hi def link gitcommitUntracked		gitcommitComment
hi def link gitcommitDiscarded		gitcommitComment
hi def link gitcommitSelected		gitcommitComment
hi def link gitcommitUnmerged		gitcommitComment
hi def link gitcommitHash		Identifier
hi def link gitcommitOnBranch		Comment
hi def link gitcommitBranch		Special
hi def link gitcommitNoBranch		gitCommitBranch
hi def link gitcommitDiscardedType	gitcommitType
hi def link gitcommitSelectedType	gitcommitType
hi def link gitcommitUnmergedType	gitcommitType
hi def link gitcommitType		Type
hi def link gitcommitNoChanges		gitcommitHeader
hi def link gitcommitHeader		PreProc
hi def link gitcommitUntrackedFile	gitcommitFile
hi def link gitcommitDiscardedFile	gitcommitFile
hi def link gitcommitSelectedFile	gitcommitFile
hi def link gitcommitUnmergedFile	gitcommitFile
hi def link gitcommitFile		Constant
hi def link gitcommitDiscardedArrow	gitcommitArrow
hi def link gitcommitSelectedArrow	gitcommitArrow
hi def link gitcommitUnmergedArrow	gitcommitArrow
hi def link gitcommitArrow		gitcommitComment
"hi def link gitcommitOverflow		Error
hi def link gitcommitBlank		Error

let b:current_syntax = "gitcommit"
