let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/web-geo.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Geolocation
syntax keyword typescriptGeolocationMethod contained getCurrentPosition watchPosition nextgroup=typescriptFuncCallArg
syntax keyword typescriptGeolocationMethod contained clearWatch nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptGeolocationMethod
if exists("did_typescript_hilink") | HiLink typescriptGeolocationMethod Keyword
endif

endif
