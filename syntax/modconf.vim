let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/modconf.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'modconf') == -1

" Vim syntax file
" Language:             modules.conf(5) configuration file
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2007-10-25

if exists("b:current_syntax")
  finish
endif

setlocal iskeyword+=-

let s:cpo_save = &cpo
set cpo&vim

syn keyword modconfTodo         FIXME TODO XXX NOTE

syn region  modconfComment      start='#' skip='\\$' end='$'
                                \ contains=modconfTodo,@Spell

syn keyword modconfConditional  if else elseif endif

syn keyword modconfPreProc      alias define include keep prune
                                \ post-install post-remove pre-install
                                \ pre-remove persistdir blacklist

syn keyword modconfKeyword      add above below install options probe probeall
                                \ remove

syn keyword modconfIdentifier   depfile insmod_opt path generic_stringfile
                                \ pcimapfile isapnpmapfile usbmapfile
                                \ parportmapfile ieee1394mapfile pnpbiosmapfile
syn match   modconfIdentifier   'path\[[^]]\+\]'

hi def link modconfTodo         Todo
hi def link modconfComment      Comment
hi def link modconfConditional  Conditional
hi def link modconfPreProc      PreProc
hi def link modconfKeyword      Keyword
hi def link modconfIdentifier   Identifier

let b:current_syntax = "modconf"

let &cpo = s:cpo_save
unlet s:cpo_save

endif
