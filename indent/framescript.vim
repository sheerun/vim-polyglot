let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/framescript.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'framescript') == -1

" Vim indent file
" Language:             FrameScript
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2008-07-19

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetFrameScriptIndent()
setlocal indentkeys=!^F,o,O,0=~Else,0=~EndIf,0=~EndLoop,0=~EndSub
setlocal nosmartindent

if exists("*GetFrameScriptIndent")
  finish
endif

function GetFrameScriptIndent()
  let lnum = prevnonblank(v:lnum - 1)

  if lnum == 0
    return 0
  endif

  if getline(v:lnum) =~ '^\s*\*'
    return cindent(v:lnum)
  endif

  let ind = indent(lnum)

  if getline(lnum) =~? '^\s*\%(If\|Loop\|Sub\)'
    let ind = ind + shiftwidth()
  endif

  if getline(v:lnum) =~? '^\s*\%(Else\|End\%(If\|Loop\|Sub\)\)'
    let ind = ind - shiftwidth()
  endif

  return ind
endfunction

endif
