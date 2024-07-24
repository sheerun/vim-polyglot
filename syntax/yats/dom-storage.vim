if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/dom-storage.vim')
  finish
endif

syntax keyword typescriptDOMStorage contained sessionStorage localStorage
hi def link typescriptDOMStorage Keyword
syntax keyword typescriptDOMStorageProp contained length
syntax cluster props add=typescriptDOMStorageProp
hi def link typescriptDOMStorageProp Keyword
syntax keyword typescriptDOMStorageMethod contained getItem key setItem removeItem nextgroup=typescriptFuncCallArg
syntax keyword typescriptDOMStorageMethod contained clear nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptDOMStorageMethod
hi def link typescriptDOMStorageMethod Keyword
