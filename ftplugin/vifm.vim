if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1

" vifmrc filetype plugin
" Maintainer:  xaizek <xaizek@posteo.net>
" Last Change: July 08, 2016
" Based On:    Vim file type file by Bram Moolenaar

if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

let b:undo_ftplugin = "setlocal formatoptions< comments< textwidth< commentstring<"

" Break comment lines but not other lines
setlocal formatoptions-=t formatoptions+=croql

" Set comment character
setlocal comments=:\"

" Format comments to be up to 78 characters long
if &textwidth == 0
	setlocal textwidth=78
endif

" Comments start with a double quote
setlocal commentstring=\"%s

" Move around comments
nnoremap <silent><buffer> ]" :call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")<CR>
vnoremap <silent><buffer> ]" :<C-U>exe "normal! gv"<Bar>call search('^\(\s*".*\n\)\@<!\(\s*"\)', "W")<CR>
nnoremap <silent><buffer> [" :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")<CR>
vnoremap <silent><buffer> [" :<C-U>exe "normal! gv"<Bar>call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")<CR>

" Let the matchit plugin know what items can be matched.
if exists("loaded_matchit")
	let b:match_ignorecase = 0
	let b:match_words = '\<if\>:\<el\%[seif]\>:\<en\%[dif]\>'
endif

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab cinoptions-=(0 :

endif
