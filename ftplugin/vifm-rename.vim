if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1

" Filetype plugin for vifm rename buffer
" Maintainer:  xaizek <xaizek@posteo.net>
" Last Change: October 05, 2014

if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Copy list of original file names
let s:files = getline(1, '$')

" Closes window/tab/Vim when buffer is left alone in there
function! s:QuitIfOnlyWindow()
	" Boil out if there is more than one window
	if winbufnr(2) != -1
		return
	endif

	" Just close tab with this single window or quit Vim with last tab
	if tabpagenr('$') == 1
		bdelete
		quit
	else
		close
	endif
endfunction

" Create a vertical split window for original file names and configure it
belowright vsplit __VifmRenameOrig__
enew
call setline(1, s:files)
setlocal buftype=nofile
setlocal bufhidden=hide
setlocal noswapfile
setlocal nobuflisted
setlocal cursorbind
setlocal scrollbind
setlocal nocursorline

" Free now useless list of file names
unlet s:files

" Setup a hook in auxiliary local window to do not leave it alone, when it's
" useless
augroup VifmRenameAutoCmds
	autocmd! * <buffer>
	autocmd BufEnter <buffer> call s:QuitIfOnlyWindow()
augroup END

" Go back to the original window and ensure it will remain synchronized with
" the auxiliary one
wincmd w
setlocal cursorbind
setlocal scrollbind

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab cinoptions-=(0 :

endif
