let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/caddyfile.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'caddyfile') == -1

" Language:	    Caddyfile
" Author:	    Josh Glendenning <josh@isobit.io>

if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

setlocal commentstring=#\ %s

" Add NERDCommenter delimiters
let s:delimiters = {'left': '#'}
if exists('g:NERDDelimiterMap')
	if !has_key(g:NERDDelimiterMap, 'caddyfile')
		let g:NERDDelimiterMap.caddyfile = s:delimiters
	endif
elseif exists('g:NERDCustomDelimiters')
	if !has_key(g:NERDCustomDelimiters, 'caddyfile')
		let g:NERDDelimiterMap.caddyfile = s:delimiters
	endif
else
	let g:NERDCustomDelimiters = {'caddyfile': s:delimiters}
endif
unlet s:delimiters

endif
