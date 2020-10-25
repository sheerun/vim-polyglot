if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName NetworkInformation
syntax keyword typescriptBOMNetworkProp contained downlink downlinkMax effectiveType
syntax keyword typescriptBOMNetworkProp contained rtt type
syntax cluster props add=typescriptBOMNetworkProp
if exists("did_typescript_hilink") | HiLink typescriptBOMNetworkProp Keyword
endif
