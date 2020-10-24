let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/es6-json.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName JSON nextgroup=typescriptGlobalJSONDot,typescriptFuncCallArg
syntax match   typescriptGlobalJSONDot /\./ contained nextgroup=typescriptJSONStaticMethod,typescriptProp
syntax keyword typescriptJSONStaticMethod contained parse stringify nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptJSONStaticMethod Keyword
endif

endif
