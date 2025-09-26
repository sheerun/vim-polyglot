if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-service-worker.vim')
  finish
endif

syntax keyword typescriptServiceWorkerProp contained controller ready
syntax cluster props add=typescriptServiceWorkerProp
hi def link typescriptServiceWorkerProp Keyword
syntax keyword typescriptServiceWorkerMethod contained register getRegistration nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptServiceWorkerMethod
hi def link typescriptServiceWorkerMethod Keyword
syntax keyword typescriptGlobal containedin=typescriptIdentifierName Cache
syntax keyword typescriptCacheMethod contained match matchAll add addAll put delete nextgroup=typescriptFuncCallArg
syntax keyword typescriptCacheMethod contained keys nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptCacheMethod
hi def link typescriptCacheMethod Keyword
