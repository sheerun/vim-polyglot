if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-reflect.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Reflect
syntax keyword typescriptReflectMethod contained apply construct defineProperty deleteProperty nextgroup=typescriptFuncCallArg
syntax keyword typescriptReflectMethod contained enumerate get getOwnPropertyDescriptor nextgroup=typescriptFuncCallArg
syntax keyword typescriptReflectMethod contained getPrototypeOf has isExtensible ownKeys nextgroup=typescriptFuncCallArg
syntax keyword typescriptReflectMethod contained preventExtensions set setPrototypeOf nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptReflectMethod
if exists("did_typescript_hilink") | HiLink typescriptReflectMethod Keyword
endif
