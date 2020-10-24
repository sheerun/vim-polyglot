let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/hcl.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hcl') == -1

if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

" cindent seems to work adequately with HCL's brace-y syntax
setlocal cindent

" don't de-indent comments (cindent treats them like preprocessor directives)
setlocal cinkeys-=0#

endif
