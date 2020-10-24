let files = filter(globpath(&rtp, 'ftplugin/logcheck.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'logcheck') == -1

" Vim filetype plugin file
" Language:    Logcheck
" Maintainer:  Debian Vim Maintainers
" Last Change: 2018 Dec 27
" License:     Vim License
" URL: https://salsa.debian.org/vim-team/vim-debian/blob/master/ftplugin/logcheck.vim

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = 'setl fo<'

" Do not hard-wrap non-comment lines since each line is a self-contained
" regular expression
setlocal formatoptions-=t

endif
