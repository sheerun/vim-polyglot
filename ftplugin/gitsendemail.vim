if polyglot#init#is_disabled(expand('<sfile>:p'), 'git', 'ftplugin/gitsendemail.vim')
  finish
endif

" Vim filetype plugin
" Language:	git send-email message
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2009 Dec 24

runtime! ftplugin/mail.vim
