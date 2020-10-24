let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/reva.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'reva') == -1

" Vim ftplugin file
" Language:	Reva Forth
" Version:	7.1
" Last Change:	2008/01/11
" Maintainer:	Ron Aaron <ron@ronware.org>
" URL:		http://ronware.org/reva/
" Filetypes:	*.rf *.frt 
" NOTE: 	Forth allows any non-whitespace in a name, so you need to do:
" 		setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255
"
" 		This goes with the syntax/reva.vim file.

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
 finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

setlocal sts=4 sw=4 
setlocal com=s1:/*,mb:*,ex:*/,:\|,:\\
setlocal fo=tcrqol
setlocal matchpairs+=\::;
setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255

endif
