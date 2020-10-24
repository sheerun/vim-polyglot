let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'syntax/yats/web-xhr.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
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
