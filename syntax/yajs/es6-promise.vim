if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Promise nextgroup=javascriptGlobalPromiseDot,javascriptFuncCallArg
syntax match   javascriptGlobalPromiseDot /\./ contained nextgroup=javascriptPromiseStaticMethod

endif
