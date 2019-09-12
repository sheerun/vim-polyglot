if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'latex') == -1

" LaTeX Box completion

setlocal omnifunc=LatexBox_Complete

" <SID> Wrap {{{
function! s:GetSID()
	return matchstr(expand('<sfile>'), '\zs<SNR>\d\+_\ze.*$')
endfunction
let s:SID = s:GetSID()
function! s:SIDWrap(func)
	return s:SID . a:func
endfunction
" }}}

" Completion {{{
if !exists('g:LatexBox_completion_close_braces')
	let g:LatexBox_completion_close_braces = 1
endif
if !exists('g:LatexBox_bibtex_wild_spaces')
	let g:LatexBox_bibtex_wild_spaces = 1
endif

if !exists('g:LatexBox_cite_pattern')
	let g:LatexBox_cite_pattern = '\C\\\a*cite\a*\*\?\(\[[^\]]*\]\)*\_\s*{'
endif
if !exists('g:LatexBox_ref_pattern')
	let g:LatexBox_ref_pattern = '\C\\v\?\(eq\|page\|[cC]\|labelc\|name\|auto\)\?ref\*\?\_\s*{'
endif

if !exists('g:LatexBox_completion_environments')
	let g:LatexBox_completion_environments = [
		\ {'word': 'itemize',		'menu': 'bullet list' },
		\ {'word': 'enumerate',		'menu': 'numbered list' },
		\ {'word': 'description',	'menu': 'description' },
		\ {'word': 'center',		'menu': 'centered text' },
		\ {'word': 'figure',		'menu': 'floating figure' },
		\ {'word': 'table',			'menu': 'floating table' },
		\ {'word': 'equation',		'menu': 'equation (numbered)' },
		\ {'word': 'align',			'menu': 'aligned equations (numbered)' },
		\ {'word': 'align*',		'menu': 'aligned equations' },
		\ {'word': 'document' },
		\ {'word': 'abstract' },
		\ ]
endif

if !exists('g:LatexBox_completion_commands')
	let g:LatexBox_completion_commands = [
		\ {'word': '\begin{' },
		\ {'word': '\end{' },
		\ {'word': '\item' },
		\ {'word': '\label{' },
		\ {'word': '\ref{' },
		\ {'word': '\eqref{eq:' },
		\ {'word': '\cite{' },
		\ {'word': '\chapter{' },
		\ {'word': '\section{' },
		\ {'word': '\subsection{' },
		\ {'word': '\subsubsection{' },
		\ {'word': '\paragraph{' },
		\ {'word': '\nonumber' },
		\ {'word': '\bibliography' },
		\ {'word': '\bibliographystyle' },
		\ ]
endif

if !exists('g:LatexBox_complete_inlineMath')
	let g:LatexBox_complete_inlineMath = 0
endif

if !exists('g:LatexBox_eq_env_patterns')
	let g:LatexBox_eq_env_patterns = 'equation\|gather\|multiline\|align\|flalign\|alignat\|eqnarray'
endif

" }}}

"LatexBox_kpsewhich {{{
function! LatexBox_kpsewhich(file)
	let old_dir = getcwd()
	execute 'lcd ' . fnameescape(LatexBox_GetTexRoot())
	let out = system('kpsewhich "' . a:file . '"')

	" If kpsewhich has found something, it returns a non-empty string with a
	" newline at the end; otherwise the string is empty
	if len(out)
		" Remove the trailing newline
		let out = fnamemodify(out[:-2], ':p')
	endif

	execute 'lcd ' . fnameescape(old_dir)

	return out
endfunction
"}}}

" Omni Completion {{{

let s:completion_type = ''

function! LatexBox_Complete(findstart, base)
	if a:findstart
		" return the starting position of the word
		let line = getline('.')
		let pos = col('.') - 1
		while pos > 0 && line[pos - 1] !~ '\\\|{'
			let pos -= 1
		endwhile

		let line_start = line[:pos-1]
		if line_start =~ '\m\C\\begin\_\s*{$'
			let s:completion_type = 'begin'
		elseif line_start =~ '\m\C\\end\_\s*{$'
			let s:completion_type = 'end'
		elseif line_start =~ '\m' . g:LatexBox_ref_pattern . '$'
			let s:completion_type = 'ref'
		elseif line_start =~ '\m' . g:LatexBox_cite_pattern . '$'
			let s:completion_type = 'bib'
			" check for multiple citations
			let pos = col('.') - 1
			while pos > 0 && line[pos - 1] !~ '{\|,'
				let pos -= 1
			endwhile
		elseif s:LatexBox_complete_inlineMath_or_not()
			let s:completion_type = 'inlineMath'
			let pos = s:eq_pos
		else
			let s:completion_type = 'command'
			if line[pos - 1] == '\'
				let pos -= 1
			endif
		endif
		return pos
	else
		" return suggestions in an array
		let suggestions = []

		if s:completion_type == 'begin'
			" suggest known environments
			for entry in g:LatexBox_completion_environments
				if entry.word =~ '^' . escape(a:base, '\')
					if g:LatexBox_completion_close_braces && !s:NextCharsMatch('^}')
						" add trailing '}'
						let entry = copy(entry)
						let entry.abbr = entry.word
						let entry.word = entry.word . '}'
					endif
					call add(suggestions, entry)
				endif
			endfor
		elseif s:completion_type == 'end'
			" suggest known environments
			let env = LatexBox_GetCurrentEnvironment()
			if env != ''
				if g:LatexBox_completion_close_braces && !s:NextCharsMatch('^\s*[,}]')
					call add(suggestions, {'word': env . '}', 'abbr': env})
				else
					call add(suggestions, env)
				endif
			endif
		elseif s:completion_type == 'command'
			" suggest known commands
			for entry in g:LatexBox_completion_commands
				if entry.word =~ '^' . escape(a:base, '\')
					" do not display trailing '{'
					if entry.word =~ '{'
						let entry.abbr = entry.word[0:-2]
					endif
					call add(suggestions, entry)
				endif
			endfor
		elseif s:completion_type == 'ref'
			let suggestions = s:CompleteLabels(a:base)
		elseif s:completion_type == 'bib'
			" suggest BibTeX entries
			let suggestions = LatexBox_BibComplete(a:base)
		elseif s:completion_type == 'inlineMath'
			let suggestions = s:LatexBox_inlineMath_completion(a:base)
		endif
		if !has('gui_running')
			redraw!
		endif
		return suggestions
	endif
endfunction
" }}}

" BibTeX search {{{

" find the \bibliography{...} commands
" the optional argument is the file name to be searched

function! s:FindBibData(...)
	if a:0 == 0
		let file = LatexBox_GetMainTexFile()
	else
		let file = a:1
	endif

	if !filereadable(file)
		return []
	endif
	let lines = readfile(file)
	let bibdata_list = []

	"
	" Search for added bibliographies
	"
	let bibliography_cmds = [
				\ '\\bibliography',
				\ '\\addbibresource',
				\ '\\addglobalbib',
				\ '\\addsectionbib',
				\ ]
	for cmd in bibliography_cmds
		let filtered = filter(copy(lines),
					\ 'v:val =~ ''\C' . cmd . '\s*{[^}]\+}''')
		let files = map(filtered,
					\ 'matchstr(v:val, ''\C' . cmd . '\s*{\zs[^}]\+\ze}'')')
		for file in files
			let bibdata_list += map(split(file, ','),
						\ 'fnamemodify(v:val, '':r'')')
		endfor
	endfor

	"
	" Also search included files
	"
	for input in filter(lines,
				\ 'v:val =~ ''\C\\\%(input\|include\)\s*{[^}]\+}''')
		let bibdata_list += s:FindBibData(LatexBox_kpsewhich(
					\ matchstr(input,
						\ '\C\\\%(input\|include\)\s*{\zs[^}]\+\ze}')))
	endfor

	return bibdata_list
endfunction

let s:bstfile = expand('<sfile>:p:h') . '/vimcomplete'

function! LatexBox_BibSearch(regexp)
	let res = []

	" Find data from bib files
	let bibdata = join(s:FindBibData(), ',')
	if bibdata != ''

		" write temporary aux file
		let tmpbase = LatexBox_GetTexRoot() . '/_LatexBox_BibComplete'
		let auxfile = tmpbase . '.aux'
		let bblfile = tmpbase . '.bbl'
		let blgfile = tmpbase . '.blg'

		call writefile(['\citation{*}', '\bibstyle{' . s:bstfile . '}',
					\ '\bibdata{' . bibdata . '}'], auxfile)

		if has('win32')
			let l:old_shellslash = &l:shellslash
			setlocal noshellslash
			call system('cd ' . shellescape(LatexBox_GetTexRoot()) .
						\ ' & bibtex -terse '
						\ . fnamemodify(auxfile, ':t') . ' >nul')
			let &l:shellslash = l:old_shellslash
		else
			call system('cd ' . shellescape(LatexBox_GetTexRoot()) .
						\ ' ; bibtex -terse '
						\ . fnamemodify(auxfile, ':t') . ' >/dev/null')
		endif

		let lines = split(substitute(join(readfile(bblfile), "\n"),
					\ '\n\n\@!\(\s\=\)\s*\|{\|}', '\1', 'g'), "\n")

		for line in filter(lines, 'v:val =~ a:regexp')
			let matches = matchlist(line,
						\ '^\(.*\)||\(.*\)||\(.*\)||\(.*\)||\(.*\)')
			if !empty(matches) && !empty(matches[1])
				let s:type_length = max([s:type_length,
							\ len(matches[2]) + 3])
				call add(res, {
							\ 'key': matches[1],
							\ 'type': matches[2],
							\ 'author': matches[3],
							\ 'year': matches[4],
							\ 'title': matches[5],
							\ })
			endif
		endfor

		call delete(auxfile)
		call delete(bblfile)
		call delete(blgfile)
	endif

	" Find data from 'thebibliography' environments
	let lines = readfile(LatexBox_GetMainTexFile())
	if match(lines, '\C\\begin{thebibliography}') >= 0
		for line in filter(filter(lines, 'v:val =~ ''\C\\bibitem'''),
					\ 'v:val =~ a:regexp')
			let match = matchlist(line, '\\bibitem{\([^}]*\)')[1]
			call add(res, {
						\ 'key': match,
						\ 'type': '',
						\ 'author': '',
						\ 'year': '',
						\ 'title': match,
						\ })
		endfor
	endif

	return res
endfunction
" }}}

" BibTeX completion {{{
let s:type_length=0
function! LatexBox_BibComplete(regexp)

	" treat spaces as '.*' if needed
	if g:LatexBox_bibtex_wild_spaces
		"let regexp = substitute(a:regexp, '\s\+', '.*', 'g')
		let regexp = '.*' . substitute(a:regexp, '\s\+', '\\\&.*', 'g')
	else
		let regexp = a:regexp
	endif

	let res = []
	let s:type_length = 4
	for m in LatexBox_BibSearch(regexp)
		let type = m['type']   == '' ? '[-]' : '[' . m['type']   . '] '
		let type = printf('%-' . s:type_length . 's', type)
		let auth = m['author'] == '' ? ''    :       m['author'][:20] . ' '
		let auth = substitute(auth, '\~', ' ', 'g')
		let auth = substitute(auth, ',.*\ze', ' et al. ', '')
		let year = m['year']   == '' ? ''    : '(' . m['year']   . ')'
		let w = { 'word': m['key'],
				\ 'abbr': type . auth . year,
				\ 'menu': m['title'] }

		" close braces if needed
		if g:LatexBox_completion_close_braces && !s:NextCharsMatch('^\s*[,}]')
			let w.word = w.word . '}'
		endif

		call add(res, w)
	endfor
	return res
endfunction
" }}}

" ExtractLabels {{{
" Generate list of \newlabel commands in current buffer.
"
" Searches the current buffer for commands of the form
"	\newlabel{name}{{number}{page}.*
" and returns list of [ name, number, page ] tuples.
function! s:ExtractLabels()
	call cursor(1,1)

	let matches = []
	let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )

	while [lblline, lblbegin] != [0,0]
		let [nln, nameend] = searchpairpos( '{', '', '}', 'W' )
		if nln != lblline
			let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )
			continue
		endif
		let curname = strpart( getline( lblline ), lblbegin, nameend - lblbegin - 1 )

		" Ignore cref entries (because they are duplicates)
		if curname =~# "@cref$"
		    let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )
			continue
		endif

		if 0 == search( '\m{\w*{', 'ce', lblline )
		    let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )
		    continue
		endif

		let numberbegin = getpos('.')[2]
		let [nln, numberend]  = searchpairpos( '{', '', '}', 'W' )
		if nln != lblline
			let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )
			continue
		endif
		let curnumber = strpart( getline( lblline ), numberbegin, numberend - numberbegin - 1 )

		if 0 == search( '\m\w*{', 'ce', lblline )
		    let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )
		    continue
		endif

		let pagebegin = getpos('.')[2]
		let [nln, pageend]  = searchpairpos( '{', '', '}', 'W' )
		if nln != lblline
			let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )
			continue
		endif
		let curpage = strpart( getline( lblline ), pagebegin, pageend - pagebegin - 1 )

		let matches += [ [ curname, curnumber, curpage ] ]

		let [lblline, lblbegin] = searchpos( '\\newlabel{', 'ecW' )
	endwhile

	return matches
endfunction
"}}}

" ExtractInputs {{{
" Generate list of \@input commands in current buffer.
"
" Searches the current buffer for \@input{file} entries and
" returns list of all files.
function! s:ExtractInputs()
	call cursor(1,1)

	let matches = []
	let [inline, inbegin] = searchpos( '\\@input{', 'ecW' )

	while [inline, inbegin] != [0,0]
		let [nln, inend] = searchpairpos( '{', '', '}', 'W' )
		if nln != inline
			let [inline, inbegin] = searchpos( '\\@input{', 'ecW' )
			continue
		endif
		let matches += [ LatexBox_kpsewhich(strpart( getline( inline ), inbegin, inend - inbegin - 1 )) ]

		let [inline, inbegin] = searchpos( '\\@input{', 'ecW' )
	endwhile

	" Remove empty strings for nonexistant .aux files
	return filter(matches, 'v:val != ""')
endfunction
"}}}

" LabelCache {{{
" Cache of all labels.
"
" LabelCache is a dictionary mapping filenames to tuples
" [ time, labels, inputs ]
" where
" * time is modification time of the cache entry
" * labels is a list like returned by ExtractLabels
" * inputs is a list like returned by ExtractInputs
let s:LabelCache = {}
"}}}

" GetLabelCache {{{
" Extract labels from LabelCache and update it.
"
" Compares modification time of each entry in the label
" cache and updates it, if necessary. During traversal of
" the LabelCache, all current labels are collected and
" returned.
function! s:GetLabelCache(file)
	if !filereadable(a:file)
		return []
	endif

	if !has_key(s:LabelCache , a:file) || s:LabelCache[a:file][0] != getftime(a:file)
		" Open file in temporary split window for label extraction.
		let main_tex_file = LatexBox_GetMainTexFile()
		silent execute '1sp +let\ b:main_tex_file=main_tex_file|let\ labels=s:ExtractLabels()|let\ inputs=s:ExtractInputs()|quit! ' . fnameescape(a:file)
		let s:LabelCache[a:file] = [ getftime(a:file), labels, inputs ]
	endif

	" We need to create a copy of s:LabelCache[fid][1], otherwise all inputs'
	" labels would be added to the current file's label cache upon each
	" completion call, leading to duplicates/triplicates/etc. and decreased
	" performance.
	" Also, because we don't anything with the list besides matching copies,
	" we can get away with a shallow copy for now.
	let labels = copy(s:LabelCache[a:file][1])

	for input in s:LabelCache[a:file][2]
		let labels += s:GetLabelCache(input)
	endfor

	return labels
endfunction
"}}}

" Complete Labels {{{
function! s:CompleteLabels(regex)
	let labels = s:GetLabelCache(LatexBox_GetAuxFile())

	let matches = filter( copy(labels), 'match(v:val[0], "' . a:regex . '") != -1' )
	if empty(matches)
		" also try to match label and number
		let regex_split = split(a:regex)
		if len(regex_split) > 1
			let base = regex_split[0]
			let number = escape(join(regex_split[1:], ' '), '.')
			let matches = filter( copy(labels), 'match(v:val[0], "' . base . '") != -1 && match(v:val[1], "' . number . '") != -1' )
		endif
	endif
	if empty(matches)
		" also try to match number
		let matches = filter( copy(labels), 'match(v:val[1], "' . a:regex . '") != -1' )
	endif

	let suggestions = []
	for m in matches
		let entry = {'word': m[0], 'menu': printf("%7s [p. %s]", '('.m[1].')', m[2])}
		if g:LatexBox_completion_close_braces && !s:NextCharsMatch('^\s*[,}]')
			" add trailing '}'
			let entry = copy(entry)
			let entry.abbr = entry.word
			let entry.word = entry.word . '}'
		endif
		call add(suggestions, entry)
	endfor

	return suggestions
endfunction
" }}}

" Complete Inline Math Or Not {{{
" Return 1, when cursor is in a math env:
" 	1, there is a single $ in the current line on the left of cursor
" 	2, there is an open-eq-env on/above the current line
" 		(open-eq-env : \(, \[, and \begin{eq-env} )
" Return 0, when cursor is not in a math env
function! s:LatexBox_complete_inlineMath_or_not()

	" switch of inline math completion feature
	if g:LatexBox_complete_inlineMath == 0
		return 0
	endif

    " env names that can't appear in an eq env
	if !exists('s:LatexBox_doc_structure_patterns')
		let s:LatexBox_doc_structure_patterns = '\%(' .  '\\begin\s*{document}\|' .
					\ '\\\%(chapter\|section\|subsection\|subsubsection\)\*\?\s*{' . '\)'
	endif

	if !exists('s:LatexBox_eq_env_open_patterns')
		let s:LatexBox_eq_env_open_patterns = ['\\(','\\\[']
	endif
	if !exists('s:LatexBox_eq_env_close_patterns')
		let s:LatexBox_eq_env_close_patterns = ['\\)','\\\]']
	endif

	let notcomment = '\%(\%(\\\@<!\%(\\\\\)*\)\@<=%.*\)\@<!'

	let lnum_saved = line('.')
    let cnum_saved = col('.') -1

    let line = getline('.')
	let line_start_2_cnum_saved = line[:cnum_saved]

	" determine whether there is a single $ before cursor
	let cursor_dollar_pair = 0
	while matchend(line_start_2_cnum_saved, '\$[^$]\+\$', cursor_dollar_pair) >= 0
		" find the end of dollar pair
		let cursor_dollar_pair = matchend(line_start_2_cnum_saved, '\$[^$]\+\$', cursor_dollar_pair)
	endwhile
	" find single $ after cursor_dollar_pair
	let cursor_single_dollar = matchend(line_start_2_cnum_saved, '\$', cursor_dollar_pair)

	" if single $ is found
	if cursor_single_dollar >= 0
		" check whether $ is in \(...\), \[...\], or \begin{eq}...\end{eq}

		" check current line,
		" search for LatexBox_eq_env_close_patterns: \[ and \(
		let lnum = line('.')
		for i in range(0, (len(s:LatexBox_eq_env_open_patterns)-1))
			call cursor(lnum_saved, cnum_saved)
			let cnum_close = searchpos(''. s:LatexBox_eq_env_close_patterns[i].'', 'cbW', lnum_saved)[1]
			let cnum_open = matchend(line_start_2_cnum_saved, s:LatexBox_eq_env_open_patterns[i], cnum_close)
			if cnum_open >= 0
				let s:eq_dollar_parenthesis_bracket_empty = ''
				let s:eq_pos = cursor_single_dollar - 1
				return 1
			end
		endfor

		" check the lines above
		" search for s:LatexBox_doc_structure_patterns, and end-of-math-env
		let lnum -= 1
		while lnum > 0
			let line = getline(lnum)
			if line =~ notcomment . '\(' . s:LatexBox_doc_structure_patterns .
						\ '\|' . '\\end\s*{\(' . g:LatexBox_eq_env_patterns . '\)\*\?}\)'
				" when s:LatexBox_doc_structure_patterns or g:LatexBox_eq_env_patterns
				" are found first, complete math, leave with $ at both sides
				let s:eq_dollar_parenthesis_bracket_empty = '$'
				let s:eq_pos = cursor_single_dollar
				break
			elseif line =~ notcomment . '\\begin\s*{\(' . g:LatexBox_eq_env_patterns . '\)\*\?}'
				" g:LatexBox_eq_env_patterns is found, complete math, remove $
				let s:eq_dollar_parenthesis_bracket_empty = ''
				let s:eq_pos = cursor_single_dollar - 1
				break
			endif
			let lnum -= 1
		endwhile

		return 1
	else
		" no $ is found, then search for \( or \[ in current line
		" 1, whether there is \(
		call cursor(lnum_saved, cnum_saved)
		let cnum_parenthesis_close = searchpos('\\)', 'cbW', lnum_saved)[1]
		let cnum_parenthesis_open = matchend(line_start_2_cnum_saved, '\\(', cnum_parenthesis_close)
		if cnum_parenthesis_open >= 0
			let s:eq_dollar_parenthesis_bracket_empty = '\)'
			let s:eq_pos = cnum_parenthesis_open
			return 1
		end

		" 2, whether there is \[
		call cursor(lnum_saved, cnum_saved)
		let cnum_bracket_close = searchpos('\\\]', 'cbW', lnum_saved)[1]
		let cnum_bracket_open = matchend(line_start_2_cnum_saved, '\\\[', cnum_bracket_close)
		if cnum_bracket_open >= 0
			let s:eq_dollar_parenthesis_bracket_empty = '\]'
			let s:eq_pos = cnum_bracket_open
			return 1
		end

		" not inline math completion
		return 0
	endif

endfunction
" }}}

" Complete inline euqation{{{
function! s:LatexBox_inlineMath_completion(regex, ...)

	if a:0 == 0
		let file = LatexBox_GetMainTexFile()
	else
		let file = a:1
	endif

	if empty(glob(file, 1))
		return ''
	endif

	if empty(s:eq_dollar_parenthesis_bracket_empty)
		let inline_pattern1 = '\$\s*\(' . escape(substitute(a:regex[1:], '^\s\+', '', ""), '\.*^') . '[^$]*\)\s*\$'
		let inline_pattern2 = '\\(\s*\(' . escape(substitute(a:regex[1:], '^\s\+', '', ""), '\.*^') . '.*\)\s*\\)'
	else
		let inline_pattern1 = '\$\s*\(' . escape(substitute(a:regex, '^\s\+', '', ""), '\.*^') . '[^$]*\)\s*\$'
		let inline_pattern2 = '\\(\s*\(' . escape(substitute(a:regex, '^\s\+', '', ""), '\.*^') . '.*\)\s*\\)'
	endif


	let suggestions = []
	let line_num = 0
	for line in readfile(file)
		let line_num = line_num + 1

		let suggestions += s:LatexBox_inlineMath_mathlist(line,inline_pattern1 , line_num) +  s:LatexBox_inlineMath_mathlist( line,inline_pattern2, line_num)

 		" search for included files
 		let included_file = matchstr(line, '^\\@input{\zs[^}]*\ze}')
 		if included_file != ''
 			let included_file = LatexBox_kpsewhich(included_file)
 			call extend(suggestions, s:LatexBox_inlineMath_completion(a:regex, included_file))
 		endif
 	endfor

	return suggestions
endfunction
" }}}

" Search for inline maths {{{
" search for $ ... $ and \( ... \) in each line
function! s:LatexBox_inlineMath_mathlist(line,inline_pattern, line_num)
	let col_start = 0
	let suggestions = []
	while 1
		let matches = matchlist(a:line, a:inline_pattern, col_start)
		if !empty(matches)

			" show line number of inline math
			let entry = {'word': matches[1], 'menu': '[' . a:line_num . ']'}

            if  s:eq_dollar_parenthesis_bracket_empty != ''
                let entry = copy(entry)
                let entry.abbr = entry.word
                let entry.word = entry.word . s:eq_dollar_parenthesis_bracket_empty
            endif
			call add(suggestions, entry)

			" update col_start
			let col_start = matchend(a:line, a:inline_pattern, col_start)
		else
			break
		endif
	endwhile

	return suggestions
endfunction
" }}}

" Close Current Environment {{{
function! s:CloseCurEnv()
	" first, try with \left/\right pairs
	let [lnum, cnum] = searchpairpos('\C\\left\>', '', '\C\\right\>', 'bnW', 'LatexBox_InComment()')
	if lnum
		let line = strpart(getline(lnum), cnum - 1)
		let bracket = matchstr(line, '^\\left\zs\((\|\[\|\\{\||\|\.\)\ze')
		for [open, close] in [['(', ')'], ['\[', '\]'], ['\\{', '\\}'], ['|', '|'], ['\.', '|']]
			let bracket = substitute(bracket, open, close, 'g')
		endfor
		return '\right' . bracket
	endif

	" second, try with environments
	let env = LatexBox_GetCurrentEnvironment()
	if env == '\['
		return '\]'
	elseif env == '\('
		return '\)'
	elseif env != ''
		return '\end{' . env . '}'
	endif
	return ''
endfunction
" }}}

" Wrap Selection {{{
function! s:WrapSelection(wrapper)
	keepjumps normal! `>a}
	execute 'keepjumps normal! `<i\' . a:wrapper . '{'
endfunction
" }}}

" Wrap Selection in Environment with Prompt {{{
function! s:PromptEnvWrapSelection(...)
	let env = input('environment: ', '', 'customlist,' . s:SIDWrap('GetEnvironmentList'))
	if empty(env)
		return
	endif
	" LaTeXBox's custom indentation can interfere with environment
	" insertion when environments are indented (common for nested
	" environments).  Temporarily disable it for this operation:
	let ieOld = &indentexpr
	setlocal indentexpr=""
	if visualmode() ==# 'V'
		execute 'keepjumps normal! `>o\end{' . env . '}'
		execute 'keepjumps normal! `<O\begin{' . env . '}'
		" indent and format, if requested.
		if a:0 && a:1
			normal! gv>
			normal! gvgq
		endif
	else
		execute 'keepjumps normal! `>a\end{' . env . '}'
		execute 'keepjumps normal! `<i\begin{' . env . '}'
	endif
	exe "setlocal indentexpr=" . ieOld
endfunction
" }}}

" List Labels with Prompt {{{
function! s:PromptLabelList(...)
	" Check if window already exists
	let winnr = bufwinnr(bufnr('LaTeX Labels'))
	if winnr >= 0
		if a:0 == 0
			silent execute winnr . 'wincmd w'
		else
			" Supplying an argument to this function causes toggling instead
			" of jumping to the labels window
			if g:LatexBox_split_resize
				silent exe "set columns-=" . g:LatexBox_split_width
			endif
			silent execute 'bwipeout' . bufnr('LaTeX Labels')
		endif
		return
	endif

	" Get label suggestions
	let regexp = input('filter labels with regexp: ', '')
	let labels = s:CompleteLabels(regexp)

	let calling_buf = bufnr('%')

	" Create labels window and set local settings
	if g:LatexBox_split_resize
		silent exe "set columns+=" . g:LatexBox_split_width
	endif
	silent exe g:LatexBox_split_side g:LatexBox_split_width . 'vnew LaTeX\ Labels'
	let b:toc = []
	let b:toc_numbers = 1
	let b:calling_win = bufwinnr(calling_buf)
	setlocal filetype=latextoc

	" Add label entries and jump to the closest section
	for entry in labels
		let number = matchstr(entry['menu'], '^\s*(\zs[^)]\+\ze)')
		let page = matchstr(entry['menu'], '^[^)]*)\s*\[\zs[^]]\+\ze\]')
		let e = {'file': bufname(calling_buf),
					\ 'level': 'label',
					\ 'number': number,
					\ 'text': entry['abbr'],
					\ 'page': page}
		call add(b:toc, e)
		if b:toc_numbers
			call append('$', e['number'] . "\t" . e['text'])
		else
			call append('$', e['text'])
		endif
	endfor
	if !g:LatexBox_toc_hidehelp
		call append('$', "")
		call append('$', "<Esc>/q: close")
		call append('$', "<Space>: jump")
		call append('$', "<Enter>: jump and close")
		call append('$', "s:       hide numbering")
	endif
	0delete _

	" Lock buffer
	setlocal nomodifiable
endfunction
" }}}

" Change Environment {{{
function! s:ChangeEnvPrompt()

	let [env, lnum, cnum, lnum2, cnum2] = LatexBox_GetCurrentEnvironment(1)

	let new_env = input('change ' . env . ' for: ', '', 'customlist,' . s:SIDWrap('GetEnvironmentList'))
	if empty(new_env)
		return
	endif

	if new_env == '\[' || new_env == '['
		let begin = '\['
		let end = '\]'
	elseif new_env == '\(' || new_env == '('
		let begin = '\('
		let end = '\)'
	else
		let l:begin = '\begin{' . new_env . '}'
		let l:end = '\end{' . new_env . '}'
	endif

	if env == '\[' || env == '\('
		let line = getline(lnum2)
		let line = strpart(line, 0, cnum2 - 1) . l:end . strpart(line, cnum2 + 1)
		call setline(lnum2, line)

		let line = getline(lnum)
		let line = strpart(line, 0, cnum - 1) . l:begin . strpart(line, cnum + 1)
		call setline(lnum, line)
	else
		let line = getline(lnum2)
		let line = strpart(line, 0, cnum2 - 1) . l:end . strpart(line, cnum2 + len(env) + 5)
		call setline(lnum2, line)

		let line = getline(lnum)
		let line = strpart(line, 0, cnum - 1) . l:begin . strpart(line, cnum + len(env) + 7)
		call setline(lnum, line)
	endif
endfunction

function! s:GetEnvironmentList(lead, cmdline, pos)
	let suggestions = []
	for entry in g:LatexBox_completion_environments
		let env = entry.word
		if env =~ '^' . a:lead
			call add(suggestions, env)
		endif
	endfor
	return suggestions
endfunction

function! s:LatexToggleStarEnv()
	let [env, lnum, cnum, lnum2, cnum2] = LatexBox_GetCurrentEnvironment(1)

	if env == '\('
		return
	elseif env == '\['
		let begin = '\begin{equation}'
		let end = '\end{equation}'
	elseif env[-1:] == '*'
		let begin = '\begin{' . env[:-2] . '}'
		let end   = '\end{'   . env[:-2] . '}'
	else
		let begin = '\begin{' . env . '*}'
		let end   = '\end{'   . env . '*}'
	endif

	if env == '\['
		let line = getline(lnum2)
		let line = strpart(line, 0, cnum2 - 1) . l:end . strpart(line, cnum2 + 1)
		call setline(lnum2, line)

		let line = getline(lnum)
		let line = strpart(line, 0, cnum - 1) . l:begin . strpart(line, cnum + 1)
		call setline(lnum, line)
	else
		let line = getline(lnum2)
		let line = strpart(line, 0, cnum2 - 1) . l:end . strpart(line, cnum2 + len(env) + 5)
		call setline(lnum2, line)

		let line = getline(lnum)
		let line = strpart(line, 0, cnum - 1) . l:begin . strpart(line, cnum + len(env) + 7)
		call setline(lnum, line)
	endif
endfunction
" }}}

" Next Charaters Match {{{
function! s:NextCharsMatch(regex)
	let rest_of_line = strpart(getline('.'), col('.') - 1)
	return rest_of_line =~ a:regex
endfunction
" }}}

" Mappings {{{
inoremap <silent> <Plug>LatexCloseCurEnv			<C-R>=<SID>CloseCurEnv()<CR>
vnoremap <silent> <Plug>LatexWrapSelection			:<c-u>call <SID>WrapSelection('')<CR>i
vnoremap <silent> <Plug>LatexEnvWrapSelection		:<c-u>call <SID>PromptEnvWrapSelection()<CR>
vnoremap <silent> <Plug>LatexEnvWrapFmtSelection	:<c-u>call <SID>PromptEnvWrapSelection(1)<CR>
nnoremap <silent> <Plug>LatexChangeEnv				:call <SID>ChangeEnvPrompt()<CR>
nnoremap <silent> <Plug>LatexToggleStarEnv			:call <SID>LatexToggleStarEnv()<CR>
" }}}

" Commands {{{
command! LatexLabels call <SID>PromptLabelList()
" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4

endif
