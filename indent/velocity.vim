let files = filter(globpath(&rtp, 'indent/velocity.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'velocity') == -1

if exists("b:did_indent")
    finish
endif

runtime! indent/html.vim

endif
