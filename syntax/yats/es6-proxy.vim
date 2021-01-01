if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/es6-proxy.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Proxy
syntax keyword typescriptProxyAPI contained getOwnPropertyDescriptor getOwnPropertyNames
syntax keyword typescriptProxyAPI contained defineProperty deleteProperty freeze seal
syntax keyword typescriptProxyAPI contained preventExtensions has hasOwn get set enumerate
syntax keyword typescriptProxyAPI contained iterate ownKeys apply construct
if exists("did_typescript_hilink") | HiLink typescriptProxyAPI Keyword
endif
