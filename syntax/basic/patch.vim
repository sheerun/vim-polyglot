let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/basic/patch.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

" patch for generated code
syntax keyword typescriptGlobal Promise
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline
syntax keyword typescriptGlobal Map WeakMap
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline

endif
