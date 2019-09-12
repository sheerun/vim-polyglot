if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1

" vifm command-line editing buffer filetype plugin
" Maintainer:  xaizek <xaizek@posteo.net>
" Last Change: August 18, 2013

if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Behave as vifm script file
runtime! ftplugin/vifm.vim

" Use vifm script highlighting
set syntax=vifm

call vifm#edit#Init()

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab cinoptions-=(0 :

endif
