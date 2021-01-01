if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/yats/ecma-402.vim')
  finish
endif

syntax keyword typescriptGlobal containedin=typescriptIdentifierName Intl
syntax keyword typescriptIntlMethod contained Collator DateTimeFormat NumberFormat nextgroup=typescriptFuncCallArg
syntax keyword typescriptIntlMethod contained PluralRules nextgroup=typescriptFuncCallArg
syntax cluster props add=typescriptIntlMethod
if exists("did_typescript_hilink") | HiLink typescriptIntlMethod Keyword
endif
