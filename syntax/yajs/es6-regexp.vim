if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
syntax keyword javascriptGlobal RegExp nextgroup=javascriptGlobalRegExpDot,javascriptFuncCallArg
syntax match   javascriptGlobalRegExpDot /\./ contained nextgroup=javascriptRegExpStaticProp

endif
