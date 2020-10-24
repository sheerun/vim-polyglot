let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/gitsendemail.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'git') == -1

" Vim filetype plugin
" Language:	git send-email message
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2009 Dec 24

runtime! ftplugin/mail.vim

endif
