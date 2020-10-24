let files = filter(globpath(&rtp, 'indent/mf.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mf') == -1

" METAFONT indent file
" Language:    METAFONT
" Maintainer:  Nicola Vitacolonna <nvitacolonna@gmail.com>
" Last Change: 2016 Oct 1

runtime! indent/mp.vim

endif
