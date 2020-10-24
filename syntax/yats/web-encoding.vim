let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/web-encoding.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptEncodingGlobal containedin=typescriptIdentifierName TextEncoder
syntax keyword typescriptEncodingGlobal containedin=typescriptIdentifierName TextDecoder
if exists("did_typescript_hilink") | HiLink typescriptEncodingGlobal Structure
endif
syntax keyword typescriptEncodingProp contained encoding fatal ignoreBOM
syntax cluster props add=typescriptEncodingProp
if exists("did_typescript_hilink") | HiLink typescriptEncodingProp Keyword
endif
syntax keyword typescriptEncodingMethod contained encode decode nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptEncodingMethod
if exists("did_typescript_hilink") | HiLink typescriptEncodingMethod Keyword
endif

endif
