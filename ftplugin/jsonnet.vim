if !polyglot#util#IsEnabled('jsonnet', expand('<sfile>:p'))
  finish
endif




" -- fmt
command! -nargs=0 JsonnetFmt call jsonnet#Format()

setlocal commentstring=//\ %s


