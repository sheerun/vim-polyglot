let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/merlin.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'reason') == -1

" Vim syntax file for editing merlin project files
if exists("b:current_syntax")
  finish
endif

syn keyword merlinKeyword S B SUFFIX PKG REC EXT PRJ FLG CMI CMT
syn match merlinComment "\v#.*$"

hi link merlinKeyword Keyword
hi link merlinComment Comment

let b:current_syntax = "merlin"


endif
