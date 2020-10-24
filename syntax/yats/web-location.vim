let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/web-location.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptBOMLocationProp contained href protocol host hostname port
syntax keyword typescriptBOMLocationProp contained pathname search hash username password
syntax keyword typescriptBOMLocationProp contained origin
syntax cluster props add=typescriptBOMLocationProp
if exists("did_typescript_hilink") | HiLink typescriptBOMLocationProp Keyword
endif
syntax keyword typescriptBOMLocationMethod contained assign reload replace toString nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptBOMLocationMethod
if exists("did_typescript_hilink") | HiLink typescriptBOMLocationMethod Keyword
endif

endif
