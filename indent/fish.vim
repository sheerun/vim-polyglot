let files = filter(globpath(&rtp, 'indent/fish.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fish') == -1

setlocal indentexpr=fish#Indent()
setlocal indentkeys+==end,=else,=case

endif
