let files = filter(globpath(&rtp, 'ftplugin/raml.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'raml') == -1

set ts=2 sts=2 sw=2 et

endif
