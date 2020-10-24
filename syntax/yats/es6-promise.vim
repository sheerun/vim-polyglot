let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/es6-promise.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Promise nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg
syntax match   typescriptGlobalPromiseDot /\./ contained nextgroup=typescriptPromiseStaticMethod,typescriptProp
syntax keyword typescriptPromiseStaticMethod contained resolve reject all race nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptPromiseStaticMethod Keyword
endif
syntax keyword typescriptPromiseMethod contained then catch finally nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptPromiseMethod
if exists("did_typescript_hilink") | HiLink typescriptPromiseMethod Keyword
endif

endif
