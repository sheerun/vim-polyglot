let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/mf.vim', 1, 1), Filter)
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
