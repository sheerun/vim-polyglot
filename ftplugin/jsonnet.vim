let files = filter(globpath(&rtp, 'ftplugin/jsonnet.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jsonnet') == -1




" -- fmt
command! -nargs=0 JsonnetFmt call jsonnet#Format()

setlocal commentstring=//\ %s



endif
