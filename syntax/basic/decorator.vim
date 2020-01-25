if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax match typescriptDecorator /@\([_$a-zA-Z][_$a-zA-Z0-9]*\.\)*[_$a-zA-Z][_$a-zA-Z0-9]*\>/
  \ nextgroup=typescriptFuncCallArg,typescriptTypeArguments
  \ contains=@_semantic,typescriptDotNotation

endif
