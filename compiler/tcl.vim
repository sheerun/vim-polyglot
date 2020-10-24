let files = filter(globpath(&rtp, 'compiler/tcl.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tcl') == -1

" Vim compiler file
" Compiler:	tcl
" Maintainer:	Doug Kearns <dougkearns@gmail.com>
" Last Change:	2004 Nov 27

if exists("current_compiler")
  finish
endif
let current_compiler = "tcl"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=tcl

CompilerSet errorformat=%EError:\ %m,%+Z\ %\\{4}(file\ \"%f\"\ line\ %l),%-G%.%#

endif
