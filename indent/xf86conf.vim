let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/xf86conf.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xf86conf') == -1

" Vim indent file
" Language:             XFree86 Configuration File
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2006-12-20

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetXF86ConfIndent()
setlocal indentkeys=!^F,o,O,=End
setlocal nosmartindent

if exists("*GetXF86ConfIndent")
  finish
endif

function GetXF86ConfIndent()
  let lnum = prevnonblank(v:lnum - 1)

  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)

  if getline(lnum) =~? '^\s*\(Sub\)\=Section\>'
    let ind = ind + shiftwidth()
  endif

  if getline(v:lnum) =~? '^\s*End\(Sub\)\=Section\>'
    let ind = ind - shiftwidth()
  endif

  return ind
endfunction

endif
