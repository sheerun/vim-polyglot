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
