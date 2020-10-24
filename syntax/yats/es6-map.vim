let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/es6-map.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Map WeakMap
syntax keyword typescriptES6MapProp contained size
syntax cluster props add=typescriptES6MapProp
if exists("did_typescript_hilink") | HiLink typescriptES6MapProp Keyword
endif
syntax keyword typescriptES6MapMethod contained clear delete entries forEach get has nextgroup=typescriptFuncCallArg
syntax keyword typescriptES6MapMethod contained keys set values nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptES6MapMethod
if exists("did_typescript_hilink") | HiLink typescriptES6MapMethod Keyword
endif

endif
