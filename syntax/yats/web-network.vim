if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-network.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName NetworkInformation
syntax keyword typescriptBOMNetworkProp contained downlink downlinkMax effectiveType
syntax keyword typescriptBOMNetworkProp contained rtt type
syntax cluster props add=typescriptBOMNetworkProp
if exists("did_typescript_hilink") | HiLink typescriptBOMNetworkProp Keyword
endif
