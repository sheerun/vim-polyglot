if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptDOMStorage contained sessionStorage localStorage
if exists("did_typescript_hilink") | HiLink typescriptDOMStorage Keyword
endif
syntax keyword typescriptDOMStorageProp contained length
syntax cluster props add=typescriptDOMStorageProp
if exists("did_typescript_hilink") | HiLink typescriptDOMStorageProp Keyword
endif
syntax keyword typescriptDOMStorageMethod contained getItem key setItem removeItem nextgroup=typescriptFuncCallArg
syntax keyword typescriptDOMStorageMethod contained clear nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptDOMStorageMethod
if exists("did_typescript_hilink") | HiLink typescriptDOMStorageMethod Keyword
endif
