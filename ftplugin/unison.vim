if polyglot#init#is_disabled(expand('<sfile>:p'), 'unison', 'ftplugin/unison.vim')
  finish
endif

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=--\ %s
setlocal iskeyword+=!,'
" setlocal tabstop=2
" setlocal softtabstop=2
" setlocal shiftwidth=2
" setlocal completefunc=syntaxcomplete#Complete
