let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'compiler/cs.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cs') == -1

" Vim compiler file
" Compiler:               Microsoft Visual Studio C#
" Maintainer:             Yichao Zhou (broken.zhou@gmail.com)
" Previous Maintainer:    Joseph H. Yao (hyao@sina.com)
" Last Change:            Jul 22, 2019

if exists("current_compiler")
  finish
endif
let current_compiler = "cs"
let s:keepcpo= &cpo
set cpo&vim

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat&
CompilerSet errorformat+=%f(%l\\,%v):\ %t%*[^:]:\ %m,
            \%trror%*[^:]:\ %m,
            \%tarning%*[^:]:\ %m

CompilerSet makeprg=csc\ %:S

let &cpo = s:keepcpo
unlet s:keepcpo

endif
