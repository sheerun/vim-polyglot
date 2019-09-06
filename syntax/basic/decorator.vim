if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'typescript') != -1
  finish
endif

syntax match typescriptDecorator /@\([_$a-zA-Z][_$a-zA-Z0-9]*\.\)*[_$a-zA-Z][_$a-zA-Z0-9]*\>/
  \ nextgroup=typescriptArgumentList,typescriptTypeArguments
  \ contains=@_semantic,typescriptDotNotation
