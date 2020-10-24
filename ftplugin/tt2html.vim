let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/tt2html.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1

" Language:      TT2 embedded with HTML
" Maintainer:    vim-perl <vim-perl@googlegroups.com>
" Homepage:      http://github.com/vim-perl/vim-perl
" Bugs/requests: http://github.com/vim-perl/vim-perl/issues
" Last Change:   {{LAST_CHANGE}}

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif

" Just use the HTML plugin for now.
runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim

endif
