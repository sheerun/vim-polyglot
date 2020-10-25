if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Function
syntax keyword typescriptFunctionMethod contained apply bind call nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptFunctionMethod
if exists("did_typescript_hilink") | HiLink typescriptFunctionMethod Keyword
endif
