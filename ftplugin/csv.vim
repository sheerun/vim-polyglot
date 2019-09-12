if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'csv') == -1

" Filetype plugin for editing CSV files. "{{{1
" Author:  Christian Brabandt <cb@256bit.org>
" Version: 0.31
" Script:  http://www.vim.org/scripts/script.php?script_id=2830
" License: VIM License
" Last Change: Thu, 15 Jan 2015 21:05:10 +0100
" Documentation: see :help ft-csv.txt
" GetLatestVimScripts: 2830 30 :AutoInstall: csv.vim
"
" Some ideas are taken from the wiki http://vim.wikia.com/wiki/VimTip667
" though, implementation differs.

" Plugin folklore "{{{1
if v:version < 700 || exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" Initialize Plugin "{{{2
" useful for configuring how many lines to analyze,
" set if you notice a slowdown
let b:csv_start = get(g:, 'csv_start', 1)
let b:csv_end   = get(g:, 'csv_end', line('$'))
let b:csv_result = ''

call csv#Init(b:csv_start, b:csv_end)
let &cpo = s:cpo_save
unlet s:cpo_save

" Vim Modeline " {{{2
" vim: set foldmethod=marker et sw=0 sts=-1 ts=4:

endif
