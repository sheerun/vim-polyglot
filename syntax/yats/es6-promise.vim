if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-promise.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Promise nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg
syntax match   typescriptGlobalPromiseDot /\./ contained nextgroup=typescriptPromiseStaticMethod,typescriptProp
syntax keyword typescriptPromiseStaticMethod contained all allSettled any race reject resolve nextgroup=typescriptFuncCallArg
hi def link typescriptPromiseStaticMethod Keyword
syntax keyword typescriptPromiseMethod contained then catch finally nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptPromiseMethod
hi def link typescriptPromiseMethod Keyword
