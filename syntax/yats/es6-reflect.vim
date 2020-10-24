let files = filter(globpath(&rtp, 'syntax/yats/es6-reflect.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Reflect
syntax keyword typescriptReflectMethod contained apply construct defineProperty deleteProperty nextgroup=typescriptFuncCallArg
syntax keyword typescriptReflectMethod contained enumerate get getOwnPropertyDescriptor nextgroup=typescriptFuncCallArg
syntax keyword typescriptReflectMethod contained getPrototypeOf has isExtensible ownKeys nextgroup=typescriptFuncCallArg
syntax keyword typescriptReflectMethod contained preventExtensions set setPrototypeOf nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptReflectMethod
if exists("did_typescript_hilink") | HiLink typescriptReflectMethod Keyword
endif

endif
