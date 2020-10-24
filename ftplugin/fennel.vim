let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/fennel.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fennel') == -1

" Vim filetype plugin file
" Language: FENNEL
" Maintainer: Calvin Rose

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

"setlocal iskeyword+=!,_,%,?,-,*,!,+,/,=,<,>,.,:,$,^
setlocal iskeyword=!,$,%,#,*,+,-,.,/,:,<,=,>,?,_,a-z,A-Z,48-57,128-247,124,126,38,94

" There will be false positives, but this is better than missing the whole set
" of user-defined def* definitions.
setlocal define=\\v[(/]def(ault)@!\\S*

" Remove 't' from 'formatoptions' to avoid auto-wrapping code.
setlocal formatoptions-=t

setlocal comments=n:;
setlocal commentstring=;\ %s

let &cpo = s:cpo_save

endif
