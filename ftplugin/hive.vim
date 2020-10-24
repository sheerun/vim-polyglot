let files = filter(globpath(&rtp, 'ftplugin/hive.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hive') == -1

setlocal comments=:--
setlocal commentstring=--\ %s

endif
