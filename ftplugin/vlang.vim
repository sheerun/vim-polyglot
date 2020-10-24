let files = filter(globpath(&rtp, 'ftplugin/vlang.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'v') == -1

setlocal commentstring=//\ %s
setlocal makeprg=v\ %

endif
