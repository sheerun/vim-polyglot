" LaTeX indent file (part of LaTeX Box)
" Maintainer: David Munger (mungerd@gmail.com)

if exists("g:LatexBox_custom_indent") && ! g:LatexBox_custom_indent
	finish
endif
if exists("b:did_indent")
	finish
endif

let b:did_indent = 1

setlocal indentexpr=LatexBox_TexIndent()
setlocal indentkeys=0=\\end,0=\\end{enumerate},0=\\end{itemize},0=\\end{description},0=\\right,0=\\item,0=\\),0=\\],0},o,O,0\\

let s:list_envs = ['itemize', 'enumerate', 'description']
" indent on \left( and on \(, but not on (
" indent on \left[ and on \[, but not on [
" indent on \left\{ and on {, but not on \{
let s:open_pat = '\\\@<!\%(\\begin\|\\left\|\\(\|\\\[\|{\)'
let s:close_pat = '\\\@<!\%(\\end\|\\right\|\\)\|\\\]\|}\)'
let s:list_open_pat = '\\\@<!\\begin{\%(' . join(s:list_envs, '\|') . '\)}'
let s:list_close_pat	= '\\\@<!\\end{\%(' . join(s:list_envs, '\|') . '\)}'

function! s:CountMatches(str, pat)
	return len(substitute(substitute(a:str, a:pat, "\n", 'g'), "[^\n]", '', 'g'))
endfunction


" TexIndent {{{
function! LatexBox_TexIndent()

	let lnum_curr = v:lnum
	let lnum_prev = prevnonblank(lnum_curr - 1)

	if lnum_prev == 0
		return 0
	endif

	let line_curr = getline(lnum_curr)
	let line_prev = getline(lnum_prev)

	" remove \\
	let line_curr = substitute(line_curr, '\\\\', '', 'g')
	let line_prev = substitute(line_prev, '\\\\', '', 'g')

	" strip comments
	let line_curr = substitute(line_curr, '\\\@<!%.*$', '', 'g')
	let line_prev = substitute(line_prev, '\\\@<!%.*$', '', 'g')

	" find unmatched opening patterns on previous line
	let n = s:CountMatches(line_prev, s:open_pat)-s:CountMatches(line_prev, s:close_pat)
	let n += s:CountMatches(line_prev, s:list_open_pat)-s:CountMatches(line_prev, s:list_close_pat)

	" reduce indentation if current line starts with a closing pattern
	if line_curr =~ '^\s*\%(' . s:close_pat . '\)'
		let n -= 1
	endif

	" compensate indentation if previous line starts with a closing pattern
	if line_prev =~ '^\s*\%(' . s:close_pat . '\)'
		let n += 1
	endif

	" reduce indentation if current line starts with a closing list
	if line_curr =~ '^\s*\%(' . s:list_close_pat . '\)'
		let n -= 1
	endif

	" compensate indentation if previous line starts with a closing list
	if line_prev =~ '^\s*\%(' . s:list_close_pat . '\)'
		let n += 1
	endif

	" reduce indentation if previous line is \begin{document}
	if line_prev =~ '\\begin\s*{document}'
		let n -= 1
	endif

	" less shift for lines starting with \item
	let item_here =  line_curr =~ '^\s*\\item'
	let item_above = line_prev =~ '^\s*\\item'
	if !item_here && item_above
		let n += 1
	elseif item_here && !item_above
		let n -= 1
	endif

	return indent(lnum_prev) + n * &sw
endfunction
" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
