if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-history.vim')
  finish
endif

syntax keyword typescriptBOMHistoryProp contained length current next previous state
syntax keyword typescriptBOMHistoryProp contained scrollRestoration
syntax cluster props add=typescriptBOMHistoryProp
hi def link typescriptBOMHistoryProp Keyword
syntax keyword typescriptBOMHistoryMethod contained back forward go pushState replaceState nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptBOMHistoryMethod
hi def link typescriptBOMHistoryMethod Keyword
