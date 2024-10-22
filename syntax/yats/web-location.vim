if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-location.vim')
  finish
endif

syntax keyword typescriptBOMLocationProp contained href protocol host hostname port
syntax keyword typescriptBOMLocationProp contained pathname search hash username password
syntax keyword typescriptBOMLocationProp contained origin
syntax cluster props add=typescriptBOMLocationProp
hi def link typescriptBOMLocationProp Keyword
syntax keyword typescriptBOMLocationMethod contained assign reload replace toString nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptBOMLocationMethod
hi def link typescriptBOMLocationMethod Keyword
