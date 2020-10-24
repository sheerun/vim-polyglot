let files = filter(globpath(&rtp, 'ftplugin/automake.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'automake') == -1

" Vim filetype plugin file
" Language:             Automake
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2008-07-09

if exists("b:did_ftplugin")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

runtime! ftplugin/make.vim ftplugin/make_*.vim ftplugin/make/*.vim

let &cpo = s:cpo_save
unlet s:cpo_save

endif
