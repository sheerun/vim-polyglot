if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jsonnet') == -1




" -- fmt
command! -nargs=0 JsonnetFmt call jsonnet#Format()

setlocal commentstring=//\ %s



endif
