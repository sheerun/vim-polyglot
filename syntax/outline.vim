if polyglot#init#is_disabled(expand('<sfile>:p'), 'org', 'syntax/outline.vim')
  finish
endif

" Vim syntax file for GNU Emacs' Outline mode
"
" Maintainer:   Alex Vear <alex@vear.uk>
" License:      Vim (see `:help license`)
" Location:     syntax/outline.vim
" Website:      https://github.com/axvr/org.vim
" Last Change:  2020-08-24
"
" Reference Specification: GNU Emacs Manual, section 'Outline Mode'
"   GNU Info: `$ info Emacs Outline Mode`
"   Web: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Outline-Mode.html>

if exists('b:current_syntax')
    finish
endif

" Enable spell check for non syntax highlighted text
syntax spell toplevel


" Headings
syntax match outlineHeading1 /^\s*\*\{1}\s\+.*$/ keepend contains=@Spell
syntax match outlineHeading2 /^\s*\*\{2}\s\+.*$/ keepend contains=@Spell
syntax match outlineHeading3 /^\s*\*\{3}\s\+.*$/ keepend contains=@Spell
syntax match outlineHeading4 /^\s*\*\{4}\s\+.*$/ keepend contains=@Spell
syntax match outlineHeading5 /^\s*\*\{5}\s\+.*$/ keepend contains=@Spell
syntax match outlineHeading6 /^\s*\*\{6,}\s\+.*$/ keepend contains=@Spell

syntax cluster outlineHeadingGroup contains=outlineHeading1,outlineHeading2,outlineHeading3,outlineHeading4,outlineHeading5,outlineHeading6

hi def link outlineHeading1 Title
hi def link outlineHeading2 outlineHeading1
hi def link outlineHeading3 outlineHeading2
hi def link outlineHeading4 outlineHeading3
hi def link outlineHeading5 outlineHeading4
hi def link outlineHeading6 outlineHeading5


let b:current_syntax = 'outline'
