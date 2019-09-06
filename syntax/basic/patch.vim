if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'typescript') != -1
  finish
endif

" patch for generated code
syntax keyword typescriptGlobal Promise
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline
syntax keyword typescriptGlobal Map WeakMap
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline
