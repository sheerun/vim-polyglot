if !polyglot#util#IsEnabled('typescript', expand('<sfile>:p'))
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Geolocation
syntax keyword typescriptGeolocationMethod contained getCurrentPosition watchPosition nextgroup=typescriptFuncCallArg
syntax keyword typescriptGeolocationMethod contained clearWatch nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptGeolocationMethod
if exists("did_typescript_hilink") | HiLink typescriptGeolocationMethod Keyword
endif
