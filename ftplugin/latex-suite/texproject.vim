"=============================================================================
" 	     File: texproject.vim
"      Author: Mikolaj Machowski
" 	  Version: 1.0 
"     Created: Wen Apr 16 05:00 PM 2003
" 
"  Description: Handling tex projects.
"=============================================================================

let s:path = fnameescape(expand("<sfile>:p:h"))

command! -nargs=0 TProjectEdit  :call <SID>Tex_ProjectEdit()

" Tex_ProjectEdit: Edit project file " {{{
" Description: If project file exists (*.latexmain) open it in window created
"              with ':split', if no create ':new' window and read there
"              project template
"
function! s:Tex_ProjectEdit()

	let file = expand("%:p")
	let mainfname = Tex_GetMainFileName()
	if glob(mainfname.'.latexmain') != ''
		exec 'split '.fnameescape(mainfname.'.latexmain')
	else
		echohl WarningMsg
		echomsg "Master file not found."
		echomsg "    :help latex-master-file"
		echomsg "for more information"
		echohl None
	endif

endfunction " }}}
" Tex_ProjectLoad: loads the .latexmain file {{{
" Description: If a *.latexmain file exists, then sources it
function! Tex_ProjectLoad()
	let s:origdir = fnameescape(getcwd())
	exe 'cd '.fnameescape(expand('%:p:h'))

	if glob(Tex_GetMainFileName(':p').'.latexmain') != ''
		call Tex_Debug("Tex_ProjectLoad: sourcing [".Tex_GetMainFileName().".latexmain]", "proj")
               exec 'source '.fnameescape(Tex_GetMainFileName().'.latexmain')
	endif
	
	exe 'cd '.s:origdir
endfunction " }}}

augroup LatexSuite
	au LatexSuite User LatexSuiteFileType 
		\ call Tex_Debug("texproject.vim: catching LatexSuiteFileType event", "proj") |
		\ call Tex_ProjectLoad()
augroup END

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
