let files = filter(globpath(&rtp, 'indent/opencl.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'opencl') == -1

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

if version > 600
  runtime! indent/c.vim
endif

let b:did_indent = 1

endif
