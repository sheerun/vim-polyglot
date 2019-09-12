if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptServiceWorkerProp contained controller ready
syntax cluster props add=typescriptServiceWorkerProp
if exists("did_typescript_hilink") | HiLink typescriptServiceWorkerProp Keyword
endif
syntax keyword typescriptServiceWorkerMethod contained register getRegistration nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptServiceWorkerMethod
if exists("did_typescript_hilink") | HiLink typescriptServiceWorkerMethod Keyword
endif
syntax keyword typescriptGlobal containedin=typescriptIdentifierName Cache
syntax keyword typescriptCacheMethod contained match matchAll add addAll put delete nextgroup=typescriptFuncCallArg
syntax keyword typescriptCacheMethod contained keys nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptCacheMethod
if exists("did_typescript_hilink") | HiLink typescriptCacheMethod Keyword
endif

endif
