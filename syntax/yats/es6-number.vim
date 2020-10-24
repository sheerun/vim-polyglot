let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/es6-number.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Number nextgroup=typescriptGlobalNumberDot,typescriptFuncCallArg
syntax match   typescriptGlobalNumberDot /\./ contained nextgroup=typescriptNumberStaticProp,typescriptNumberStaticMethod,typescriptProp
syntax keyword typescriptNumberStaticProp contained EPSILON MAX_SAFE_INTEGER MAX_VALUE
syntax keyword typescriptNumberStaticProp contained MIN_SAFE_INTEGER MIN_VALUE NEGATIVE_INFINITY
syntax keyword typescriptNumberStaticProp contained NaN POSITIVE_INFINITY
if exists("did_typescript_hilink") | HiLink typescriptNumberStaticProp Keyword
endif
syntax keyword typescriptNumberStaticMethod contained isFinite isInteger isNaN isSafeInteger nextgroup=typescriptFuncCallArg
syntax keyword typescriptNumberStaticMethod contained parseFloat parseInt nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptNumberStaticMethod Keyword
endif
syntax keyword typescriptNumberMethod contained toExponential toFixed toLocaleString nextgroup=typescriptFuncCallArg
syntax keyword typescriptNumberMethod contained toPrecision toSource toString valueOf nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptNumberMethod
if exists("did_typescript_hilink") | HiLink typescriptNumberMethod Keyword
endif

endif
