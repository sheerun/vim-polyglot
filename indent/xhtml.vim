let files = filter(globpath(&rtp, 'indent/xhtml.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xhtml') == -1

" Vim indent file
" Language:	XHTML
" Maintainer:	Bram Moolenaar <Bram@vim.org> (for now)
" Last Change:	2005 Jun 24

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

" Handled like HTML for now.
runtime! indent/html.vim

endif
