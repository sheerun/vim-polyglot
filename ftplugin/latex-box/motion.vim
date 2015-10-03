" LaTeX Box motion functions

" Motion options {{{
" Opening and closing patterns
if !exists('g:LatexBox_open_pats')
	let g:LatexBox_open_pats  = [ '\\{','{','\\(','(','\\\[','\[',
				\ '\\begin\s*{.\{-}}', '\\left\s*\%([^\\]\|\\.\|\\\a*\)']
	let g:LatexBox_close_pats = [ '\\}','}','\\)',')','\\\]','\]',
				\ '\\end\s*{.\{-}}',   '\\right\s*\%([^\\]\|\\.\|\\\a*\)']
endif
" }}}

" HasSyntax {{{
" s:HasSyntax(syntaxName, [line], [col])
function! s:HasSyntax(syntaxName, ...)
	let line = a:0 >= 1 ? a:1 : line('.')
	let col  = a:0 >= 2 ? a:2 : col('.')
	return index(map(synstack(line, col),
				\ 'synIDattr(v:val, "name") == "' . a:syntaxName . '"'),
				\ 1) >= 0
endfunction
" }}}

" Search and Skip Comments {{{
" s:SearchAndSkipComments(pattern, [flags], [stopline])
function! s:SearchAndSkipComments(pat, ...)
	let flags		= a:0 >= 1 ? a:1 : ''
	let stopline	= a:0 >= 2 ? a:2 : 0
	let saved_pos = getpos('.')

	" search once
	let ret = search(a:pat, flags, stopline)

	if ret
		" do not match at current position if inside comment
		let flags = substitute(flags, 'c', '', 'g')

		" keep searching while in comment
		while LatexBox_InComment()
			let ret = search(a:pat, flags, stopline)
			if !ret
				break
			endif
		endwhile
	endif

	if !ret
		" if no match found, restore position
		call setpos('.', saved_pos)
	endif

	return ret
endfunction
" }}}

" Finding Matching Pair {{{
function! s:FindMatchingPair(mode)

	if a:mode =~ 'h\|i'
		2match none
	elseif a:mode == 'v'
		normal! gv
	endif

	if LatexBox_InComment() | return | endif

	" open/close pairs (dollars signs are treated apart)
	let dollar_pat = '\$'
	let notbslash = '\%(\\\@<!\%(\\\\\)*\)\@<='
	let notcomment = '\%(\%(\\\@<!\%(\\\\\)*\)\@<=%.*\)\@<!'
	let anymatch =  '\('
				\ . join(g:LatexBox_open_pats + g:LatexBox_close_pats, '\|')
				\ . '\|' . dollar_pat . '\)'

	let lnum = line('.')
	let cnum = searchpos('\A', 'cbnW', lnum)[1]
	" if the previous char is a backslash
	if strpart(getline(lnum), cnum-2, 1) == '\'
		let cnum = cnum-1
	endif
	let delim = matchstr(getline(lnum), '\C^'. anymatch , cnum - 1)

	if empty(delim) || strlen(delim)+cnum-1< col('.')
		if a:mode =~ 'n\|v\|o'
			" if not found, search forward
			let cnum = match(getline(lnum), '\C'. anymatch , col('.') - 1) + 1
			if cnum == 0 | return | endif
			call cursor(lnum, cnum)
			let delim = matchstr(getline(lnum), '\C^'. anymatch , cnum - 1)
		elseif a:mode =~ 'i'
			" if not found, move one char bacward and search
			let cnum = searchpos('\A', 'bnW', lnum)[1]
			" if the previous char is a backslash
			if strpart(getline(lnum), cnum-2, 1) == '\'
				let cnum = cnum-1
			endif
			let delim = matchstr(getline(lnum), '\C^'. anymatch , cnum - 1)
			if empty(delim) || strlen(delim)+cnum< col('.') | return | endif
		elseif a:mode =~ 'h'
			return
		endif
	endif

	if delim =~ '^\$'

		" match $-pairs
		" check if next character is in inline math
		let [lnum0, cnum0] = searchpos('.', 'nW')
		if lnum0 && s:HasSyntax('texMathZoneX', lnum0, cnum0)
			let [lnum2, cnum2] = searchpos(notcomment . notbslash. dollar_pat, 'nW', line('w$')*(a:mode =~ 'h\|i') , 200)
		else
			let [lnum2, cnum2] = searchpos('\%(\%'. lnum . 'l\%' . cnum . 'c\)\@!'. notcomment . notbslash . dollar_pat, 'bnW', line('w0')*(a:mode =~ 'h\|i') , 200)
		endif

		if a:mode =~ 'h\|i'
			execute '2match MatchParen /\%(\%' . lnum . 'l\%' . cnum . 'c\$' . '\|\%' . lnum2 . 'l\%' . cnum2 . 'c\$\)/'
		elseif a:mode =~ 'n\|v\|o'
			call cursor(lnum2,cnum2)
		endif

	else
		" match other pairs
		for i in range(len(g:LatexBox_open_pats))
			let open_pat = notbslash . g:LatexBox_open_pats[i]
			let close_pat = notbslash . g:LatexBox_close_pats[i]

			if delim =~# '^' . open_pat
				" if on opening pattern, search for closing pattern
				let [lnum2, cnum2] = searchpairpos('\C' . open_pat, '', '\C'
							\ . close_pat, 'nW', 'LatexBox_InComment()',
							\ line('w$')*(a:mode =~ 'h\|i') , 200)
				if a:mode =~ 'h\|i'
					execute '2match MatchParen /\%(\%' . lnum . 'l\%' . cnum
								\ . 'c' . g:LatexBox_open_pats[i] . '\|\%'
								\ . lnum2 . 'l\%' . cnum2 . 'c'
								\ . g:LatexBox_close_pats[i] . '\)/'
				elseif a:mode =~ 'n\|v\|o'
					call cursor(lnum2,cnum2)
					if strlen(close_pat)>1 && a:mode =~ 'o'
						call cursor(lnum2, matchend(getline('.'), '\C'
									\ . close_pat, col('.')-1))
					endif
				endif
				break
			elseif delim =~# '^' . close_pat
				" if on closing pattern, search for opening pattern
				let [lnum2, cnum2] =  searchpairpos('\C' . open_pat, '',
							\ '\C\%(\%'. lnum . 'l\%' . cnum . 'c\)\@!'
							\ . close_pat, 'bnW', 'LatexBox_InComment()',
							\ line('w0')*(a:mode =~ 'h\|i') , 200)
				if a:mode =~ 'h\|i'
					execute '2match MatchParen /\%(\%' . lnum2 . 'l\%' . cnum2
								\ . 'c' . g:LatexBox_open_pats[i] . '\|\%'
								\ . lnum . 'l\%' . cnum . 'c'
								\ . g:LatexBox_close_pats[i] . '\)/'
				elseif a:mode =~ 'n\|v\|o'
					call cursor(lnum2,cnum2)
				endif
				break
			endif
		endfor

	endif
endfunction

" Allow to disable functionality if desired
if !exists('g:LatexBox_loaded_matchparen')
	" Disable matchparen autocommands
	augroup LatexBox_HighlightPairs
		autocmd BufEnter * if !exists("g:loaded_matchparen") || !g:loaded_matchparen | runtime plugin/matchparen.vim | endif
		autocmd BufEnter *.tex 3match none | unlet! g:loaded_matchparen | au! matchparen
		autocmd! CursorMoved *.tex call s:FindMatchingPair('h')
		autocmd! CursorMovedI *.tex call s:FindMatchingPair('i')
	augroup END
endif

" Use LatexBox'es FindMatchingPair as '%' (enable jump between e.g. $'s)
nnoremap <silent> <Plug>LatexBox_JumpToMatch	:call <SID>FindMatchingPair('n')<CR>
vnoremap <silent> <Plug>LatexBox_JumpToMatch	:call <SID>FindMatchingPair('v')<CR>
onoremap <silent> <Plug>LatexBox_JumpToMatch	v:call <SID>FindMatchingPair('o')<CR>

" }}}

" select inline math {{{
" s:SelectInlineMath(seltype)
" where seltype is either 'inner' or 'outer'
function! s:SelectInlineMath(seltype)

	let dollar_pat = '\\\@<!\$'

	if s:HasSyntax('texMathZoneX')
		call s:SearchAndSkipComments(dollar_pat, 'cbW')
	elseif getline('.')[col('.') - 1] == '$'
		call s:SearchAndSkipComments(dollar_pat, 'bW')
	else
		return
	endif

	if a:seltype == 'inner'
		normal! l
	endif

	if visualmode() ==# 'V'
		normal! V
	else
		normal! v
	endif

	call s:SearchAndSkipComments(dollar_pat, 'W')

	if a:seltype == 'inner'
		normal! h
	endif
endfunction

vnoremap <silent> <Plug>LatexBox_SelectInlineMathInner
			\ :<C-U>call <SID>SelectInlineMath('inner')<CR>
vnoremap <silent> <Plug>LatexBox_SelectInlineMathOuter
			\ :<C-U>call <SID>SelectInlineMath('outer')<CR>
" }}}

" select current environment {{{
function! s:SelectCurrentEnv(seltype)
	let [env, lnum, cnum, lnum2, cnum2] = LatexBox_GetCurrentEnvironment(1)
	call cursor(lnum, cnum)
	if a:seltype == 'inner'
		if env =~ '^\'
			call search('\\.\_\s*\S', 'eW')
		else
			call search('}\(\_\s*\[\_[^]]*\]\)\?\_\s*\S', 'eW')
		endif
	endif
	if visualmode() ==# 'V'
		normal! V
	else
		normal! v
	endif
	call cursor(lnum2, cnum2)
	if a:seltype == 'inner'
		call search('\S\_\s*', 'bW')
	else
		if env =~ '^\'
			normal! l
		else
			call search('}', 'eW')
		endif
	endif
endfunction
vnoremap <silent> <Plug>LatexBox_SelectCurrentEnvInner :<C-U>call <SID>SelectCurrentEnv('inner')<CR>
vnoremap <silent> <Plug>LatexBox_SelectCurrentEnvOuter :<C-U>call <SID>SelectCurrentEnv('outer')<CR>
" }}}

" Jump to the next braces {{{
"
function! LatexBox_JumpToNextBraces(backward)
	let flags = ''
	if a:backward
		normal h
		let flags .= 'b'
	else
		let flags .= 'c'
	endif
	if search('[][}{]', flags) > 0
		normal l
	endif
	let prev = strpart(getline('.'), col('.') - 2, 1)
	let next = strpart(getline('.'), col('.') - 1, 1)
	if next =~ '[]}]' && prev !~ '[][{}]'
		return "\<Right>"
	else
		return ''
	endif
endfunction
" }}}

" Table of Contents {{{

" Special UTF-8 conversion
function! s:ConvertBack(line)
	let line = a:line
	if exists('g:LatexBox_plaintext_toc')
		"
		" Substitute stuff like '\IeC{\"u}' to plain 'u'
		"
		let line = substitute(line, '\\IeC\s*{\\.\(.\)}', '\1', 'g')
	else
		"
		" Substitute stuff like '\IeC{\"u}' to corresponding unicode symbols
		"
		for [pat, symbol] in s:ConvBackPats
			let line = substitute(line, pat, symbol, 'g')
		endfor
	endif
	return line
endfunction

function! s:ReadTOC(auxfile, texfile, ...)
	let texfile = a:texfile
	let prefix = fnamemodify(a:auxfile, ':p:h')

	if a:0 != 2
		let toc = []
		let fileindices = { texfile : [] }
	else
		let toc = a:1
		let fileindices = a:2
		let fileindices[ texfile ] = []
	endif

	for line in readfile(a:auxfile)
		let included = matchstr(line, '^\\@input{\zs[^}]*\ze}')
		if included != ''
			" append the input TOX to `toc` and `fileindices`
			let newaux = prefix . '/' . included
			let newtex = fnamemodify(newaux, ':r') . '.tex'
			call s:ReadTOC(newaux, newtex, toc, fileindices)
			continue
		endif

		" Parse statements like:
		" \@writefile{toc}{\contentsline {section}{\numberline {secnum}Section Title}{pagenumber}}
		" \@writefile{toc}{\contentsline {section}{\tocsection {}{1}{Section Title}}{pagenumber}}
		" \@writefile{toc}{\contentsline {section}{\numberline {secnum}Section Title}{pagenumber}{otherstuff}}

		let line = matchstr(line,
					\ '\\@writefile{toc}{\\contentsline\s*\zs.*\ze}\s*$')
		if empty(line)
			continue
		endif

		let tree = LatexBox_TexToTree(s:ConvertBack(line))

		if len(tree) < 3
			" unknown entry type: just skip it
			continue
		endif

		" parse level
		let level = tree[0][0]
		" parse page
		if !empty(tree[2])
			let page = tree[2][0]
		else
			let page = ''
		endif
		" parse section number
		let secnum = ''
		let tree = tree[1]
		if len(tree) > 3 && empty(tree[1])
			call remove(tree, 1)
		endif
		if len(tree) > 1 && type(tree[0]) == type("") && tree[0] =~ '^\\\(\(chapter\)\?numberline\|tocsection\)'
			let secnum = LatexBox_TreeToTex(tree[1])
			let secnum = substitute(secnum, '\\\S\+\s', '', 'g')
			let secnum = substitute(secnum, '\\\S\+{\(.\{-}\)}', '\1', 'g')
			let secnum = substitute(secnum, '^{\+\|}\+$', '', 'g')
			call remove(tree, 1)
		endif
		" parse section title
		let text = LatexBox_TreeToTex(tree)
		let text = substitute(text, '^{\+\|}\+$',                 '', 'g')
		let text = substitute(text, '\m^\\\(no\)\?\(chapter\)\?numberline\s*', '', '')
		let text = substitute(text, '\*',                         '', 'g')

		" add TOC entry
		call add(fileindices[texfile], len(toc))
		call add(toc, {'file': texfile,
					\ 'level': level,
					\ 'number': secnum,
					\ 'text': text,
					\ 'page': page})
	endfor

	return [toc, fileindices]

endfunction

function! LatexBox_TOC(...)

	" Check if window already exists
	let winnr = bufwinnr(bufnr('LaTeX TOC'))
	" Two types of splits, horizontal and vertical
	let l:hori = "new"
	let l:vert = "vnew"

	" Set General Vars and initialize size
	let l:type = g:LatexBox_split_type
	let l:size = 10

	" Size detection
	if l:type == l:hori
	  let l:size = g:LatexBox_split_length
	elseif l:type == l:vert
	  let l:size = g:LatexBox_split_width
	endif

	if winnr >= 0
		if a:0 == 0
			silent execute winnr . 'wincmd w'
		else
			" Supplying an argument to this function causes toggling instead
			" of jumping to the TOC window
			if g:LatexBox_split_resize
				silent exe "set columns-=" . l:size
			endif
			silent execute 'bwipeout' . bufnr('LaTeX TOC')
		endif
		return
	endif
	" Read TOC
	let [toc, fileindices] = s:ReadTOC(LatexBox_GetAuxFile(),
									 \ LatexBox_GetMainTexFile())
	let calling_buf = bufnr('%')

	" Find closest section in current buffer
	let closest_index = s:FindClosestSection(toc,fileindices)

	" Create TOC window and set local settings
	if g:LatexBox_split_resize
		silent exe "set columns+=" . l:size
	endif
	silent exe g:LatexBox_split_side l:size . l:type . ' LaTeX\ TOC'

	let b:toc = toc
	let b:toc_numbers = 1
	let b:calling_win = bufwinnr(calling_buf)
	setlocal filetype=latextoc

	" Add TOC entries and jump to the closest section
	for entry in toc
		call append('$', entry['number'] . "\t" . entry['text'])
	endfor
	if !g:LatexBox_toc_hidehelp
		call append('$', "")
		call append('$', "<Esc>/q: close")
		call append('$', "<Space>: jump")
		call append('$', "<Enter>: jump and close")
		call append('$', "s:       hide numbering")
	endif
	0delete _

	execute 'normal! ' . (closest_index + 1) . 'G'

	" Lock buffer
	setlocal nomodifiable
endfunction

" Binary search for the closest section
" return the index of the TOC entry
function! s:FindClosestSection(toc, fileindices)
	let file = expand('%:p')
	if !has_key(a:fileindices, file)
		return 0
	endif

	let imax = len(a:fileindices[file])
	if imax > 0
		let imin = 0
		while imin < imax - 1
			let i = (imax + imin) / 2
			let tocindex = a:fileindices[file][i]
			let entry = a:toc[tocindex]
			let titlestr = entry['text']
			let titlestr = escape(titlestr, '\')
			let titlestr = substitute(titlestr, ' ', '\\_\\s\\+', 'g')
			let [lnum, cnum] = searchpos('\\' . entry['level'] . '\_\s*{' . titlestr . '}', 'nW')
			if lnum
				let imax = i
			else
				let imin = i
			endif
		endwhile
		return a:fileindices[file][imin]
	else
		return 0
	endif
endfunction

let s:ConvBackPats = map([
			\ ['\\''A}'        , 'Á'],
			\ ['\\`A}'         , 'À'],
			\ ['\\^A}'         , 'À'],
			\ ['\\¨A}'         , 'Ä'],
			\ ['\\"A}'         , 'Ä'],
			\ ['\\''a}'        , 'á'],
			\ ['\\`a}'         , 'à'],
			\ ['\\^a}'         , 'à'],
			\ ['\\¨a}'         , 'ä'],
			\ ['\\"a}'         , 'ä'],
			\ ['\\''E}'        , 'É'],
			\ ['\\`E}'         , 'È'],
			\ ['\\^E}'         , 'Ê'],
			\ ['\\¨E}'         , 'Ë'],
			\ ['\\"E}'         , 'Ë'],
			\ ['\\''e}'        , 'é'],
			\ ['\\`e}'         , 'è'],
			\ ['\\^e}'         , 'ê'],
			\ ['\\¨e}'         , 'ë'],
			\ ['\\"e}'         , 'ë'],
			\ ['\\''I}'        , 'Í'],
			\ ['\\`I}'         , 'Î'],
			\ ['\\^I}'         , 'Ì'],
			\ ['\\¨I}'         , 'Ï'],
			\ ['\\"I}'         , 'Ï'],
			\ ['\\''i}'        , 'í'],
			\ ['\\`i}'         , 'î'],
			\ ['\\^i}'         , 'ì'],
			\ ['\\¨i}'         , 'ï'],
			\ ['\\"i}'         , 'ï'],
			\ ['\\''{\?\\i }'  , 'í'],
			\ ['\\''O}'        , 'Ó'],
			\ ['\\`O}'         , 'Ò'],
			\ ['\\^O}'         , 'Ô'],
			\ ['\\¨O}'         , 'Ö'],
			\ ['\\"O}'         , 'Ö'],
			\ ['\\''o}'        , 'ó'],
			\ ['\\`o}'         , 'ò'],
			\ ['\\^o}'         , 'ô'],
			\ ['\\¨o}'         , 'ö'],
			\ ['\\"o}'         , 'ö'],
			\ ['\\''U}'        , 'Ú'],
			\ ['\\`U}'         , 'Ù'],
			\ ['\\^U}'         , 'Û'],
			\ ['\\¨U}'         , 'Ü'],
			\ ['\\"U}'         , 'Ü'],
			\ ['\\''u}'        , 'ú'],
			\ ['\\`u}'         , 'ù'],
			\ ['\\^u}'         , 'û'],
			\ ['\\¨u}'         , 'ü'],
			\ ['\\"u}'         , 'ü'],
			\ ['\\`N}'         , 'Ǹ'],
			\ ['\\\~N}'        , 'Ñ'],
			\ ['\\''n}'        , 'ń'],
			\ ['\\`n}'         , 'ǹ'],
			\ ['\\\~n}'        , 'ñ'],
			\], '[''\C\(\\IeC\s*{\)\?'' . v:val[0], v:val[1]]')
" }}}

" TOC Command {{{
command! LatexTOC call LatexBox_TOC()
command! LatexTOCToggle call LatexBox_TOC(1)
" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
