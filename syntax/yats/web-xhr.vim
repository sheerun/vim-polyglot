if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/web-xhr.vim')
  finish
endif

syntax keyword typescriptXHRGlobal containedin=typescriptIdentifierName XMLHttpRequest
hi def link typescriptXHRGlobal Structure
syntax keyword typescriptXHRProp contained onreadystatechange readyState response
syntax keyword typescriptXHRProp contained responseText responseType responseXML status
syntax keyword typescriptXHRProp contained statusText timeout ontimeout upload withCredentials
syntax cluster props add=typescriptXHRProp
hi def link typescriptXHRProp Keyword
syntax keyword typescriptXHRMethod contained abort getAllResponseHeaders getResponseHeader nextgroup=typescriptFuncCallArg
syntax keyword typescriptXHRMethod contained open overrideMimeType send setRequestHeader nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptXHRMethod
hi def link typescriptXHRMethod Keyword
