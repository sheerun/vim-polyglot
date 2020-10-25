if has_key(g:polyglot_is_disabled, 'reason')
  finish
endif

" Vim syntax file for editing merlin project files
if exists("b:current_syntax")
  finish
endif

syn keyword merlinKeyword S B SUFFIX PKG REC EXT PRJ FLG CMI CMT
syn match merlinComment "\v#.*$"

hi link merlinKeyword Keyword
hi link merlinComment Comment

let b:current_syntax = "merlin"

