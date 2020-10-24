let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/dylanlid.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dylanlid') == -1

" Vim syntax file
" Language:	Dylan Library Interface Files
" Authors:	Justus Pendleton <justus@acm.org>
"		Brent Fulgham <bfulgham@debian.org>
" Last Change:	Fri Sep 29 13:50:20 PDT 2000
"

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore

syn region	dylanlidInfo		matchgroup=Statement start="^" end=":" oneline
syn region	dylanlidEntry		matchgroup=Statement start=":%" end="$" oneline

syn sync	lines=50

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link dylanlidInfo		Type
hi def link dylanlidEntry		String


let b:current_syntax = "dylanlid"

" vim:ts=8

endif
