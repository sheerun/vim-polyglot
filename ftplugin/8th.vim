let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/8th.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, '8th') == -1

" Vim ftplugin file
" Language:	8th
" Version:	any
" Last Change:	2015/11/08
" Maintainer:	Ron Aaron <ron@aaron-tech.com>
" URL:          https://8th-dev.com/
" Filetypes:	*.8th
" NOTE: 	8th allows any non-whitespace in a name, so you need to do:
" 		setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255
" 		This goes with the syntax/8th.vim file.

" Only do this when not done yet for this buffer
if exists("b:did_8thplugin")
 finish
endif

" Don't load another plugin for this buffer
let b:did_8thplugin = 1

setlocal ts=2 sts=2 sw=2 et
setlocal com=s1:/*,mb:*,ex:*/,:\|,:\\
setlocal fo=tcrqol
setlocal matchpairs+=\::;
setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255
setlocal suffixesadd=.8th

endif
