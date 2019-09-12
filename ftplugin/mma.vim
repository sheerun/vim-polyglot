if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mathematica') == -1

"Vim filetype plugin
" Language: Mathematica
" Maintainer: R. Menon <rsmenon@icloud.com>
" Last Change: Feb 26, 2013

" Initialization {
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim
"}

" Syntax completion function {
if exists('&ofu')
	setlocal omnifunc=syntaxcomplete#Complete
	setlocal completefunc=syntaxcomplete#Complete
endif
"}

" Main functions {
if has('python')
	" Random ID generator {
	function! RandomID()

"Python implementation follows; do not alter indentations/whitespace
python << EOF
import random, string, vim
vim.command("let l:id = '" + (''.join(random.sample(string.ascii_uppercase + string.digits, 8))) + "'")
EOF

	return l:id
	endfunction
	"}

	"Unit test template {
	function! Test()
		if exists("*strftime")
			let l:date = strftime("%Y%m%d") . "-"
		else
			let l:date = ""
		endif

		let l:testid = expand("%:t") . "-" . l:date . RandomID()
		let l:template = "Test[\rtest\r,\rresult\r,\rTestID -> \"" . l:testid . "\"\r\b]"
		exe ":normal i" . l:template
	endfunction
	"}
endif
"}

" Cleanup {
let &cpo = s:cpo_save
unlet s:cpo_save
"}

" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

endif
