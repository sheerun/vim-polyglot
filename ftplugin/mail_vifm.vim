if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1

" Mail file type extension to pick files for attachments via vifm
" Maintainer:  xaizek <xaizek@posteo.net>
" Last Change: January 02, 2018

" Insert attachment picked via vifm after 'Subject' header
function! s:AddMailAttachments()
	call vifm#globals#Init()

	" XXX: similar code is in plugins/vifm.vim, but it's different in details
	let l:listf = tempname()

	if !has('nvim')
		if has('gui_running')
			execute 'silent !' g:vifm_term g:vifm_exec
			                 \ '--choose-files' shellescape(l:listf, 1)
			                 \ g:vifm_exec_args
		else
			execute 'silent !' g:vifm_exec
			                 \ '--choose-files' shellescape(l:listf, 1)
			                 \ g:vifm_exec_args
		endif

		redraw!

		call s:HandleRunResults(v:shell_error, l:listf)
	else
		" Work around handicapped neovim...
		let callback = { 'listf': l:listf }
		function! callback.on_exit(id, code, event)
			buffer #
			silent! bdelete! #
			call s:HandleRunResults(a:code, self.listf)
		endfunction
		enew
		call termopen(g:vifm_exec . ' --choose-files ' . shellescape(l:listf, 1)
		             \. ' ' . g:vifm_exec_args, callback)

		startinsert
	endif
endfunction

function! s:HandleRunResults(exitcode, listf)
	if a:exitcode != 0
		echohl WarningMsg
		echo 'Got non-zero code from vifm: ' . a:exitcode
		echohl None
		call delete(a:listf)
		return
	endif

	let l:insert_pos = search('^Subject:', 'nw')

	if filereadable(a:listf) && l:insert_pos != 0
		for line in readfile(a:listf)
			call append(l:insert_pos, 'Attach: '.line)
			let l:insert_pos += 1
		endfor
	endif
	call delete(a:listf)
endfunction

nnoremap <buffer> <silent> <localleader>a :call <sid>AddMailAttachments()<cr>

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab cinoptions-=(0 :

endif
