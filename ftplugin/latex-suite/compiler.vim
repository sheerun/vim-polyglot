"=============================================================================
"        File: compiler.vim
"      Author: Srinath Avadhanula
"     Created: Tue Apr 23 05:00 PM 2002 PST
"
"  Description: functions for compiling/viewing/searching latex documents
"=============================================================================

" Tex_SetTeXCompilerTarget: sets the 'target' for the next call to Tex_RunLaTeX() {{{
function! Tex_SetTeXCompilerTarget(type, target)
	call Tex_Debug("+Tex_SetTeXCompilerTarget: setting target to [".a:target."] for ".a:type."r", "comp")

	if a:target == ''
		let target = Tex_GetVarValue('Tex_DefaultTargetFormat')
		let target = input('Enter the target format for '.a:type.'r: ', target)
	else
		let target = a:target
	endif
	if target == ''
		let target = 'dvi'
	endif

	let targetRule = Tex_GetVarValue('Tex_'.a:type.'Rule_'.target)

	if targetRule != ''
		if a:type == 'Compile'
			let &l:makeprg = escape(targetRule, Tex_GetVarValue('Tex_EscapeChars'))
		elseif a:type == 'View'
			let s:viewer = targetRule
		endif
		let s:target = target

	elseif Tex_GetVarValue('Tex_'.a:type.'RuleComplete_'.target) != ''
		let s:target = target

	elseif a:type == 'View' && has('macunix')
		" On the mac, we can have empty view rules, so do not complain when
		" both Tex_ViewRule_target and Tex_ViewRuleComplete_target are
		" empty. On other platforms, we will complain... see below.
		let s:target = target

	else
		let s:origdir = fnameescape(getcwd())
		exe 'cd '.fnameescape(expand('%:p:h'))
		if !Tex_GetVarValue('Tex_UseMakefile') || (glob('makefile*') == '' && glob('Makefile*') == '')
			if has('gui_running')
				call confirm(
					\'No '.a:type.' rule defined for target '.target."\n".
					\'Please specify a rule in $VIMRUNTIME/ftplugin/tex/texrc'."\n".
					\'     :help Tex_'.a:type.'Rule_format'."\n".
					\'for more information',
					\"&ok", 1, 'Warning')
			else
				call input(
					\'No '.a:type.' rule defined for target '.target."\n".
					\'Please specify a rule in $VIMRUNTIME/ftplugin/tex/texrc'."\n".
					\'     :help Tex_'.a:type.'Rule_format'."\n".
					\'for more information'
					\)
			endif
		else
			echomsg 'Assuming target is for makefile'
			let s:target = target
		endif
		exe 'cd '.s:origdir
	endif
endfunction

function! SetTeXTarget(...)
	if a:0 < 1
		let target = Tex_GetVarValue('Tex_DefaultTargetFormat')
		let target = input('Enter the target format for compiler and viewer: ', target)
	else
		let target = a:1
	endif
	if target == ''
		let target = 'dvi'
	endif

	call Tex_SetTeXCompilerTarget('Compile', target)
	call Tex_SetTeXCompilerTarget('View', target)
endfunction

com! -nargs=1 TCTarget :call Tex_SetTeXCompilerTarget('Compile', <f-args>)
com! -nargs=1 TVTarget :call Tex_SetTeXCompilerTarget('View', <f-args>)
com! -nargs=? TTarget :call SetTeXTarget(<f-args>)

" }}}
" Tex_CompileLatex: compiles the present file. {{{
" Description:
function! Tex_CompileLatex()
	if &ft != 'tex'
		echo "calling Tex_RunLaTeX from a non-tex file"
		return
	end

	" close any preview windows left open.
	pclose!

	let s:origdir = fnameescape(getcwd())

	" Find the main file corresponding to this file. Always cd to the
	" directory containing the file to avoid problems with the directory
	" containing spaces.
	" Latex on linux seems to be unable to handle file names with spaces at
	" all! Therefore for the moment, do not attempt to handle spaces in the
	" file name.
	if exists('b:fragmentFile')
		let mainfname = expand('%:p:t')
		call Tex_CD(expand('%:p:h'))
	else
		let mainfname = Tex_GetMainFileName(':p:t')
		call Tex_CD(Tex_GetMainFileName(':p:h'))
	end

	call Tex_Debug('Tex_CompileLatex: getting mainfname = ['.mainfname.'] from Tex_GetMainFileName', 'comp')

	" if a makefile exists and the user wants to use it, then use that
	" irrespective of whether *.latexmain exists or not. mainfname is still
	" extracted from *.latexmain (if possible) log file name depends on the
	" main file which will be compiled.
	if Tex_GetVarValue('Tex_UseMakefile') && (glob('makefile') != '' || glob('Makefile') != '')
		let _makeprg = &l:makeprg
		call Tex_Debug("Tex_CompileLatex: using the makefile in the current directory", "comp")
		let &l:makeprg = 'make $*'
		if exists('s:target')
			call Tex_Debug('Tex_CompileLatex: execing [make! '.s:target.']', 'comp')
			exec 'make! '.s:target
		else
			call Tex_Debug('Tex_CompileLatex: execing [make!]', 'comp')
			exec 'make!'
		endif
		let &l:makeprg = _makeprg
	else
		" If &makeprg has something like "$*.ps", it means that it wants the
		" file-name without the extension... Therefore remove it.
		if &makeprg =~ '\$\*\.\w\+'
			let mainfname = fnamemodify(mainfname, ':r')
		endif
		call Tex_Debug('Tex_CompileLatex: execing [make! '.mainfname.']', 'comp')
		exec 'make! '.mainfname
	endif
	redraw!

	exe 'cd '.s:origdir
endfunction " }}}
" Tex_RunLaTeX: compilation function {{{
" this function runs the latex command on the currently open file. often times
" the file being currently edited is only a fragment being \input'ed into some
" master tex file. in this case, make a file called mainfile.latexmain in the
" directory containig the file. in other words, if the current file is
" ~/thesis/chapter.tex
" so that doing "latex chapter.tex" doesnt make sense, then make a file called
" main.tex.latexmain
" in the ~/thesis directory. this will then run "latex main.tex" when
" Tex_RunLaTeX() is called.
function! Tex_RunLaTeX()
	call Tex_Debug('+Tex_RunLaTeX, b:fragmentFile = '.exists('b:fragmentFile'), 'comp')

	let dir = expand("%:p:h").'/'
	let s:origdir = fnameescape(getcwd())
	call Tex_CD(expand("%:p:h"))

	let initTarget = s:target

	" first get the dependency chain of this format.
	call Tex_Debug("Tex_RunLaTeX: compiling to target [".s:target."]", "comp")

	if Tex_GetVarValue('Tex_FormatDependency_'.s:target) != ''
		let dependency = Tex_GetVarValue('Tex_FormatDependency_'.s:target)
		if dependency !~ ','.s:target.'$'
			let dependency = dependency.','.s:target
		endif
	else
		let dependency = s:target
	endif

	call Tex_Debug('Tex_RunLaTeX: getting dependency chain = ['.dependency.']', 'comp')

	" now compile to the final target format via each dependency.
	let i = 1
	while Tex_Strntok(dependency, ',', i) != ''
		let s:target = Tex_Strntok(dependency, ',', i)

		call Tex_SetTeXCompilerTarget('Compile', s:target)
		call Tex_Debug('Tex_RunLaTeX: setting target to '.s:target, 'comp')

		if Tex_GetVarValue('Tex_MultipleCompileFormats') =~ '\<'.s:target.'\>'
			call Tex_Debug("Tex_RunLaTeX: compiling file multiple times via Tex_CompileMultipleTimes", "comp")
			call Tex_CompileMultipleTimes()
		else
			call Tex_Debug("Tex_RunLaTeX: compiling file once via Tex_CompileLatex", "comp")
			call Tex_CompileLatex()
		endif

		let errlist = Tex_GetErrorList()
		call Tex_Debug("Tex_RunLaTeX: errlist = [".errlist."]", "comp")

		" If there are any errors, then break from the rest of the steps
		if errlist =~  '\v(error|warning)'
			call Tex_Debug('Tex_RunLaTeX: There were errors in compiling, breaking chain...', 'comp')
			break
		endif

		let i = i + 1
	endwhile

	let s:target = initTarget
	let s:origwinnum = winnr()
	call Tex_SetupErrorWindow()

	exe 'cd '.s:origdir
	call Tex_Debug("-Tex_RunLaTeX", "comp")
endfunction

" }}}
" Tex_ViewLaTeX: opens viewer {{{
" Description: opens the DVI viewer for the file being currently edited.
" Again, if the current file is a \input in a master file, see text above
" Tex_RunLaTeX() to see how to set this information.
function! Tex_ViewLaTeX()
	if &ft != 'tex'
		echo "calling Tex_ViewLaTeX from a non-tex file"
		return
	end

	let s:origdir = fnameescape(getcwd())

	" If b:fragmentFile is set, it means this file was compiled as a fragment
	" using Tex_PartCompile, which means that we want to ignore any
	" *.latexmain or makefile's.
	if !exists('b:fragmentFile')
		" cd to the location of the file to avoid having to deal with spaces
		" in the directory name.
		let mainfname = Tex_GetMainFileName(':p:t:r')
		call Tex_CD(Tex_GetMainFileName(':p:h'))
	else
		let mainfname = expand("%:p:t:r")
		call Tex_CD(expand("%:p:h"))
	endif

	if Tex_GetVarValue('Tex_ViewRuleComplete_'.s:target) != ''

		let execString = Tex_GetVarValue('Tex_ViewRuleComplete_'.s:target)
		let execString = substitute(execString, '{v:servername}', v:servername, 'g')

	elseif has('win32')
		" unfortunately, yap does not allow the specification of an external
		" editor from the command line. that would have really helped ensure
		" that this particular vim and yap are connected.
		let execString = 'start '.s:viewer.' "$*.'.s:target.'"'

	elseif (has('macunix') && Tex_GetVarValue('Tex_TreatMacViewerAsUNIX') != 1)

		if strlen(s:viewer)
			let appOpt = '-a '
		else
			let appOpt = ''
		endif
		let execString = 'open '.appOpt.s:viewer.' $*.'.s:target

	else
		" taken from Dimitri Antoniou's tip on vim.sf.net (tip #225).
		" slight change to actually use the current servername instead of
		" hardcoding it as xdvi.
		" Using an option for specifying the editor in the command line
		" because that seems to not work on older bash'es.
		if s:target == 'dvi'

			if Tex_GetVarValue('Tex_UseEditorSettingInDVIViewer') == 1 &&
						\ v:servername != '' &&
						\ s:viewer =~ '^ *xdvik\?\( \|$\)'

				let execString = s:viewer.' -editor "gvim --servername '.v:servername.
							\ ' --remote-silent +\%l \%f" $*.dvi'

			elseif Tex_GetVarValue('Tex_UseEditorSettingInDVIViewer') == 1 &&
						\ s:viewer =~ '^ *kdvi\( \|$\)'

				let execString = s:viewer.' --unique $*.dvi'

			else

				let execString = s:viewer.' $*.dvi'

			endif

		else

			let execString = s:viewer.' $*.'.s:target

		endif

		if( Tex_GetVarValue('Tex_ExecuteUNIXViewerInForeground') != 1 )
			let execString = execString.' &'
		endif

	end

	let execString = substitute(execString, '\V$*', mainfname, 'g')
	call Tex_Debug("Tex_ViewLaTeX: execString = ".execString, "comp")

	exec 'silent! !'.execString

	if !has('gui_running')
		redraw!
	endif

	exe 'cd '.s:origdir
endfunction

" }}}
" Tex_ForwardSearchLaTeX: searches for current location in dvi file. {{{
" Description: if the DVI viewer is compatible, then take the viewer to that
"              position in the dvi file. see docs for Tex_RunLaTeX() to set a
"              master file if this is an \input'ed file.
" Tip: With YAP on Windows, it is possible to do forward and inverse searches
"      on DVI files. to do forward search, you'll have to compile the file
"      with the --src-specials option. then set the following as the command
"      line in the 'view/options/inverse search' dialog box:
"           gvim --servername LATEX --remote-silent +%l "%f"
"      For inverse search, if you are reading this, then just pressing \ls
"      will work.
function! Tex_ForwardSearchLaTeX()
	if &ft != 'tex'
		echo "calling Tex_ForwardSeachLaTeX from a non-tex file"
		return
	end

	if Tex_GetVarValue('Tex_ViewRule_'.s:target) == ''
		return
	endif
	let viewer = Tex_GetVarValue('Tex_ViewRule_'.s:target)

	let s:origdir = fnameescape(getcwd())

	let mainfname = Tex_GetMainFileName(':t')
	let mainfnameRoot = fnamemodify(Tex_GetMainFileName(), ':t:r')
	let mainfnameFull = Tex_GetMainFileName(':p:r')
	" cd to the location of the file to avoid problems with directory name
	" containing spaces.
	call Tex_CD(Tex_GetMainFileName(':p:h'))

	" inverse search tips taken from Dimitri Antoniou's tip and Benji Fisher's
	" tips on vim.sf.net (vim.sf.net tip #225)
	if (has('win32') && (viewer =~? '^ *yap\( \|$\)'))

		let execString = 'silent! !start '. viewer.' -s '.line('.').expand('%').' '.mainfnameRoot


	elseif (has('macunix') && (viewer =~ '^ *\(Skim\|PDFView\|TeXniscope\)\( \|$\)'))
		" We're on a Mac using a traditional Mac viewer

		if viewer =~ '^ *Skim'

				let execString = 'silent! !/Applications/Skim.app/Contents/SharedSupport/displayline '.
					\ line('.').' "'.mainfnameFull.'.'.s:target.'" "'.expand("%:p").'"'

		elseif viewer =~ '^ *PDFView'

				let execString = 'silent! !/Applications/PDFView.app/Contents/MacOS/gotoline.sh '.
					\ line('.').' "'.mainfnameFull.'.'.s:target.'" "'.expand("%:p").'"'

		elseif viewer =~ '^ *TeXniscope'

				let execString = 'silent! !/Applications/TeXniscope.app/Contents/Resources/forward-search.sh '.
					\ line('.').' "'.expand("%:p").'" "'.mainfnameFull.'.'.s:target.'"'

		endif

	else
		" We're either UNIX or Mac and using a UNIX-type viewer

		" Check for the special DVI viewers first
		if viewer =~ '^ *\(xdvi\|xdvik\|kdvi\|okular\)\( \|$\)'

			if Tex_GetVarValue('Tex_UseEditorSettingInDVIViewer') == 1 &&
						\ exists('v:servername') &&
						\ viewer =~ '^ *xdvik\?\( \|$\)'

				let execString = 'silent! !'.viewer.' -name xdvi -sourceposition "'.line('.').' '.expand("%").'"'.
							\ ' -editor "gvim --servername '.v:servername.' --remote-silent +\%l \%f" '.
							\ mainfnameRoot.'.dvi'

			elseif viewer =~ '^ *kdvi'

				let execString = 'silent! !'.viewer.' --unique file:'.mainfnameRoot.'.dvi\#src:'.line('.').expand("%")

			elseif viewer =~ '^ *xdvik\?\( \|$\)'

				let execString = 'silent! !'.viewer.' -name xdvi -sourceposition "'.line('.').' '.expand("%").'" '.mainfnameRoot.'.dvi'

			elseif viewer =~ '^ *okular'

				let execString = 'silent! !'.viewer.' --unique '.mainfnameRoot.'.'.s:target.'\#src:'.line('.').expand("%:p")

			endif

		else
			" We must be using a generic UNIX viewer
			" syntax is: viewer TARGET_FILE LINE_NUMBER SOURCE_FILE

			let execString = 'silent! !'.viewer.' "'.mainfnameRoot.'.'.s:target.'" '.line('.').' "'.expand('%').'"'

		endif

		" See if we should add &. On Mac (at least in MacVim), it seems
		" like this should NOT be added...
		if( Tex_GetVarValue('Tex_ExecuteUNIXViewerInForeground') != 1 )
			let execString = execString.' &'
		endif

	endif

	call Tex_Debug("Tex_ForwardSearchLaTeX: execString = ".execString, "comp")
	execute execString
	if !has('gui_running')
		redraw!
	endif

	exe 'cd '.s:origdir
endfunction

" }}}

" ==============================================================================
" Functions for compiling parts of a file.
" ==============================================================================
" Tex_PartCompile: compiles selected fragment {{{
" Description: creates a temporary file from the selected fragment of text
"       prepending the preamble and \end{document} and then asks Tex_RunLaTeX() to
"       compile it.
function! Tex_PartCompile() range
	call Tex_Debug('+Tex_PartCompile', 'comp')

	" Get a temporary file in the same directory as the file from which
	" fragment is being extracted. This is to enable the use of relative path
	" names in the fragment.
	let tmpfile = Tex_GetTempName(expand('%:p:h'))

	" Remember all the temp files and for each temp file created, remember
	" where the temp file came from.
	let s:Tex_NumTempFiles = (exists('s:Tex_NumTempFiles') ? s:Tex_NumTempFiles + 1 : 1)
	let s:Tex_TempFiles = (exists('s:Tex_TempFiles') ? s:Tex_TempFiles : '')
		\ . tmpfile."\n"
	let s:Tex_TempFile_{s:Tex_NumTempFiles} = tmpfile
	" TODO: For a function Tex_RestoreFragment which restores a temp file to
	"       its original location.
	let s:Tex_TempFileOrig_{s:Tex_NumTempFiles} = expand('%:p')
	let s:Tex_TempFileRange_{s:Tex_NumTempFiles} = a:firstline.','.a:lastline

	" Set up an autocmd to clean up the temp files when Vim exits.
	if Tex_GetVarValue('Tex_RemoveTempFiles')
		augroup RemoveTmpFiles
			au!
			au VimLeave * :call Tex_RemoveTempFiles()
		augroup END
	endif

	" If mainfile exists open it in tiny window and extract preamble there,
	" otherwise do it from current file
	let mainfile = Tex_GetMainFileName(":p")
	exe 'bot 1 split '.escape(mainfile, ' ')
	exe '1,/\s*\\begin{document}/w '.tmpfile
	wincmd q

	exe a:firstline.','.a:lastline."w! >> ".tmpfile

	" edit the temporary file
	exec 'drop '.tmpfile

	" append the \end{document} line.
	$ put ='\end{document}'
	w

	" set this as a fragment file.
	let b:fragmentFile = 1

	silent! call Tex_RunLaTeX()
endfunction " }}}
" Tex_RemoveTempFiles: cleans up temporary files created during part compilation {{{
" Description: During part compilation, temporary files containing the
"              visually selected text are created. These files need to be
"              removed when Vim exits to avoid "file leakage".
function! Tex_RemoveTempFiles()
	if !exists('s:Tex_NumTempFiles') || !Tex_GetVarValue('Tex_RemoveTempFiles')
		return
	endif
	let i = 1
	while i <= s:Tex_NumTempFiles
		let tmpfile = s:Tex_TempFile_{i}
		" Remove the tmp file and all other associated files such as the
		" .log files etc.
		call Tex_DeleteFile(fnamemodify(tmpfile, ':p:r').'.*')
		let i = i + 1
	endwhile
endfunction " }}}

" ==============================================================================
" Compiling a file multiple times to resolve references/citations etc.
" ==============================================================================
" Tex_CompileMultipleTimes: The main function {{{
" Description: compiles a file multiple times to get cross-references right.
function! Tex_CompileMultipleTimes()
	" Just extract the root without any extension because we want to construct
	" the log file names etc from it.
	let s:origdir = fnameescape(getcwd())
	let mainFileName_root = Tex_GetMainFileName(':p:t:r')
	call Tex_CD(Tex_GetMainFileName(':p:h'))

	" First ignore undefined references and the
	" "rerun to get cross-references right" message from
	" the compiler output.
	let origlevel = Tex_GetVarValue('Tex_IgnoreLevel')
	let origpats = Tex_GetVarValue('Tex_IgnoredWarnings')

	let g:Tex_IgnoredWarnings = g:Tex_IgnoredWarnings."\n"
		\ . 'Reference %.%# undefined'."\n"
		\ . 'Rerun to get cross-references right'
	TCLevel 1000

	let idxFileName = mainFileName_root.'.idx'
	let auxFileName = mainFileName_root.'.aux'

	let runCount = 0
	let needToRerun = 1
	while needToRerun == 1 && runCount < 5
		" assume we need to run only once.
		let needToRerun = 0

		let idxlinesBefore = Tex_CatFile(idxFileName)
		let auxlinesBefore = Tex_GetAuxFile(auxFileName)

		" first run latex.
		echomsg "latex run number : ".(runCount+1)
		call Tex_Debug("Tex_CompileMultipleTimes: latex run number : ".(runCount+1), "comp")
		silent! call Tex_CompileLatex()

		" If there are errors in any latex compilation step, immediately
		" return. For now, do not bother with warnings because those might go
		" away after compiling again or after bibtex is run etc.
		let errlist = Tex_GetErrorList()
		call Tex_Debug("Tex_CompileMultipleTimes: errors = [".errlist."]", "comp")

		if errlist =~ 'error'
			let g:Tex_IgnoredWarnings = origpats
			exec 'TCLevel '.origlevel

			return
		endif

		let idxlinesAfter = Tex_CatFile(idxFileName)

		" If .idx file changed, then run makeindex to generate the new .ind
		" file and remember to rerun latex.
		if runCount == 0 && glob(idxFileName) != '' && idxlinesBefore != idxlinesAfter
			echomsg "Running makeindex..."
			let temp_mp = &mp | let &mp = Tex_GetVarValue('Tex_MakeIndexFlavor')
			exec 'silent! make '.mainFileName_root
			let &mp = temp_mp

			let needToRerun = 1
		endif

		" The first time we see if we need to run bibtex and if the .bbl file
		" changes, we will rerun latex.
		if runCount == 0 && Tex_IsPresentInFile('\\bibdata', mainFileName_root.'.aux')
			let bibFileName = mainFileName_root.'.bbl'

			let biblinesBefore = Tex_CatFile(bibFileName)

			echomsg "Running '".Tex_GetVarValue('Tex_BibtexFlavor')."' ..."
			let temp_mp = &mp | let &mp = Tex_GetVarValue('Tex_BibtexFlavor')
			exec 'silent! make '.mainFileName_root
			let &mp = temp_mp

			let biblinesAfter = Tex_CatFile(bibFileName)

			" If the .bbl file changed after running bibtex, we need to
			" latex again.
			if biblinesAfter != biblinesBefore
				echomsg 'Need to rerun because bibliography file changed...'
				call Tex_Debug('Tex_CompileMultipleTimes: Need to rerun because bibliography file changed...', 'comp')
				let needToRerun = 1
			endif
		endif

		" check if latex asks us to rerun
		let auxlinesAfter = Tex_GetAuxFile(auxFileName)
		if auxlinesAfter != auxlinesBefore
			echomsg "Need to rerun because the AUX file changed..."
			call Tex_Debug("Tex_CompileMultipleTimes: Need to rerun to get cross-references right...", 'comp')
			let needToRerun = 1
		endif

		let runCount = runCount + 1
	endwhile

	redraw!
	call Tex_Debug("Tex_CompileMultipleTimes: Ran latex ".runCount." time(s)", "comp")
	echomsg "Ran latex ".runCount." time(s)"

	let g:Tex_IgnoredWarnings = origpats
	exec 'TCLevel '.origlevel
	" After all compiler calls are done, reparse the .log file for
	" errors/warnings to handle the situation where the clist might have been
	" emptied because of bibtex/makeindex being run as the last step.
	exec 'silent! cfile '.mainFileName_root.'.log'

	exe 'cd '.s:origdir
endfunction " }}}
" Tex_GetAuxFile: get the contents of the AUX file {{{
" Description: get the contents of the AUX file recursively including any
" @\input'ted AUX files.
function! Tex_GetAuxFile(auxFile)
	if !filereadable(a:auxFile)
		return ''
	endif

	let auxContents = Tex_CatFile(a:auxFile)
	let pattern = '@\input{\(.\{-}\)}'

	let auxContents = substitute(auxContents, pattern, '\=Tex_GetAuxFile(submatch(1))', 'g')

	return auxContents
endfunction " }}}

" ==============================================================================
" Helper functions for
" . viewing the log file in preview mode.
" . syncing the display between the quickfix window and preview window
" . going to the correct line _and column_ number from from the quick fix
"   window.
" ==============================================================================
" Tex_SetupErrorWindow: sets up the cwindow and preview of the .log file {{{
" Description:
function! Tex_SetupErrorWindow()
	let mainfname = Tex_GetMainFileName()

	let winnum = winnr()

	" close the quickfix window before trying to open it again, otherwise
	" whether or not we end up in the quickfix window after the :cwindow
	" command is not fixed.
	cclose
	cwindow
	" create log file name from mainfname
	let mfnlog = fnamemodify(mainfname, ":t:r").'.log'
	call Tex_Debug('Tex_SetupErrorWindow: mfnlog = '.mfnlog, 'comp')
	" if we moved to a different window, then it means we had some errors.
	if winnum != winnr()
		if Tex_GetVarValue('Tex_ShowErrorContext')
			call Tex_UpdatePreviewWindow(mfnlog)
			exe 'nnoremap <buffer> <silent> j j:call Tex_UpdatePreviewWindow("'.mfnlog.'")<CR>'
			exe 'nnoremap <buffer> <silent> k k:call Tex_UpdatePreviewWindow("'.mfnlog.'")<CR>'
			exe 'nnoremap <buffer> <silent> <up> <up>:call Tex_UpdatePreviewWindow("'.mfnlog.'")<CR>'
			exe 'nnoremap <buffer> <silent> <down> <down>:call Tex_UpdatePreviewWindow("'.mfnlog.'")<CR>'
		endif
		exe 'nnoremap <buffer> <silent> <enter> :call Tex_GotoErrorLocation("'.mfnlog.'")<CR>'

		setlocal nowrap

		" resize the window to just fit in with the number of lines.
		exec ( line('$') < 4 ? line('$') : 4 ).' wincmd _'
        if Tex_GetVarValue('Tex_GotoError') == 1
	        call Tex_GotoErrorLocation(mfnlog)
        else
			exec s:origwinnum.' wincmd w'
        endif
	endif

endfunction " }}}
" Tex_PositionPreviewWindow: positions the preview window correctly. {{{
" Description:
"   The purpose of this function is to count the number of times an error
"   occurs on the same line. or in other words, if the current line is
"   something like |10 error|, then we want to count the number of
"   lines in the quickfix window before this line which also contain lines
"   like |10 error|.
"
function! Tex_PositionPreviewWindow(filename)

	if getline('.') !~ '|\d\+ \(error\|warning\)|'
		if !search('|\d\+ \(error\|warning\)|')
			call Tex_Debug("not finding error pattern anywhere in quickfix window :".bufname(bufnr('%')),
						\ 'comp')
			pclose!
			return
		endif
	endif

	" extract the error pattern (something like 'file.tex|10 error|') on the
	" current line.
	let errpat = matchstr(getline('.'), '^\f*|\d\+ \(error\|warning\)|\ze')
	let errfile = matchstr(getline('.'), '^\f*\ze|\d\+ \(error\|warning\)|')
	" extract the line number from the error pattern.
	let linenum = matchstr(getline('.'), '|\zs\d\+\ze \(error\|warning\)|')

	" if we are on an error, then count the number of lines before this in the
	" quickfix window with an error on the same line.
	if errpat =~ 'error|$'
		" our location in the quick fix window.
		let errline = line('.')

		" goto the beginning of the quickfix window and begin counting the lines
		" which show an error on the same line.
		0
		let numrep = 0
		while 1
			" if we are on the same kind of error line, then means we have another
			" line containing the same error pattern.
			if getline('.') =~ errpat
				let numrep = numrep + 1
				normal! 0
			endif
			" if we have reached the original location in the quick fix window,
			" then break.
			if line('.') == errline
				break
			else
				" otherwise, search for the next line which contains the same
				" error pattern again. goto the end of the current line so we
				" dont count this line again.
				normal! $
				call search(errpat, 'W')
			endif
		endwhile
	else
		let numrep = 1
	endif

	if getline('.') =~ '|\d\+ warning|'
		let searchpat = escape(matchstr(getline('.'), '|\d\+ warning|\s*\zs.*'), '\ ')
	else
		let searchpat = 'l\.'.linenum
	endif

	" We first need to be in the scope of the correct file in the .log file.
	" This is important for example, when a.tex and b.tex both have errors on
	" line 9 of the file and we want to go to the error of b.tex. Merely
	" searching forward from the beginning of the log file for l.9 will always
	" land us on the error in a.tex.
	if errfile != ''
		exec 'silent! bot pedit +/(\\(\\f\\|\\[\\|\]\\|\\s\\)*'.errfile.'/ '.a:filename
	else
		exec 'bot pedit +0 '.a:filename
	endif
	" Goto the preview window
	" TODO: This is not robust enough. Check that a wincmd j actually takes
	" us to the preview window.
	wincmd j
	" now search forward from this position in the preview window for the
	" numrep^th error of the current line in the quickfix window.
	while numrep > 0
		call search(searchpat, 'W')
		let numrep = numrep - 1
	endwhile
	normal! z.

endfunction " }}}
" Tex_UpdatePreviewWindow: updates the view of the log file {{{
" Description:
"       This function should be called when focus is in a quickfix window.
"       It opens the log file in a preview window and makes it display that
"       part of the log file which corresponds to the error which the user is
"       currently on in the quickfix window. Control returns to the quickfix
"       window when the function returns.
"
function! Tex_UpdatePreviewWindow(filename)
	call Tex_PositionPreviewWindow(a:filename)

	if &previewwindow
		6 wincmd _
		wincmd p
	endif
endfunction " }}}
" Tex_GotoErrorLocation: goes to the correct location of error in the tex file {{{
" Description:
"   This function should be called when focus is in a quickfix window. This
"   function will first open the preview window of the log file (if it is not
"   already open), position the display of the preview to coincide with the
"   current error under the cursor and then take the user to the file in
"   which this error has occured.
"
"   The position is both the correct line number and the column number.
function! Tex_GotoErrorLocation(filename)

	" first use vim's functionality to take us to the location of the error
	" accurate to the line (not column). This lets us go to the correct file
	" without applying any logic.
	exec "normal! \<enter>"
	" If the log file is not found, then going to the correct line number is
	" all we can do.
	if glob(a:filename) == ''
		return
	endif

	let winnum = winnr()
	" then come back to the quickfix window
	wincmd w

	" find out where in the file we had the error.
	let linenum = matchstr(getline('.'), '|\zs\d\+\ze \(warning\|error\)|')
	call Tex_PositionPreviewWindow(a:filename)

	if getline('.') =~ 'l.\d\+'

		let brokenline = matchstr(getline('.'), 'l.'.linenum.' \zs.*\ze')
		" If the line is of the form
		"   l.10 ...and then there was some error
		" it means (most probably) that only part of the erroneous line is
		" shown. In this case, finding the length of the broken line is not
		" correct.  Instead goto the beginning of the line and search forward
		" for the part which is displayed and then go to its end.
		if brokenline =~ '^\M...'
			let partline = matchstr(brokenline, '^\M...\m\zs.*')
			let normcmd = "0/\\V".escape(partline, "\\")."/e+1\<CR>"
		else
			let column = strlen(brokenline) + 1
			let normcmd = column.'|'
		endif

	elseif getline('.') =~ 'LaTeX Warning: \(Citation\|Reference\) `.*'

		let ref = matchstr(getline('.'), "LaTeX Warning: \\(Citation\\|Reference\\) `\\zs[^']\\+\\ze'")
		let normcmd = '0/'.ref."\<CR>"

	else

		let normcmd = '0'

	endif

	" go back to the window where we came from.
	exec winnum.' wincmd w'
	exec 'silent! '.linenum.' | normal! '.normcmd

	if !Tex_GetVarValue('Tex_ShowErrorContext')
		pclose!
	endif
endfunction " }}}
" Tex_SetCompilerMaps: sets maps for compiling/viewing/searching {{{
" Description:
function! <SID>Tex_SetCompilerMaps()
	if exists('b:Tex_doneCompilerMaps')
		return
	endif
	let s:ml = '<Leader>'

	nnoremap <buffer> <Plug>Tex_Compile :call Tex_RunLaTeX()<cr>
	vnoremap <buffer> <Plug>Tex_Compile :call Tex_PartCompile()<cr>
	nnoremap <buffer> <Plug>Tex_View :call Tex_ViewLaTeX()<cr>
	nnoremap <buffer> <Plug>Tex_ForwardSearch :call Tex_ForwardSearchLaTeX()<cr>

	call Tex_MakeMap(s:ml."ll", "<Plug>Tex_Compile", 'n', '<buffer>')
	call Tex_MakeMap(s:ml."ll", "<Plug>Tex_Compile", 'v', '<buffer>')
	call Tex_MakeMap(s:ml."lv", "<Plug>Tex_View", 'n', '<buffer>')
	call Tex_MakeMap(s:ml."ls", "<Plug>Tex_ForwardSearch", 'n', '<buffer>')
endfunction
" }}}

augroup LatexSuite
	au LatexSuite User LatexSuiteFileType
		\ call Tex_Debug('compiler.vim: Catching LatexSuiteFileType event', 'comp') |
		\ call <SID>Tex_SetCompilerMaps()
augroup END

command! -nargs=0 -range=% TPartCompile :<line1>, <line2> silent! call Tex_PartCompile()
" Setting b:fragmentFile = 1 makes Tex_CompileLatex consider the present file
" the _main_ file irrespective of the presence of a .latexmain file.
command! -nargs=0 TCompileThis let b:fragmentFile = 1
command! -nargs=0 TCompileMainFile let b:fragmentFile = 0

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
