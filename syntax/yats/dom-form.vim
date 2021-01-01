if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/dom-form.vim')
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
