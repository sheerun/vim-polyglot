"=============================================================================
" 	     File: custommacros.vim
"      Author: Mikolaj Machowski
" 	  Version: 1.0 
"     Created: Tue Apr 23 05:00 PM 2002 PST
" 
"  Description: functions for processing custom macros in the
"               latex-suite/macros directory
"=============================================================================

let s:path = expand('<sfile>:p:h')

" Set path to macros dir dependent on OS {{{
if has("unix") || has("macunix")
	let s:macrodirpath = $HOME."/.vim/ftplugin/latex-suite/macros/"
elseif has("win32")
	if exists("$HOME")
		let s:macrodirpath = $HOME."/vimfiles/ftplugin/latex-suite/macros/"
	else
		let s:macrodirpath = $VIM."/vimfiles/ftplugin/latex-suite/macros/"
	endif
endif

" }}}
" SetCustomMacrosMenu: sets up the menu for Macros {{{
function! <SID>SetCustomMacrosMenu()
	let flist = Tex_FindInRtp('', 'macros')
	exe 'amenu '.g:Tex_MacrosMenuLocation.'&New :call <SID>NewMacro("FFFromMMMenu")<CR>'
	exe 'amenu '.g:Tex_MacrosMenuLocation.'&Redraw :call RedrawMacro()<CR>'

	let i = 1
	while 1
		let fname = Tex_Strntok(flist, ',', i)
		if fname == ''
			break
		endif
		exe "amenu ".g:Tex_MacrosMenuLocation."&Delete.&".i.":<tab>".fname." :call <SID>DeleteMacro('".fname."')<CR>"
		exe "amenu ".g:Tex_MacrosMenuLocation."&Edit.&".i.":<tab>".fname."   :call <SID>EditMacro('".fname."')<CR>"
		exe "imenu ".g:Tex_MacrosMenuLocation."&".i.":<tab>".fname." <C-r>=<SID>ReadMacro('".fname."')<CR>"
		exe "nmenu ".g:Tex_MacrosMenuLocation."&".i.":<tab>".fname." i<C-r>=<SID>ReadMacro('".fname."')<CR>"
		let i = i + 1
	endwhile
endfunction 

if g:Tex_Menus
	call <SID>SetCustomMacrosMenu()
endif

" }}}
" NewMacro: opens new file in macros directory {{{
function! <SID>NewMacro(...)
	" Allow for calling :TMacroNew without argument or from menu and prompt
	" for name.
	if a:0 > 0
		let newmacroname = a:1
	else
		let newmacroname = input("Name of new macro: ")
		if newmacroname == ''
			return
		endif
	endif

	if newmacroname == "FFFromMMMenu"
		" Check if NewMacro was called from menu and prompt for insert macro
		" name
		let newmacroname = input("Name of new macro: ")
		if newmacroname == ''
			return
		endif
	elseif Tex_FindInRtp(newmacroname, 'macros') != ''
		" If macro with this name already exists, prompt for another name.
		exe "echomsg 'Macro ".newmacroname." already exists. Try another name.'"
		let newmacroname = input("Name of new macro: ")
		if newmacroname == ''
			return
		endif
	endif
	exec 'split '.Tex_EscapeSpaces(s:macrodirpath.newmacroname)
	setlocal filetype=tex
endfunction

" }}}
" RedrawMacro: refreshes macro menu {{{
function! RedrawMacro()
	aunmenu TeX-Suite.Macros
	call <SID>SetCustomMacrosMenu()
endfunction

" }}}
" ChooseMacro: choose a macro file {{{
" " Description: 
function! s:ChooseMacro(ask)
	let filelist = Tex_FindInRtp('', 'macros')
	let filename = Tex_ChooseFromPrompt(
				\ a:ask."\n" . 
				\ Tex_CreatePrompt(filelist, 2, ',') .
				\ "\nEnter number or filename :",
				\ filelist, ',')
endfunction 

" }}}
" DeleteMacro: deletes macro file {{{
function! <SID>DeleteMacro(...)
	if a:0 > 0
		let filename = a:1
	else
		let filename = s:ChooseMacro('Choose a macro file for deletion :')
	endif

	if !filereadable(s:macrodirpath.filename)
	" When file is not in local directory decline to remove it.
		call confirm('This file is not in your local directory: '.filename."\n".
					\ 'It will not be deleted.' , '&OK', 1)

	else
		let ch = confirm('Really delete '.filename.' ?', "&Yes\n&No", 2)
		if ch == 1
			call delete(s:macrodirpath.filename)
		endif
		call RedrawMacro()
	endif
endfunction

" }}}
" EditMacro: edits macro file {{{
function! <SID>EditMacro(...)
	if a:0 > 0
		let filename = a:1
	else
		let filename = s:ChooseMacro('Choose a macro file for insertion:')
	endif

	if filereadable(s:macrodirpath.filename)
		" If file exists in local directory open it. 
		exec 'split '.Tex_EscapeSpaces(s:macrodirpath.filename)
	else
		" But if file doesn't exist in local dir it probably is in user
		" restricted area. Instead opening try to copy it to local dir.
		" Pity VimL doesn't have mkdir() function :)
		let ch = confirm("You are trying to edit file which is probably read-only.\n".
					\ "It will be copied to your local LaTeX-Suite macros directory\n".
					\ "and you will be operating on local copy with suffix -local.\n".
					\ "It will succeed only if ftplugin/latex-suite/macros dir exists.\n".
					\ "Do you agree?", "&Yes\n&No", 1)
		if ch == 1
			" But there is possibility we already created local modification.
			" Check it and offer opening this file.
			if filereadable(s:macrodirpath.filename.'-local')
				let ch = confirm('Local version of '.filename." already exists.\n".
					\ 'Do you want to open it or overwrite with original version?',
					\ "&Open\nOver&write\n&Cancel", 1)
				if ch == 1
					exec 'split '.Tex_EscapeSpaces(s:macrodirpath.filename.'-local')
				elseif ch == 2
					new
					exe '0read '.Tex_FindInRtp(filename, 'macros')
					" This is possible macro was edited before, wipe it out.
					if bufexists(s:macrodirpath.filename.'-local')
						exe 'bwipe '.s:macrodirpath.filename.'-local'
					endif
					exe 'write! '.s:macrodirpath.filename.'-local'
				else
					return
				endif
			else
			" If file doesn't exist, open new file, read in system macro and
			" save it in local macro dir with suffix -local
				new
				exe '0read '.Tex_FindInRtp(filename, 'macros')
				exe 'write '.s:macrodirpath.filename.'-local'
			endif
		endif
		
	endif
	setlocal filetype=tex
endfunction

" }}}
" ReadMacro: reads in a macro from a macro file.  {{{
"            allowing for placement via placeholders.
function! <SID>ReadMacro(...)

	if a:0 > 0
		let filename = a:1
	else
		let filelist = Tex_FindInRtp('', 'macros')
		let filename = 
					\ Tex_ChooseFromPrompt("Choose a macro file:\n" . 
					\ Tex_CreatePrompt(filelist, 2, ',') . 
					\ "\nEnter number or name of file :", 
					\ filelist, ',')
	endif

	let fname = Tex_FindInRtp(filename, 'macros', ':p')

	let markerString = '<---- Latex Suite End Macro ---->'
	let _a = @a
	silent! call append(line('.'), markerString)
	silent! exec "read ".fname
	silent! exec "normal! V/^".markerString."$/-1\<CR>\"ax"
	" This is kind of tricky: At this stage, we are one line after the one we
	" started from with the marker text on it. We need to
	" 1. remove the marker and the line.
	" 2. get focus to the previous line.
	" 3. not remove anything from the previous line.
	silent! exec "normal! $v0k$\"_x"

	call Tex_CleanSearchHistory()

	let @a = substitute(@a, '['."\n\r\t ".']*$', '', '')
	let textWithMovement = IMAP_PutTextWithMovement(@a)
	let @a = _a

	return textWithMovement

endfunction

" }}}
" commands for macros {{{
com! -nargs=? TMacroNew :call <SID>NewMacro(<f-args>)

" This macros had to have 2 versions:
if v:version >= 602 
	com! -complete=custom,Tex_CompleteMacroName -nargs=? TMacro
				\ :let s:retVal = <SID>ReadMacro(<f-args>) <bar> normal! i<C-r>=s:retVal<CR>
	com! -complete=custom,Tex_CompleteMacroName -nargs=? TMacroEdit
				\ :call <SID>EditMacro(<f-args>)
	com! -complete=custom,Tex_CompleteMacroName -nargs=? TMacroDelete
				\ :call <SID>DeleteMacro(<f-args>)

	" Tex_CompleteMacroName: for completing names in TMacro... commands {{{
	"	Description: get list of macro names with Tex_FindInRtp(), remove full path
	"	and return list of names separated with newlines.
	"
	function! Tex_CompleteMacroName(A,P,L)
		" Get name of macros from all runtimepath directories
		let macronames = Tex_FindInRtp('', 'macros')
		" Separate names with \n not ,
		let macronames = substitute(macronames,',','\n','g')
		return macronames
	endfunction

	" }}}

else
	com! -nargs=? TMacro
		\	:let s:retVal = <SID>ReadMacro(<f-args>) <bar> normal! i<C-r>=s:retVal<CR>
	com! -nargs=? TMacroEdit   :call <SID>EditMacro(<f-args>)
	com! -nargs=? TMacroDelete :call <SID>DeleteMacro(<f-args>)

endif

" }}}

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4
