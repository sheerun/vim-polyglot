if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1

" Vim indent file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327"

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

" smartindent is good enough for powershell
setlocal smartindent
" disable the indent removal for # marks
inoremap <buffer> # X#

let b:undo_indent = "setl si<"


endif
