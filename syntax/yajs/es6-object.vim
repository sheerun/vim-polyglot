if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Object nextgroup=javascriptGlobalObjectDot,javascriptFuncCallArg
syntax match   javascriptGlobalObjectDot /\./ contained nextgroup=javascriptObjectStaticMethod

endif
