if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal String nextgroup=javascriptGlobalStringDot,javascriptFuncCallArg
syntax match   javascriptGlobalStringDot /\./ contained nextgroup=javascriptStringStaticMethod

endif
