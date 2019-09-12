if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1

" Vim filetype plugin file
" Language:	OMake

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set 'comments' to format dashed lists in comments
setlocal com=sO:#\ -,mO:#\ \ ,b:#

" Set 'commentstring' to put the marker after a #.
setlocal commentstring=#\ %s

" always use spaces and not tabs
setlocal expandtab

" Including files.
let &l:include = '^\s*include'

endif
