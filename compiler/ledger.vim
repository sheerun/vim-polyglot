if polyglot#init#is_disabled(expand('<sfile>:p'), 'ledger', 'compiler/ledger.vim')
  finish
endif

" Vim Compiler File
" Compiler:	ledger
" by Johann Klähn; Use according to the terms of the GPL>=2.
" vim:ts=2:sw=2:sts=2:foldmethod=marker

scriptencoding utf-8

if exists('current_compiler') || !exists('g:ledger_bin')
  finish
endif

let current_compiler = g:ledger_bin

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

if !exists('g:ledger_main')
  let g:ledger_main = '%'
endif

if !g:ledger_is_hledger
	" Capture Ledger errors (%-C ignores all lines between "While parsing..." and "Error:..."):
	CompilerSet errorformat=%EWhile\ parsing\ file\ \"%f\"\\,\ line\ %l:,%ZError:\ %m,%-C%.%#
	" Capture Ledger warnings:
	CompilerSet errorformat+=%tarning:\ \"%f\"\\,\ line\ %l:\ %m
	" Skip all other lines:
	CompilerSet errorformat+=%-G%.%#
	exe 'CompilerSet makeprg='.substitute(g:ledger_bin, ' ', '\\ ', 'g').'\ -f\ ' . substitute(shellescape(expand(g:ledger_main)), ' ', '\\ ', 'g') . '\ '.substitute(g:ledger_extra_options, ' ', '\\ ', 'g').'\ source\ ' . shellescape(expand(g:ledger_main))
else
	exe 'CompilerSet makeprg=('.substitute(g:ledger_bin, ' ', '\\ ', 'g').'\ -f\ ' . substitute(shellescape(expand(g:ledger_main)), ' ', '\\ ', 'g') . '\ print\ '.substitute(g:ledger_extra_options, ' ', '\\ ', 'g').'\ >\ /dev/null)'
endif
