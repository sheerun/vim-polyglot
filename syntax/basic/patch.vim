if has_key(g:polyglot_is_disabled, 'typescript')
  finish
endif

" patch for generated code
syntax keyword typescriptGlobal Promise
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline
syntax keyword typescriptGlobal Map WeakMap
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline
