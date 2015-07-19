if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal Math nextgroup=javascriptGlobalMathDot,javascriptFuncCallArg
syntax match   javascriptGlobalMathDot /\./ contained nextgroup=javascriptMathStaticProp,javascriptMathStaticMethod

endif
