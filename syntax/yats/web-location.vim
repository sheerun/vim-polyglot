let files = filter(globpath(&rtp, 'syntax/yats/web-location.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
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
