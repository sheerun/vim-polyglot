" LaTeX Box mappings

if exists("g:LatexBox_no_mappings")
	finish
endif

" latexmk {{{
map <buffer> <LocalLeader>ll :Latexmk<CR>
map <buffer> <LocalLeader>lL :Latexmk!<CR>
map <buffer> <LocalLeader>lc :LatexmkClean<CR>
map <buffer> <LocalLeader>lC :LatexmkClean!<CR>
map <buffer> <LocalLeader>lg :LatexmkStatus<CR>
map <buffer> <LocalLeader>lG :LatexmkStatus!<CR>
map <buffer> <LocalLeader>lk :LatexmkStop<CR>
map <buffer> <LocalLeader>le :LatexErrors<CR>
" }}}

" View {{{
map <buffer> <LocalLeader>lv :LatexView<CR>
" }}}

" TOC {{{
map <silent> <buffer> <LocalLeader>lt :LatexTOC<CR>
" }}}

" List of labels {{{
map <silent> <buffer> <LocalLeader>lj :LatexLabels<CR>
" }}}

" Jump to match {{{
if !exists('g:LatexBox_loaded_matchparen')
	nmap <buffer> % <Plug>LatexBox_JumpToMatch
	vmap <buffer> % <Plug>LatexBox_JumpToMatch
	omap <buffer> % <Plug>LatexBox_JumpToMatch
endif
" }}}

" Define text objects {{{
vmap <buffer> ie <Plug>LatexBox_SelectCurrentEnvInner
vmap <buffer> ae <Plug>LatexBox_SelectCurrentEnvOuter
omap <buffer> ie :normal vie<CR>
omap <buffer> ae :normal vae<CR>
vmap <buffer> i$ <Plug>LatexBox_SelectInlineMathInner
vmap <buffer> a$ <Plug>LatexBox_SelectInlineMathOuter
omap <buffer> i$ :normal vi$<CR>
omap <buffer> a$ :normal va$<CR>
" }}}

" Jump between sections {{{
function! s:LatexBoxNextSection(type, backwards, visual)
	" Restore visual mode if desired
	if a:visual
		normal! gv
	endif

	" For the [] and ][ commands we move up or down before the search
	if a:type == 1
		if a:backwards
			normal! k
		else
			normal! j
		endif
	endif

	" Define search pattern and do the search while preserving "/
	let save_search = @/
	let flags = 'W'
	if a:backwards
		let flags = 'b' . flags
	endif
	let notcomment = '\%(\%(\\\@<!\%(\\\\\)*\)\@<=%.*\)\@<!'
	let pattern = notcomment . '\v\s*\\(' . join([
				\ '(sub)*section',
				\ 'chapter',
				\ 'part',
				\ 'appendix',
				\ '(front|back|main)matter'], '|') . ')>'
	call search(pattern, flags)
	let @/ = save_search

	" For the [] and ][ commands we move down or up after the search
	if a:type == 1
		if a:backwards
			normal! j
		else
			normal! k
		endif
	endif
endfunction
noremap  <buffer> <silent> ]] :call <SID>LatexBoxNextSection(0,0,0)<CR>
noremap  <buffer> <silent> ][ :call <SID>LatexBoxNextSection(1,0,0)<CR>
noremap  <buffer> <silent> [] :call <SID>LatexBoxNextSection(1,1,0)<CR>
noremap  <buffer> <silent> [[ :call <SID>LatexBoxNextSection(0,1,0)<CR>
vnoremap <buffer> <silent> ]] :<c-u>call <SID>LatexBoxNextSection(0,0,1)<CR>
vnoremap <buffer> <silent> ][ :<c-u>call <SID>LatexBoxNextSection(1,0,1)<CR>
vnoremap <buffer> <silent> [] :<c-u>call <SID>LatexBoxNextSection(1,1,1)<CR>
vnoremap <buffer> <silent> [[ :<c-u>call <SID>LatexBoxNextSection(0,1,1)<CR>
" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
