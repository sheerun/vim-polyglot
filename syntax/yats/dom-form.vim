if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

syntax keyword typescriptDOMFormProp contained acceptCharset action elements encoding
syntax keyword typescriptDOMFormProp contained enctype length method name target
syntax cluster props add=typescriptDOMFormProp
if exists("did_typescript_hilink") | HiLink typescriptDOMFormProp Keyword
endif
syntax keyword typescriptDOMFormMethod contained reportValidity reset submit nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptDOMFormMethod
if exists("did_typescript_hilink") | HiLink typescriptDOMFormMethod Keyword
endif
