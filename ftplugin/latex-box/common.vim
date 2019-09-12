if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

" LaTeX Box common functions

" Error Format {{{
" Note: The error formats assume we're using the -file-line-error with
"       [pdf]latex.
" Note: See |errorformat-LaTeX| for more info.

" Check for options
if !exists("g:LatexBox_show_warnings")
	let g:LatexBox_show_warnings=1
endif
if !exists("g:LatexBox_ignore_warnings")
	let g:LatexBox_ignore_warnings =
				\['Underfull',
				\ 'Overfull',
				\ 'specifier changed to']
endif

" Standard error message formats
" Note: We consider statements that starts with "!" as errors
setlocal efm=%E!\ LaTeX\ %trror:\ %m
setlocal efm+=%E%f:%l:\ %m
setlocal efm+=%E!\ %m

" More info for undefined control sequences
setlocal efm+=%Z<argument>\ %m

" More info for some errors
setlocal efm+=%Cl.%l\ %m

" Show or ignore warnings
if g:LatexBox_show_warnings
	" Parse biblatex warnings
	setlocal efm+=%-C(biblatex)%.%#in\ t%.%#
	setlocal efm+=%-C(biblatex)%.%#Please\ v%.%#
	setlocal efm+=%-C(biblatex)%.%#LaTeX\ a%.%#
	setlocal efm+=%-Z(biblatex)%m

	" Parse hyperref warnings
	setlocal efm+=%-C(hyperref)%.%#on\ input\ line\ %l.

	for w in g:LatexBox_ignore_warnings
		let warning = escape(substitute(w, '[\,]', '%\\\\&', 'g'), ' ')
		exe 'setlocal efm+=%-G%.%#'. warning .'%.%#'
	endfor
	setlocal efm+=%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#
	setlocal efm+=%+W%.%#\ at\ lines\ %l--%*\\d
	setlocal efm+=%+WLaTeX\ %.%#Warning:\ %m
	setlocal efm+=%+W%.%#Warning:\ %m
else
	setlocal efm+=%-WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#
	setlocal efm+=%-W%.%#\ at\ lines\ %l--%*\\d
	setlocal efm+=%-WLaTeX\ %.%#Warning:\ %m
	setlocal efm+=%-W%.%#Warning:\ %m
endif

" Push file to file stack
setlocal efm+=%+P**%f
setlocal efm+=%+P**\"%f\"

" Ignore unmatched lines
setlocal efm+=%-G%.%#
" }}}

" Vim Windows {{{

" Type of split, "new" for horiz. "vnew" for vert.
if !exists('g:LatexBox_split_type')
	let g:LatexBox_split_type = "vnew"
endif

" Length of vertical splits
if !exists('g:LatexBox_split_length')
	let g:LatexBox_split_length = 15
endif

" Width of horizontal splits
if !exists('g:LatexBox_split_width')
	let g:LatexBox_split_width = 30
endif

" Where splits appear
if !exists('g:LatexBox_split_side')
	let g:LatexBox_split_side = "aboveleft"
endif

" Resize when split?
if !exists('g:LatexBox_split_resize')
	let g:LatexBox_split_resize = 0
endif

" Toggle help info
if !exists('g:LatexBox_toc_hidehelp')
	let g:LatexBox_toc_hidehelp = 0
endif
" }}}

" Filename utilities {{{
function! LatexBox_GetMainTexFile()

	" 1. check for the b:main_tex_file variable
	if exists('b:main_tex_file') && filereadable(b:main_tex_file)
		return b:main_tex_file
	endif


	" 2. scan the first few lines of the file for root = filename
	for linenum in range(1,5)
		let linecontents = getline(linenum)
		if linecontents =~ 'root\s*='
			" Remove everything but the filename
			let b:main_tex_file = substitute(linecontents,
						\ '.*root\s*=\s*', "", "")
			let b:main_tex_file = substitute(b:main_tex_file, '\s*$', "", "")
			" Prepend current directory if this isn't an absolute path
			if b:main_tex_file !~ '^/'
				let b:main_tex_file = expand('%:p:h') . '/' . b:main_tex_file
			endif
			let b:main_tex_file = fnamemodify(b:main_tex_file, ":p")
			if b:main_tex_file !~ '\.tex$'
				let b:main_tex_file .= '.tex'
			endif
			return b:main_tex_file
		endif
	endfor

	" 3. scan current file for "\begin{document}"
	if &filetype == 'tex' && search('\m\C\\begin\_\s*{document}', 'nw') != 0
		return expand('%:p')
	endif

	" 4. use 'main.tex' if it exists in the same directory (and is readable)
	let s:main_dot_tex_file=expand('%:p:h') . '/main.tex'
	if filereadable(s:main_dot_tex_file)
		let b:main_tex_file=s:main_dot_tex_file
		return b:main_tex_file
	endif

	" 5. borrow the Vim-Latex-Suite method of finding it
	if LatexBox_GetMainFileName() != expand('%:p')
		let b:main_tex_file = LatexBox_GetMainFileName()
		return b:main_tex_file
	endif

	" 6. prompt for file with completion
	let b:main_tex_file = s:PromptForMainFile()
	return b:main_tex_file
endfunction

function! s:PromptForMainFile()
	let saved_dir = getcwd()
	execute 'cd ' . fnameescape(expand('%:p:h'))

	" Prompt for file
	let l:file = ''
	while !filereadable(l:file)
		let l:file = input('main LaTeX file: ', '', 'file')
		if l:file !~ '\.tex$'
			let l:file .= '.tex'
		endif
	endwhile
	let l:file = fnamemodify(l:file, ':p')

	" Make persistent
	let l:persistent = ''
	while l:persistent !~ '\v^(y|n)'
		let l:persistent = input('make choice persistent? (y, n) ')
		if l:persistent == 'y'
			call writefile([], l:file . '.latexmain')
		endif
	endwhile

	execute 'cd ' . fnameescape(saved_dir)
	return l:file
endfunction

" Return the directory of the main tex file
function! LatexBox_GetTexRoot()
	return fnamemodify(LatexBox_GetMainTexFile(), ':h')
endfunction

function! LatexBox_GetBuildBasename(with_dir)
	" 1. Check for g:LatexBox_jobname
	if exists('g:LatexBox_jobname')
		return g:LatexBox_jobname
	endif

	" 2. Get the basename from the main tex file
	if a:with_dir
		return fnamemodify(LatexBox_GetMainTexFile(), ':r')
	else
		return fnamemodify(LatexBox_GetMainTexFile(), ':t:r')
	endif
endfunction

function! LatexBox_GetAuxFile()
	" 1. check for b:build_dir variable
	if exists('b:build_dir') && isdirectory(b:build_dir)
		return b:build_dir . '/' . LatexBox_GetBuildBasename(0) . '.aux'
	endif

	" 2. check for g:LatexBox_build_dir variable
	if exists('g:LatexBox_build_dir') && isdirectory(g:LatexBox_build_dir)
		return g:LatexBox_build_dir . '/' . LatexBox_GetBuildBasename(0) . '.aux'
	endif

	" 3. use the base name of main tex file
	return LatexBox_GetBuildBasename(1) . '.aux'
endfunction

function! LatexBox_GetLogFile()
	" 1. check for b:build_dir variable
	if exists('b:build_dir') && isdirectory(b:build_dir)
		return b:build_dir . '/' . LatexBox_GetBuildBasename(0) . '.log'
	endif

	" 2. check for g:LatexBox_build_dir variable
	if exists('g:LatexBox_build_dir') && isdirectory(g:LatexBox_build_dir)
		return g:LatexBox_build_dir . '/' . LatexBox_GetBuildBasename(0) . '.log'
	endif

	" 3. use the base name of main tex file
	return LatexBox_GetBuildBasename(1) . '.log'
endfunction

function! LatexBox_GetOutputFile()
	" 1. check for b:build_dir variable
	if exists('b:build_dir') && isdirectory(b:build_dir)
		return b:build_dir . '/' . LatexBox_GetBuildBasename(0)
					\ . '.' . g:LatexBox_output_type
	endif

	" 2. check for g:LatexBox_build_dir variable
	if exists('g:LatexBox_build_dir') && isdirectory(g:LatexBox_build_dir)
		return g:LatexBox_build_dir . '/' . LatexBox_GetBuildBasename(0)
					\ . '.' . g:LatexBox_output_type
	endif

	" 3. use the base name of main tex file
	return LatexBox_GetBuildBasename(1) . '.' . g:LatexBox_output_type
endfunction
" }}}

" View Output {{{

" Default pdf viewer
if !exists('g:LatexBox_viewer')
	" On windows, 'running' a file will open it with the default program
	let s:viewer = ''
	if has('unix')
	  " echo -n necessary as uname -s will append \n otherwise
      let s:uname = system('echo -n $(uname -s)')
	  if s:uname == "Darwin"
		  let s:viewer = 'open'
	  else
		  let s:viewer = 'xdg-open'
	  endif
	endif
	let g:LatexBox_viewer = s:viewer
endif

function! LatexBox_View(...)
	let lvargs = join(a:000, ' ')
	let outfile = LatexBox_GetOutputFile()
	if !filereadable(outfile)
		echomsg fnamemodify(outfile, ':.') . ' is not readable'
		return
	endif
	let cmd = g:LatexBox_viewer . ' ' . lvargs . ' ' . shellescape(outfile)
	if has('win32')
		let cmd = '!start /b ' . cmd . ' >nul'
	else
		let cmd = '!' . cmd . ' '
		if fnamemodify(&shell, ':t') ==# 'fish'
			let cmd .= ' >/dev/null ^/dev/null &'
		else
			let cmd .= ' &>/dev/null &'
		endif
	endif
	silent execute cmd
	if !has("gui_running")
		redraw!
	endif
endfunction

command! -nargs=* LatexView call LatexBox_View('<args>')
" }}}

" In Comment {{{

" LatexBox_InComment([line], [col])
" return true if inside comment
function! LatexBox_InComment(...)
	let line = a:0 >= 1 ? a:1 : line('.')
	let col = a:0 >= 2 ? a:2 : col('.')
	return synIDattr(synID(line, col, 0), "name") =~# '^texComment'
endfunction
" }}}

" Get Current Environment {{{

" LatexBox_GetCurrentEnvironment([with_pos])
" Returns:
" - environment
"	  if with_pos is not given
" - [envirnoment, lnum_begin, cnum_begin, lnum_end, cnum_end]
"	  if with_pos is nonzero
function! LatexBox_GetCurrentEnvironment(...)
	if a:0 > 0
		let with_pos = a:1
	else
		let with_pos = 0
	endif

	let begin_pat = '\C\\begin\_\s*{[^}]*}\|\\\@<!\\\[\|\\\@<!\\('
	let end_pat = '\C\\end\_\s*{[^}]*}\|\\\@<!\\\]\|\\\@<!\\)'
	let saved_pos = getpos('.')

	" move to the left until on a backslash
	let [bufnum, lnum, cnum, off] = getpos('.')
	let line = getline(lnum)
	while cnum > 1 && line[cnum - 1] != '\'
		let cnum -= 1
	endwhile
	call cursor(lnum, cnum)

	" match begin/end pairs but skip comments
	let flags = 'bnW'
	if strpart(getline('.'), col('.') - 1) =~ '^\%(' . begin_pat . '\)'
		let flags .= 'c'
	endif
	let [lnum1, cnum1] = searchpairpos(begin_pat, '', end_pat, flags,
				\ 'LatexBox_InComment()')

	let env = ''

	if lnum1
		let line = strpart(getline(lnum1), cnum1 - 1)

		if empty(env)
			let env = matchstr(line, '^\C\\begin\_\s*{\zs[^}]*\ze}')
		endif
		if empty(env)
			let env = matchstr(line, '^\\\[')
		endif
		if empty(env)
			let env = matchstr(line, '^\\(')
		endif
	endif

	if with_pos == 1
		let flags = 'nW'
		if !(lnum1 == lnum && cnum1 == cnum)
			let flags .= 'c'
		endif

		let [lnum2, cnum2] = searchpairpos(begin_pat, '', end_pat, flags,
					\ 'LatexBox_InComment()')

		call setpos('.', saved_pos)
		return [env, lnum1, cnum1, lnum2, cnum2]
	else
		call setpos('.', saved_pos)
		return env
	endif
endfunction
" }}}

" Tex To Tree {{{
" stores nested braces in a tree structure
function! LatexBox_TexToTree(str)
	let tree = []
	let i1 = 0
	let i2 = -1
	let depth = 0
	while i2 < len(a:str)
		let i2 = match(a:str, '[{}]', i2 + 1)
		if i2 < 0
			let i2 = len(a:str)
		endif
		if i2 >= len(a:str) || a:str[i2] == '{'
			if depth == 0
				let item = substitute(strpart(a:str, i1, i2 - i1),
							\ '^\s*\|\s*$', '', 'g')
				if !empty(item)
					call add(tree, item)
				endif
				let i1 = i2 + 1
			endif
			let depth += 1
		else
			let depth -= 1
			if depth == 0
				call add(tree, LatexBox_TexToTree(strpart(a:str, i1, i2 - i1)))
				let i1 = i2 + 1
			endif
		endif
	endwhile
	return tree
endfunction
" }}}

" Tree To Tex {{{
function! LatexBox_TreeToTex(tree)
	if type(a:tree) == type('')
		return a:tree
	else
		return '{' . join(map(a:tree, 'LatexBox_TreeToTex(v:val)'), '') . '}'
	endif
endfunction
" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4

endif
