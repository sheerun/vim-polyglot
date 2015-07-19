if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Symbol nextgroup=javascriptGlobalSymbolDot,javascriptFuncCallArg
syntax match   javascriptGlobalSymbolDot /\./ contained nextgroup=javascriptSymbolStaticProp,javascriptSymbolStaticMethod

endif
