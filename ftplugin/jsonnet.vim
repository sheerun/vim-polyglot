if has_key(g:polyglot_is_disabled, 'jsonnet')
  finish
endif




" -- fmt
command! -nargs=0 JsonnetFmt call jsonnet#Format()

setlocal commentstring=//\ %s


