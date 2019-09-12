if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Function
syntax keyword typescriptFunctionMethod contained apply bind call nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptFunctionMethod
if exists("did_typescript_hilink") | HiLink typescriptFunctionMethod Keyword
endif

endif
