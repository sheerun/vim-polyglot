if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'sxhkd') == -1

if exists("b:current_syntax")
    finish
endif

syntax include @Shell syntax/sh.vim

syn match sxComment "^#.*$"
syn match sxHotkey "[^ #].*" contains=sxKeysym,sxModifier,sxHotkeySep,sxSequence
syn match sxCommand "^\s.*$" containedin=ALL contains=@Shell,sxSequenceShell
syn keyword sxModifier super hyper meta alt control ctrl shift mode_switch lock mod1 mod2 mod3 mod4 mod5 any contained
syn match sxKeysym "[^ :;{,}+-]\+" contained contains=sxAction
syn match sxAction "[@~/]" contained
syn match sxHotkeySep "[;:+]" contained
syn match sxSequenceSep "[,-]" contained
syn region sxSequence matchgroup=sxBrace start=/{/ end=/}/ contained keepend oneline contains=sxKeysym,sxModifier,sxHotkeySep,sxSequenceSep
syn region sxSequenceShell matchgroup=sxBrace start=/{/ end=/}/ contained keepend oneline contains=sxKeysym,sxSequenceSep

hi def link sxComment Comment
hi def link sxModifier Keyword
hi def link sxKeysym Identifier
hi def link sxAction Special
hi def link sxBrace Special
hi def link sxHotkeySep Delimiter
hi def link sxSequenceSep Delimiter

let b:current_syntax = "sxhkdrc"

endif
