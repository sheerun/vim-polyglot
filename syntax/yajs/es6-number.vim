if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Number nextgroup=javascriptGlobalNumberDot,javascriptFuncCallArg
syntax match   javascriptGlobalNumberDot /\./ contained nextgroup=javascriptNumberStaticProp,javascriptNumberStaticMethod

endif
