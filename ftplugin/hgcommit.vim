let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/hgcommit.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hgcommit') == -1

" Vim filetype plugin file
" Language:	hg (Mercurial) commit file
" Maintainer:	Ken Takata <kentkt at csc dot jp>
" Last Change:	2016 Jan 6
" Filenames:	hg-editor-*.txt
" License:	VIM License
" URL:		https://github.com/k-takata/hg-vim

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal nomodeline

let b:undo_ftplugin = 'setl modeline<'

endif
