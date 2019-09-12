if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax cluster afterIdentifier contains=
  \ typescriptDotNotation,
  \ typescriptFuncCallArg,
  \ typescriptTemplate,
  \ typescriptIndexExpr,
  \ @typescriptSymbols,
  \ typescriptTypeArguments

syntax match   typescriptIdentifierName        /\<\K\k*/
  \ nextgroup=@afterIdentifier
  \ transparent
  \ contains=@_semantic
  \ skipnl skipwhite

syntax match   typescriptProp contained /\K\k*!\?/
  \ transparent
  \ contains=@props
  \ nextgroup=@afterIdentifier
  \ skipwhite skipempty

syntax region  typescriptIndexExpr      contained matchgroup=typescriptProperty start=/\[/rs=s+1 end=/]/he=e-1 contains=@typescriptValue nextgroup=@typescriptSymbols,typescriptDotNotation,typescriptFuncCallArg skipwhite skipempty

syntax match   typescriptDotNotation           /\./ nextgroup=typescriptProp skipnl
syntax match   typescriptDotStyleNotation      /\.style\./ nextgroup=typescriptDOMStyle transparent
" syntax match   typescriptFuncCall              contained /[a-zA-Z]\k*\ze(/ nextgroup=typescriptFuncCallArg
syntax region  typescriptParenExp              matchgroup=typescriptParens start=/(/ end=/)/ contains=@typescriptComments,@typescriptValue,typescriptCastKeyword nextgroup=@typescriptSymbols skipwhite skipempty
syntax region  typescriptFuncCallArg           contained matchgroup=typescriptParens start=/(/ end=/)/ contains=@typescriptValue,@typescriptComments nextgroup=@typescriptSymbols,typescriptDotNotation skipwhite skipempty skipnl
syntax region  typescriptEventFuncCallArg      contained matchgroup=typescriptParens start=/(/ end=/)/ contains=@typescriptEventExpression
syntax region  typescriptEventString           contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ contains=typescriptASCII,@events

endif
