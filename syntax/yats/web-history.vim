if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptBOMHistoryProp contained length current next previous state
syntax keyword typescriptBOMHistoryProp contained scrollRestoration
syntax cluster props add=typescriptBOMHistoryProp
if exists("did_typescript_hilink") | HiLink typescriptBOMHistoryProp Keyword
endif
syntax keyword typescriptBOMHistoryMethod contained back forward go pushState replaceState nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptBOMHistoryMethod
if exists("did_typescript_hilink") | HiLink typescriptBOMHistoryMethod Keyword
endif
