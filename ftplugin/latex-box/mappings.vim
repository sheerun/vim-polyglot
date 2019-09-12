if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

" LaTeX Box mappings

if exists("g:LatexBox_no_mappings")
	finish
endif

" latexmk {{{
noremap <buffer> <LocalLeader>ll :Latexmk<CR>
noremap <buffer> <LocalLeader>lL :Latexmk!<CR>
noremap <buffer> <LocalLeader>lc :LatexmkClean<CR>
noremap <buffer> <LocalLeader>lC :LatexmkClean!<CR>
noremap <buffer> <LocalLeader>lg :LatexmkStatus<CR>
noremap <buffer> <LocalLeader>lG :LatexmkStatus!<CR>
noremap <buffer> <LocalLeader>lk :LatexmkStop<CR>
noremap <buffer> <LocalLeader>le :LatexErrors<CR>
" }}}

" View {{{
noremap <buffer> <LocalLeader>lv :LatexView<CR>
" }}}

" TOC {{{
noremap <silent> <buffer> <LocalLeader>lt :LatexTOC<CR>
" }}}

" List of labels {{{
noremap <silent> <buffer> <LocalLeader>lj :LatexLabels<CR>
" }}}

" Folding {{{
if g:LatexBox_Folding == 1
	noremap <buffer> <LocalLeader>lf :LatexFold<CR>
endif
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
onoremap <buffer> ie :normal vie<CR>
onoremap <buffer> ae :normal vae<CR>
vmap <buffer> i$ <Plug>LatexBox_SelectInlineMathInner
vmap <buffer> a$ <Plug>LatexBox_SelectInlineMathOuter
onoremap <buffer> i$ :normal vi$<CR>
onoremap <buffer> a$ :normal va$<CR>
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

endif
