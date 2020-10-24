let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/es6-set.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Set WeakSet
syntax keyword typescriptES6SetProp contained size
syntax cluster props add=typescriptES6SetProp
if exists("did_typescript_hilink") | HiLink typescriptES6SetProp Keyword
endif
syntax keyword typescriptES6SetMethod contained add clear delete entries forEach has nextgroup=typescriptFuncCallArg
syntax keyword typescriptES6SetMethod contained values nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptES6SetMethod
if exists("did_typescript_hilink") | HiLink typescriptES6SetMethod Keyword
endif

endif
