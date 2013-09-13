"=============================================================================
" 	     File: folding.vim
"      Author: Srinath Avadhanula
"      		   modifications/additions by Zhang Linbo
"     Created: Tue Apr 23 05:00 PM 2002 PST
" 
"  Description: functions to interact with Syntaxfolds.vim
"=============================================================================

nnoremap <unique> <Plug>Tex_RefreshFolds :call MakeTexFolds(1)<cr>

augroup LatexSuite
	au LatexSuite User LatexSuiteFileType 
		\ call Tex_Debug('folding.vim: catching LatexSuiteFileType', 'fold') | 
		\ call Tex_SetFoldOptions()
augroup END

" Tex_SetFoldOptions: sets maps for every buffer {{{
" Description: 
function! Tex_SetFoldOptions()
	if exists('b:doneSetFoldOptions')
		return
	endif
	let b:doneSetFoldOptions = 1

	setlocal foldtext=TexFoldTextFunction()

	if g:Tex_Folding && g:Tex_AutoFolding
		call MakeTexFolds(0)
	endif

	let s:ml = '<Leader>'

	call Tex_MakeMap(s:ml."rf", "<Plug>Tex_RefreshFolds", 'n', '<silent> <buffer>')

endfunction " }}}
" Tex_FoldSections: creates section folds {{{
" Author: Zhang Linbo
" Description:
" 	This function takes a comma seperated list of "sections" and creates fold
" 	definitions for them. The first item is supposed to be the "shallowest" field
" 	and the last is the "deepest". See g:Tex_FoldedSections for the default
" 	definition of the lst input argument.
"
" 	**works recursively**
function! Tex_FoldSections(lst, endpat)
	let i = match(a:lst, ',')
	if i > 0
		let s = strpart(a:lst, 0, i)
	else
		let s = a:lst
	endif
	if s =~ '%%fakesection'
		let s = '^\s*' . s
	else
		let pattern = ''
		let prefix = ''
		for label in split(s, "|")
			let pattern .= prefix . '^\s*\\' . label . '\W\|^\s*%%fake' . label
			let prefix = '\W\|'
		endfor
		let s = pattern
	endif
	let endpat = s . '\|' . a:endpat
	if i > 0
		call Tex_FoldSections(strpart(a:lst,i+1), endpat)
	endif
	let endpat = '^\s*\\appendix\W\|' . endpat
	call AddSyntaxFoldItem(s, endpat, 0, -1)
endfunction
" }}}
" MakeTexFolds: function to create fold items for latex. {{{
"
" used in conjunction with MakeSyntaxFolds().
" see ../plugin/syntaxFolds.vim for documentation
function! MakeTexFolds(force)
	if exists('g:Tex_Folding') && !g:Tex_Folding
		return
	endif
	if &ft != 'tex'
		return
	end

	" Setup folded items lists g:Tex_Foldedxxxx
	" 	1. Use default value if g:Tex_Foldedxxxxxx is not defined
	" 	2. prepend default value to g:Tex_Foldedxxxxxx if it starts with ','
	" 	3. append default value to g:Tex_Foldedxxxxxx if it ends with ','

	" Folding items which are not caught in any of the standard commands,
	" environments or sections.
	let s = 'item,slide,preamble,<<<'
	if !exists('g:Tex_FoldedMisc')
		let g:Tex_FoldedMisc = s
	elseif g:Tex_FoldedMisc[0] == ','
		let g:Tex_FoldedMisc = s . g:Tex_FoldedMisc
	elseif g:Tex_FoldedMisc =~ ',$'
		let g:Tex_FoldedMisc = g:Tex_FoldedMisc . s
	endif

	" By default do not fold any commands. It looks like trying to fold
	" commands is a difficult problem since commands can be arbitrarily nested
	" and the end patterns are not unique unlike the case of environments.
	" For this to work well, we need a regexp which will match a line only if
	" a command begins on that line but does not end on that line. This
	" requires a regexp which will match unbalanced curly braces and that is
	" apparently not doable with regexps.
	let s = ''
    if !exists('g:Tex_FoldedCommands')
		let g:Tex_FoldedCommands = s
	elseif g:Tex_FoldedCommands[0] == ','
		let g:Tex_FoldedCommands = s . g:Tex_FoldedCommands
	elseif g:Tex_FoldedCommands =~ ',$'
		let g:Tex_FoldedCommands = g:Tex_FoldedCommands . s
	endif

	let s = 'verbatim,comment,eq,gather,align,figure,table,thebibliography,'
			\. 'keywords,abstract,titlepage'
    if !exists('g:Tex_FoldedEnvironments')
		let g:Tex_FoldedEnvironments = s
	elseif g:Tex_FoldedEnvironments[0] == ','
		let g:Tex_FoldedEnvironments = s . g:Tex_FoldedEnvironments
	elseif g:Tex_FoldedEnvironments =~ ',$'
		let g:Tex_FoldedEnvironments = g:Tex_FoldedEnvironments . s
	endif
	
    if !exists('g:Tex_FoldedSections')
		let g:Tex_FoldedSections = 'part,chapter,section,'
								\. 'subsection,subsubsection,paragraph'
	endif

	" the order in which these calls are made decides the nestedness. in
	" latex, a table environment will always be embedded in either an item or
	" a section etc. not the other way around. so we first fold up all the
	" tables. and then proceed with the other regions.

	let b:numFoldItems = 0

	" ========================================================================
	" How to add new folding items {{{
	" ========================================================================
	"
	" Each of the following function calls defines a syntax fold region. Each
	" definition consists of a call to the AddSyntaxFoldItem() function.
	" 
	" The order in which the folds are defined is important. Juggling the
	" order of the function calls will create havoc with folding. The
	" "deepest" folding item needs to be called first. For example, if
	" the \begin{table} environment is a subset (or lies within) the \section
	" environment, then add the definition for the \table first.
	"
	" The AddSyntaxFoldItem() function takes either 4 or 6 arguments. When it
	" is called with 4 arguments, it is equivalent to calling it with 6
	" arguments with the last two left blank (i.e as empty strings)
	"
	" The explanation for each argument is as follows:
	"    startpat: a line matching this pattern defines the beginning of a fold.
	"    endpat  : a line matching this pattern defines the end of a fold.
	"    startoff: this is the offset from the starting line at which folding will
	"              actually start
	"    endoff  : like startoff, but gives the offset of the actual fold end from
	"              the line satisfying endpat.
	"              startoff and endoff are necessary when the folding region does
	"              not have a specific end pattern corresponding to a start
	"              pattern. for example in latex,
	"              \begin{section}
	"              defines the beginning of a section, but its not necessary to
	"              have a corresponding
	"              \end{section}
	"              the section is assumed to end 1 line _before_ another section
	"              starts.
	"    startskip: a pattern which defines the beginning of a "skipped" region.
	"
	"               For example, suppose we define a \itemize fold as follows:
	"               startpat =  '^\s*\\item',
	"               endpat = '^\s*\\item\|^\s*\\end{\(enumerate\|itemize\|description\)}',
	"               startoff = 0,
	"               endoff = -1
	"
	"               This defines a fold which starts with a line beginning with an
	"               \item and ending one line before a line beginning with an
	"               \item or \end{enumerate} etc.
	"
	"               Then, as long as \item's are not nested things are fine.
	"               However, once items begin to nest, the fold started by one
	"               \item can end because of an \item in an \itemize
	"               environment within this \item. i.e, the following can happen:
	"
	"               \begin{itemize}
	"               \item Some text <------- fold will start here
	"                     This item will contain a nested item
	"                     \begin{itemize} <----- fold will end here because next line contains \item...
	"                     \item Hello
	"                     \end{itemize} <----- ... instead of here.
	"               \item Next item of the parent itemize
	"               \end{itemize}
	"
	"               Therefore, in order to completely define a folding item which
	"               allows nesting, we need to also define a "skip" pattern.
	"               startskip and end skip do that.
	"               Leave '' when there is no nesting.
	"    endskip: the pattern which defines the end of the "skip" pattern for
	"             nested folds.
	"
	"    Example: 
	"    1. A syntax fold region for a latex section is
	"           startpat = "\\section{"
	"           endpat   = "\\section{"
	"           startoff = 0
	"           endoff   = -1
	"           startskip = ''
	"           endskip = ''
	"    Note that the start and end patterns are thus the same and endoff has a
	"    negative value to capture the effect of a section ending one line before
	"    the next starts.
	"    2. A syntax fold region for the \itemize environment is:
	"           startpat = '^\s*\\item',
	"           endpat = '^\s*\\item\|^\s*\\end{\(enumerate\|itemize\|description\)}',
	"           startoff = 0,
	"           endoff = -1,
	"           startskip = '^\s*\\begin{\(enumerate\|itemize\|description\)}',
	"           endskip = '^\s*\\end{\(enumerate\|itemize\|description\)}'
	"     Note the use of startskip and endskip to allow nesting.
	"
	"
	" }}}
	" ========================================================================
	
	" {{{ comment lines
	if g:Tex_FoldedMisc =~ '\<comments\>'
		call AddSyntaxFoldItem (
			\ '^%\([^%]\|[^f]\|[^a]\|[^k]\|[^e]\)',
			\ '^[^%]',
			\ 0,
			\ -1 
			\ )
	endif
	" }}}

	" {{{ items
	if g:Tex_FoldedMisc =~ '\<item\>'
		call AddSyntaxFoldItem (
			\ '^\s*\\item',
			\ '^\s*\\item\|^\s*\\end{\(enumerate\|itemize\|description\)}',
			\ 0,
			\ -1,
			\ '^\s*\\begin{\(enumerate\|itemize\|description\)}',
			\ '^\s*\\end{\(enumerate\|itemize\|description\)}'
			\ )
	endif
	" }}}

	" {{{ title
	if g:Tex_FoldedMisc =~ '\<title\>'
		call AddSyntaxFoldItem (
			\ '^\s*\\title\W',
			\ '^\s*\\maketitle',
			\ 0,
			\ 0
			\ )
	endif
	" }}}
 
	" Commands and Environments {{{
	" Fold the commands and environments in 2 passes.
	let pass = 0
	while pass < 2
		if pass == 0
			let lst = g:Tex_FoldedCommands
		else
			let lst = g:Tex_FoldedEnvironments
		endif
		while lst != ''
			let i = match(lst, ',')
			if i > 0
				let s = strpart(lst, 0, i)
				let lst = strpart(lst, i+1)
			else
				let s = lst
				let lst = ''
			endif
			if s != ''
				if pass == 0
					" NOTE: This pattern ensures that a command which is
					" terminated on the same line will not start a fold.
					" However, it will also refuse to fold certain commands
					" which have not terminated. eg:
					" 	\commandname{something \bf{text} and 
					" will _not_ start a fold.
					" In other words, the pattern is safe, but not exact.
					call AddSyntaxFoldItem('^\s*\\'.s.'{[^{}]*$','^[^}]*}',0,0)
				else
					call AddSyntaxFoldItem('^\s*\\begin{'.s,'\(^\|\s\)\s*\\end{'.s,0,0)
				endif
			endif
		endwhile
		let pass = pass + 1
	endwhile
	" }}}

	" Sections {{{
	if g:Tex_FoldedSections != '' 
		call Tex_FoldSections(g:Tex_FoldedSections,
			\ '^\s*\\frontmatter\|^\s*\\mainmatter\|^\s*\\backmatter\|'
			\. '^\s*\\begin{thebibliography\|>>>\|^\s*\\endinput\|'
			\. '^\s*\\begin{slide\|^\s*\\end{document')
	endif
	" }}} 
	
	" {{{ slide
	if g:Tex_FoldedMisc =~ '\<slide\>'
		call AddSyntaxFoldItem (
			\ '^\s*\\begin{slide',
			\ '^\s*\\appendix\W\|^\s*\\chapter\W\|^\s*\\end{slide\|^\s*\\end{document',
			\ 0,
			\ 0
			\ )
	endif
	" }}}

	" {{{ preamble
	if g:Tex_FoldedMisc =~ '\<preamble\>'
		call AddSyntaxFoldItem (
			\ '^\s*\\document\(class\|style\).*{',
			\ '^\s*\\begin{document}',
			\ 0,
			\ -1 
			\ )
	endif
	" }}}

	" Manually folded regions {{{
	if g:Tex_FoldedMisc =~ '\(^\|,\)<<<\(,\|$\)'
		call AddSyntaxFoldItem (
			\ '<<<',
			\ '>>>',
			\ 0,
			\ 0
			\ )
	endif
	" }}}
	
	call MakeSyntaxFolds(a:force)
	normal! zv
endfunction

" }}}
" TexFoldTextFunction: create fold text for folds {{{
function! TexFoldTextFunction()
	let leadingSpace = matchstr('                                       ', ' \{,'.indent(v:foldstart).'}')
	if getline(v:foldstart) =~ '^\s*\\begin{'
		let header = matchstr(getline(v:foldstart),
							\ '^\s*\\begin{\zs\([:alpha:]*\)[^}]*\ze}')
		let caption = ''
		let label = ''
		let i = v:foldstart
		while i <= v:foldend
			if getline(i) =~ '\\caption'
				" distinguish between
				" \caption{fulldesc} - fulldesc will be displayed
				" \caption[shortdesc]{fulldesc} - shortdesc will be displayed
				if getline(i) =~ '\\caption\['
					let caption = matchstr(getline(i), '\\caption\[\zs[^\]]*')
					let caption = substitute(caption, '\zs\]{.*}[^}]*$', '', '')
				else
					let caption = matchstr(getline(i), '\\caption{\zs.*')
					let caption = substitute(caption, '\zs}[^}]*$', '', '')
				end
			elseif getline(i) =~ '\\label'
				let label = matchstr(getline(i), '\\label{\zs.*')
				" :FIXME: this does not work when \label contains a
				" newline or a }-character
				let label = substitute(label, '\([^}]*\)}.*$', '\1', '')
			end

			let i = i + 1
		endwhile

		let ftxto = foldtext()
		" if no caption found, then use the second line.
		if caption == ''
			let caption = getline(v:foldstart + 1)
		end

		let retText = matchstr(ftxto, '^[^:]*').': '.header.
						\ ' ('.label.'): '.caption
		return leadingSpace.retText

	elseif getline(v:foldstart) =~ '^%' && getline(v:foldstart) !~ '^%%fake'
		let ftxto = foldtext()
		return leadingSpace.substitute(ftxto, ':', ': % ', '')
	elseif getline(v:foldstart) =~ '^\s*\\document\(class\|style\).*{'
		let ftxto = leadingSpace.foldtext()
		return substitute(ftxto, ':', ': Preamble: ', '')
	else
		return leadingSpace.foldtext()
	end
endfunction
" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
