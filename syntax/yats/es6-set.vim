if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-set.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Set WeakSet
syntax keyword typescriptES6SetProp contained size
syntax cluster props add=typescriptES6SetProp
hi def link typescriptES6SetProp Keyword
syntax keyword typescriptES6SetMethod contained add clear delete entries forEach has nextgroup=typescriptFuncCallArg
syntax keyword typescriptES6SetMethod contained values nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptES6SetMethod
hi def link typescriptES6SetMethod Keyword
