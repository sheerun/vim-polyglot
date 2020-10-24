let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/readline.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'readline') == -1

" Vim indent file
" Language:             readline configuration file
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2006-12-20

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetReadlineIndent()
setlocal indentkeys=!^F,o,O,=$else,=$endif
setlocal nosmartindent

if exists("*GetReadlineIndent")
  finish
endif

function GetReadlineIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)

  if getline(lnum) =~ '^\s*$\(if\|else\)\>'
    let ind = ind + shiftwidth()
  endif

  if getline(v:lnum) =~ '^\s*$\(else\|endif\)\>'
    let ind = ind - shiftwidth()
  endif

  return ind
endfunction

endif
