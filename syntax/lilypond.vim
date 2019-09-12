if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'lilypond') == -1

" LilyPond syntax file
" Language:	LilyPond
" Maintainer:	Heikki Junes <hjunes@cc.hut.fi>
" Last Change:	2010 Jul 26
"
" Installed As:	vim/syntax/lilypond.vim
" Uses Generated File:	vim/syntax/lilypond-words.vim
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the LilyPond syntax match groups: 
"   lilyKeyword, lilyReservedWord, lilyNote
if version < 600
  so <sfile>:p:h/lilypond-words.vim
else
  runtime! syntax/lilypond-words.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
endif

" Match also parethesis of angle type
setlocal mps+=<:>

" Case matters
syn case match

syn cluster lilyMatchGroup	contains=lilyMatcher,lilyString,lilyComment,lilyStatement,lilyNumber,lilySlur,lilySpecial,lilyNote,lilyKeyword,lilyArticulation,lilyReservedWord,lilyScheme

syn region lilyMatcher	matchgroup=Delimiter start="{" skip="\\\\\|\\[<>]"	end="}"	contains=@lilyMatchGroup fold
syn region lilyMatcher	matchgroup=Delimiter start="\["		end="]"	contains=@lilyMatchGroup fold
syn region lilyMatcher	matchgroup=Delimiter start="<" skip="\\\\\|\\[{<>}]" end=">"	contains=@lilyMatchGroup fold

syn region lilyString	start=/"/ end=/"/ skip=/\\"/
syn region lilyComment	start="%{" skip="%$" end="%}"
syn region lilyComment	start="%\([^{]\|$\)" end="$"

syn match lilyNumber	"[-_^.]\?\d\+[.]\?"
syn match lilySlur	"[(~)]"
syn match lilySlur	"\\[()]"
syn match lilySpecial	"\\[<!>\\]"
" avoid highlighting the extra character in situations like
" c--\mf c^^\mf c__\mf
syn match lilyArticulation	"[-_^][-_^+|>.]"

" Include Scheme syntax highlighting, where appropriate
syn include @embeddedScheme syntax/scheme.vim
unlet b:current_syntax
syn region lilyScheme matchgroup=Delimiter start="#['`]\?(" matchgroup=Delimiter end=")" contains=@embeddedScheme

" Rest of syntax highlighting rules start here
"
" " Define the default highlighting.
" " For version 5.7 and earlier: only when not done already
" " For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lily_syn_inits")
  if version < 508
    let did_lily_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink Delimiter	Identifier
  
  HiLink lilyString	String
  HiLink lilyComment	Comment
 
  HiLink lilyNote	Identifier
  HiLink lilyArticulation	PreProc
  HiLink lilyKeyword	Keyword
  HiLink lilyReservedWord	Type

  HiLink lilyNumber	Constant
  HiLink lilySpecial	Special
  HiLink lilySlur	ModeMsg

  delcommand HiLink
endif

let b:current_syntax = "lilypond"

endif
