if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Array nextgroup=typescriptGlobalArrayDot,typescriptFuncCallArg
syntax match   typescriptGlobalArrayDot /\./ contained nextgroup=typescriptArrayStaticMethod,typescriptProp
syntax keyword typescriptArrayStaticMethod contained from isArray of nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptArrayStaticMethod Keyword
endif
syntax keyword typescriptArrayMethod contained concat copyWithin entries every fill nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained filter find findIndex forEach indexOf nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained includes join keys lastIndexOf map nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained pop push reduce reduceRight reverse nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained shift slice some sort splice toLocaleString nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained toSource toString unshift nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptArrayMethod
if exists("did_typescript_hilink") | HiLink typescriptArrayMethod Keyword
endif

endif
