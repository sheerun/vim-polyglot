if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax cluster typescriptStrings               contains=typescriptProp,typescriptString,typescriptTemplate,@typescriptComments,typescriptDocComment,typescriptRegexpString,typescriptPropertyName

syntax cluster typescriptNoReserved contains=
  \ @typescriptStrings,
  \ @typescriptDocs,
  \ @typescriptComments,
  \ shellbang,
  \ typescriptObjectLiteral,
  \ typescriptObjectLabel,
  \ typescriptClassBlock,
  \ @typescriptType,
  \ typescriptCall

"https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#Keywords
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved break case catch const continue
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved debugger delete do else export
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved extends finally for if
"import,typescriptRegexpString,typescriptPropertyName
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved in instanceof let new return super
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved static switch throw try typeof
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved void while with yield

syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved implements package protected
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved interface private public readonly abstract
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved byte char double final float goto int
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved long native short synchronized transient
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved volatile

syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved class
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved var
syntax keyword typescriptReserved containedin=ALLBUT,@typescriptNoReserved function

endif
