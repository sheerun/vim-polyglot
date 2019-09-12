if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Geolocation
syntax keyword typescriptGeolocationMethod contained getCurrentPosition watchPosition nextgroup=typescriptFuncCallArg
syntax keyword typescriptGeolocationMethod contained clearWatch nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptGeolocationMethod
if exists("did_typescript_hilink") | HiLink typescriptGeolocationMethod Keyword
endif

endif
