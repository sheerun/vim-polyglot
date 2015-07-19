if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  

" syntax match   javascriptIdentifierName        /\<[^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^0-9][^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^]*/ nextgroup=javascriptDotNotation,javascriptFuncCallArg,javascriptComputedProperty,javascriptWSymbols contains=@_smantic

syntax cluster _semantic contains=_semantic0,_semantic1,_semantic2,_semantic3,_semantic4,_semantic5,_semantic6,_semantic7,_semantic8,_semantic9,_semantic10,_semantic11,_semantic12,_semantic13,_semantic14,_semantic15,_semantic16,_semantic17,_semantic18,_semantic19,_semantic20,_semantic21,_semantic22,_semantic23,_semantic24,_semantic25

endif
