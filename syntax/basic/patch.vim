if !polyglot#util#IsEnabled('typescript', expand('<sfile>:p'))
  finish
endif

" patch for generated code
syntax keyword typescriptGlobal Promise
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline
syntax keyword typescriptGlobal Map WeakMap
  \ nextgroup=typescriptGlobalPromiseDot,typescriptFuncCallArg,typescriptTypeArguments oneline
