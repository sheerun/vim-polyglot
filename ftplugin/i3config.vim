let files = filter(globpath(&rtp, 'ftplugin/i3config.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'i3') == -1

setlocal commentstring=#\ %s

endif
