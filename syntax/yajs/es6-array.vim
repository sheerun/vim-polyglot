if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Array nextgroup=javascriptGlobalArrayDot,javascriptFuncCallArg
syntax match   javascriptGlobalArrayDot /\./ contained nextgroup=javascriptArrayStaticMethod

endif
