" ==============================================================================
" History: This was originally part of auctex.vim by Carl Mueller.
"          Srinath Avadhanula incorporated it into latex-suite with
"          significant modifications.
"          Parts of this file may be copyrighted by others as noted.
" Description:
" 	This ftplugin provides the following maps:
" . <M-b> encloses the previous character in \mathbf{}
" . <M-c> is polymorphic as follows:
"     Insert mode:
"     1. If the previous character is a letter or number, then capitalize it and
"        enclose it in \mathcal{}
"     2. otherwise insert \cite{}
"     Visual Mode:
"     1. Enclose selection in \mathcal{}
" . <M-l> is also polymorphic as follows:
"     If the character before typing <M-l> is one of '([{|<q', then do the
"     following:
"       1. (<M-l>       \left(\right
"               similarly for [, |
"          {<M-l>       \left\{\right\}
"       2. <<M-l>       \langle\rangle
"       3. q<M-l>       \lefteqn{}
"     otherwise insert  \label{}
" . <M-i> inserts \item commands at the current cursor location depending on
"       the surrounding environment. For example, inside itemize, it will
"       insert a simple \item, but within a description, it will insert
"       \item[<+label+>] etc.
" 
" These functions make it extremeley easy to do all the \left \right stuff in
" latex.
" ============================================================================== 

" Avoid reinclusion.
if exists('b:did_brackets')
	finish
endif
let b:did_brackets = 1

" define the funtions only once.
if exists('*Tex_MathBF')
	finish
endif

" Tex_MathBF: encloses te previous letter/number in \mathbf{} {{{
" Description: 
function! Tex_MathBF()
	return "\<Left>\\mathbf{\<Right>}"
endfunction " }}}
" Tex_MathCal: enclose the previous letter/number in \mathcal {{{
" Description:
" 	if the last character is not a letter/number, then insert \cite{}
function! Tex_MathCal()
	let line = getline(line("."))
	let char = line[col(".")-2]

	if char =~ '[a-zA-Z0-9]'
		return "\<BS>".'\mathcal{'.toupper(char).'}'
	else
		return IMAP_PutTextWithMovement('\cite{<++>}<++>')
	endif
endfunction
" }}}
" Tex_LeftRight: maps <M-l> in insert mode. {{{
" Description:
" This is a polymorphic function, which maps the behaviour of <M-l> in the
" following way:
" If the character before typing <M-l> is one of '([{|<q', then do the
" following:
" 	1. (<M-l>		\left(<++>\right<++>
" 	    	similarly for [, |
" 	   {<M-l>		\left\{<++>\right\}<++>
" 	2. <<M-l>		\langle<++>\rangle<++>
" 	3. q<M-l>		\lefteqn{<++>}<++>
" otherwise insert  \label{<++>}<++>
function! Tex_LeftRight()
	let line = getline(line("."))
	let char = line[col(".")-2]
	let previous = line[col(".")-3]

	let matchedbrackets = '()[]{}||'
	if char =~ '(\|\[\|{\||'
		let add = ''
		if char =~ '{'
			let add = "\\"
		endif
		let rhs = matchstr(matchedbrackets, char.'\zs.\ze')
		return "\<BS>".IMAP_PutTextWithMovement('\left'.add.char.'<++>\right'.add.rhs.'<++>')
	elseif char == '<'
		return "\<BS>".IMAP_PutTextWithMovement('\langle <++>\rangle<++>')
	elseif char == 'q'
		return "\<BS>".IMAP_PutTextWithMovement('\lefteqn{<++>}<++>')
	else
		return IMAP_PutTextWithMovement('\label{<++>}<++>')
	endif
endfunction " }}}
" Tex_PutLeftRight: maps <M-l> in normal mode {{{
" Description:
" Put \left...\right in front of the matched brackets.
function! Tex_PutLeftRight()
	let previous = getline(line("."))[col(".") - 2]
	let char = getline(line("."))[col(".") - 1]
	if previous == '\'
		if char == '{'
			exe "normal ileft\\\<Esc>l%iright\\\<Esc>l%"
		elseif char == '}'
			exe "normal iright\\\<Esc>l%ileft\\\<Esc>l%"
		endif
	elseif char =~ '\[\|('
		exe "normal i\\left\<Esc>l%i\\right\<Esc>l%"
	elseif char =~ '\]\|)'
		exe "normal i\\right\<Esc>l%i\\left\<Esc>l%"
	endif
endfunction " }}}

" Provide <plug>'d mapping for easy user customization. {{{
inoremap <silent> <Plug>Tex_MathBF      <C-r>=Tex_MathBF()<CR>
inoremap <silent> <Plug>Tex_MathCal     <C-r>=Tex_MathCal()<CR>
inoremap <silent> <Plug>Tex_LeftRight   <C-r>=Tex_LeftRight()<CR>
vnoremap <silent> <Plug>Tex_MathBF		<C-C>`>a}<Esc>`<i\mathbf{<Esc>
vnoremap <silent> <Plug>Tex_MathCal		<C-C>`>a}<Esc>`<i\mathcal{<Esc>
nnoremap <silent> <Plug>Tex_LeftRight	:call Tex_PutLeftRight()<CR>

" }}}
" Tex_SetBracketingMaps: create mappings for the current buffer {{{
function! <SID>Tex_SetBracketingMaps()

	call Tex_MakeMap('<M-b>', '<Plug>Tex_MathBF', 'i', '<buffer> <silent>')
	call Tex_MakeMap('<M-c>', '<Plug>Tex_MathCal', 'i', '<buffer> <silent>')
	call Tex_MakeMap('<M-l>', '<Plug>Tex_LeftRight', 'i', '<buffer> <silent>')
	call Tex_MakeMap('<M-b>', '<Plug>Tex_MathBF', 'v', '<buffer> <silent>')
	call Tex_MakeMap('<M-c>', '<Plug>Tex_MathCal', 'v', '<buffer> <silent>')
	call Tex_MakeMap('<M-l>', '<Plug>Tex_LeftRight', 'n', '<buffer> <silent>')

endfunction
" }}}

augroup LatexSuite
	au LatexSuite User LatexSuiteFileType 
		\ call Tex_Debug('brackets.vim: Catching LatexSuiteFileType event', 'brak') | 
		\ call <SID>Tex_SetBracketingMaps()
augroup END

" vim:fdm=marker
