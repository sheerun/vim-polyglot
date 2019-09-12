if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'applescript') == -1

"Plugin Name: applescript indent file.
"Author: mityu
"Last Change: 02-May-2017.

let s:cpo_save=&cpo
set cpo&vim

setlocal indentexpr=GetAppleScriptIndent()
setlocal indentkeys+=0=end,0=else,=error

func! GetAppleScriptIndent()
	let l:ignorecase_save=&ignorecase
	try
		let &ignorecase=0
		return s:returnAppleScriptIndent()
	finally
		let &ignorecase=l:ignorecase_save
	endtry
endfunc

func! s:returnAppleScriptIndent()
	let l:current_text=getline(v:lnum)

	let l:prev_line=prevnonblank(v:lnum-1)

	"At the start of the file, use 0 indent.
	if l:prev_line==0
		return 0
	endif

	let l:prev_line_save=l:prev_line
	let l:prev_line=s:prev_non_connected_line(l:prev_line)

	let l:indent=indent(l:prev_line)

	if l:prev_line_save-l:prev_line==1
		"連結開始
		let l:indent+=shiftwidth()*2
	elseif l:prev_line_save-l:prev_line>=2
		"絶賛連結中
		"その時は前の行のインデントをそのまま流用する
		return indent(l:prev_line_save)
	elseif l:prev_line_save==l:prev_line && s:doesOrderConnect(getline(l:prev_line-1))
		"前の行が連結される行の最終行の場合
		let l:prev_line=s:prev_non_connected_line(l:prev_line-1)
		if l:prev_line==0 | let l:prev_line=1 | endif
		let l:indent=indent(l:prev_line)
	endif

	let l:prev_text=getline(l:prev_line)
	if l:prev_text=~'^\s*\(on\|\(tell\(.*\<to\>\)\@!\)\|repeat\|try\|if\|else\)'
		let l:indent+=shiftwidth()
	endif

	if l:current_text=~'^\s*\(end\|else\|on\serror\)'
		let l:indent-=shiftwidth()
	endif

	return l:indent
endfunc

func! s:prev_non_connected_line(line)
	let l:prev_line=prevnonblank(a:line)
	while l:prev_line>0 && s:doesOrderConnect(getline(l:prev_line))
		let l:prev_line-=1
	endwhile
	return l:prev_line
endfunc

func! s:doesOrderConnect(text)
	return a:text=~'¬$'
endfunc

let &cpo=s:cpo_save
unlet s:cpo_save

" vim: foldmethod=marker

endif
