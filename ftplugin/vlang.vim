if polyglot#init#is_disabled(expand('<sfile>:p'), 'v', 'ftplugin/vlang.vim')
  finish
endif

if exists("b:did_ftplugin")
	finish
endif

setlocal commentstring=//\ %s
setlocal makeprg=v\ %

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= "|setlocal commentstring< makeprg<"
else
	let b:undo_ftplugin = "setlocal commentstring< makeprg<"
endif

function! _VFormatFile()
	if exists('g:v_autofmt_bufwritepre') && g:v_autofmt_bufwritepre || exists('b:v_autofmt_bufwritepre') && b:v_autofmt_bufwritepre
		let substitution = system("v fmt -", join(getline(1, line('$')), "\n"))
		if v:shell_error != 0
			echoerr "While formatting the buffer via vfmt, the following error occurred:"
			echoerr printf("ERROR(%d): %s", v:shell_error, substitution)
		else
			let [_, lnum, colnum, _] = getpos('.')
			%delete
			call setline(1, split(substitution, "\n"))
			call cursor(lnum, colnum)
		endif
	endif
endfunction

if has('autocmd')
	augroup v_fmt
		autocmd BufWritePre *.v call _VFormatFile()
	augroup END
endif
