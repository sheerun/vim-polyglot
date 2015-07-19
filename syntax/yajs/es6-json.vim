if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal JSON nextgroup=javascriptGlobalJSONDot,javascriptFuncCallArg
syntax match   javascriptGlobalJSONDot /\./ contained nextgroup=javascriptJSONStaticMethod

endif
