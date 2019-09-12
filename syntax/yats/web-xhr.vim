if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptXHRGlobal containedin=typescriptIdentifierName XMLHttpRequest
if exists("did_typescript_hilink") | HiLink typescriptXHRGlobal Structure
endif
syntax keyword typescriptXHRProp contained onreadystatechange readyState response
syntax keyword typescriptXHRProp contained responseText responseType responseXML status
syntax keyword typescriptXHRProp contained statusText timeout ontimeout upload withCredentials
syntax cluster props add=typescriptXHRProp
if exists("did_typescript_hilink") | HiLink typescriptXHRProp Keyword
endif
syntax keyword typescriptXHRMethod contained abort getAllResponseHeaders getResponseHeader nextgroup=typescriptFuncCallArg
syntax keyword typescriptXHRMethod contained open overrideMimeType send setRequestHeader nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptXHRMethod
if exists("did_typescript_hilink") | HiLink typescriptXHRMethod Keyword
endif

endif
