if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-geo.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Geolocation
syntax keyword typescriptGeolocationMethod contained getCurrentPosition watchPosition nextgroup=typescriptFuncCallArg
syntax keyword typescriptGeolocationMethod contained clearWatch nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptGeolocationMethod
if exists("did_typescript_hilink") | HiLink typescriptGeolocationMethod Keyword
endif
