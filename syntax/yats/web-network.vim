let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/web-network.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName NetworkInformation
syntax keyword typescriptBOMNetworkProp contained downlink downlinkMax effectiveType
syntax keyword typescriptBOMNetworkProp contained rtt type
syntax cluster props add=typescriptBOMNetworkProp
if exists("did_typescript_hilink") | HiLink typescriptBOMNetworkProp Keyword
endif

endif
