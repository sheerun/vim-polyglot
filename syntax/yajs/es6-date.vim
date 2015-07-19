if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Date nextgroup=javascriptGlobalDateDot,javascriptFuncCallArg
syntax match   javascriptGlobalDateDot /\./ contained nextgroup=javascriptDateStaticMethod

endif
