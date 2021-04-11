if polyglot#init#is_disabled(expand('<sfile>:p'), 'sxhkd', 'ftplugin/sxhkdrc.vim')
  finish
endif

if exists("b:did_ftplugin")
	finish
endif

setlocal cms=#%s

if exists('b:undo_ftplugin')
	let b:undo_ftplugin .= "|setlocal commentstring<"
else
	let b:undo_ftplugin = "setlocal commentstring<"
endif
