let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/htmldjango.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'htmldjango') == -1

" Vim filetype plugin file
" Language:	Django HTML template
" Maintainer:	Dave Hodder <dmh@dmh.org.uk>
" Last Change:	2007 Jan 25

" Only use this filetype plugin when no other was loaded.
if exists("b:did_ftplugin")
  finish
endif

" Use HTML and Django template ftplugins.
runtime! ftplugin/html.vim
runtime! ftplugin/django.vim

endif
