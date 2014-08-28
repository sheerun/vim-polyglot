" Vim compiler file
" Language:     Erlang
" Author:       Pawel 'kTT' Salata <rockplayer.pl@gmail.com>
" Contributors: Ricardo Catalinas Jiménez <jimenezrick@gmail.com>
" License:      Vim license
" Version:      2013/03/06

if exists("current_compiler") || v:version < 703
	finish
else
	let current_compiler = "erlang"
endif

let b:error_list     = {}
let b:is_showing_msg = 0
let b:next_sign_id   = 1

if exists(":CompilerSet") != 2
	command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=make
CompilerSet errorformat=%f:%l:\ %tarning:\ %m,%f:%l:\ %m

" Only define functions and script scope variables once
if exists("*s:ShowErrors")
	finish
endif

if !exists("g:erlang_show_errors")
	let g:erlang_show_errors = 1
endif

let s:erlang_check_file = expand("<sfile>:p:h") . "/erlang_check.erl"
let s:autocmds_defined  = 0

sign define ErlangError   text=>> texthl=Error
sign define ErlangWarning text=>> texthl=Todo

command ErlangDisableShowErrors silent call s:DisableShowErrors()
command ErlangEnableShowErrors  silent call s:EnableShowErrors()

function s:ShowErrors()
	setlocal shellpipe=>
	if match(getline(1), "#!.*escript") != -1
		setlocal makeprg=escript\ -s\ %
	else
		execute "setlocal makeprg=" . s:erlang_check_file . "\\ \%"
	endif
	silent make!
	for error in getqflist()
		if error.lnum == 0
			continue
		endif
		let item         = {}
		let item["lnum"] = error.lnum
		let item["text"] = error.text
		let b:error_list[error.lnum] = item
		let type = error.type == "W" ? "ErlangWarning" : "ErlangError"
		execute "sign place" b:next_sign_id "line=" . item.lnum "name=" . type "file=" . expand("%:p")
		let b:next_sign_id += 1
	endfor
	setlocal shellpipe&
	setlocal makeprg=make
endfunction

function s:ShowErrorMsg()
	let pos = getpos(".")
	if has_key(b:error_list, pos[1])
		let item = get(b:error_list, pos[1])
		echo item.text
		let b:is_showing_msg = 1
	else
		if b:is_showing_msg
			echo
			let b:is_showing_msg = 0
		endif
	endif
endf

function s:ClearErrors()
	sign unplace *
	let b:error_list   = {}
	let b:next_sign_id = 1
	if b:is_showing_msg
		echo
		let b:is_showing_msg = 0
	endif
endfunction

function s:EnableShowErrors()
	if !s:autocmds_defined
		augroup vimerl
			autocmd!
			autocmd BufWritePre  *.erl call s:ClearErrors()
			autocmd BufWritePost *.erl call s:ShowErrors()
			autocmd CursorHold   *.erl call s:ShowErrorMsg()
			autocmd CursorMoved  *.erl call s:ShowErrorMsg()
		augroup END
		let s:autocmds_defined = 1
	endif
endfunction

function s:DisableShowErrors()
	sign unplace *
	augroup vimerl
		autocmd!
	augroup END
	let s:autocmds_defined = 0
endfunction

if g:erlang_show_errors
	call s:EnableShowErrors()
endif
