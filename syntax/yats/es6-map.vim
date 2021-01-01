if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-map.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Map WeakMap
syntax keyword typescriptES6MapProp contained size
syntax cluster props add=typescriptES6MapProp
if exists("did_typescript_hilink") | HiLink typescriptES6MapProp Keyword
endif
syntax keyword typescriptES6MapMethod contained clear delete entries forEach get has nextgroup=typescriptFuncCallArg
syntax keyword typescriptES6MapMethod contained keys set values nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptES6MapMethod
if exists("did_typescript_hilink") | HiLink typescriptES6MapMethod Keyword
endif
