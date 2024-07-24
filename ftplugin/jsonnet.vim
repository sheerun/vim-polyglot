if polyglot#init#is_disabled(expand('<sfile>:p'), 'jsonnet', 'ftplugin/jsonnet.vim')
  finish
endif




" -- fmt
command! -nargs=0 JsonnetFmt call jsonnet#Format()

" -- eval
command! -nargs=0 JsonnetEval call jsonnet#Eval()

setlocal commentstring=//\ %s


