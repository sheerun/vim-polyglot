if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Set WeakSet
syntax keyword typescriptES6SetProp contained size
syntax cluster props add=typescriptES6SetProp
if exists("did_typescript_hilink") | HiLink typescriptES6SetProp Keyword
endif
syntax keyword typescriptES6SetMethod contained add clear delete entries forEach has nextgroup=typescriptFuncCallArg
syntax keyword typescriptES6SetMethod contained values nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptES6SetMethod
if exists("did_typescript_hilink") | HiLink typescriptES6SetMethod Keyword
endif
