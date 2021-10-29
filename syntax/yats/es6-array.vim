if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-array.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Array nextgroup=typescriptGlobalArrayDot,typescriptFuncCallArg
syntax match   typescriptGlobalArrayDot /\./ contained nextgroup=typescriptArrayStaticMethod,typescriptProp
syntax keyword typescriptArrayStaticMethod contained from isArray of nextgroup=typescriptFuncCallArg
if exists("did_typescript_hilink") | HiLink typescriptArrayStaticMethod Keyword
endif
syntax keyword typescriptArrayMethod contained concat copyWithin entries every fill nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained filter find findIndex flat flatMap forEach nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained includes indexOf join keys lastIndexOf map nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained pop push reduce reduceRight reverse nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained shift slice some sort splice toLocaleString nextgroup=typescriptFuncCallArg
syntax keyword typescriptArrayMethod contained toSource toString unshift values nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptArrayMethod
if exists("did_typescript_hilink") | HiLink typescriptArrayMethod Keyword
endif
