if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/basic/identifiers.vim')
  finish
endif

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

syntax region  typescriptIndexExpr      contained matchgroup=typescriptProperty start=/\[/ end=/]/ contains=@typescriptValue,typescriptCastKeyword nextgroup=@typescriptSymbols,typescriptDotNotation,typescriptFuncCallArg skipwhite skipempty

syntax match   typescriptDotNotation           /\.\|?\.\|!\./ nextgroup=typescriptProp skipnl
syntax match   typescriptDotStyleNotation      /\.style\./ nextgroup=typescriptDOMStyle transparent
" syntax match   typescriptFuncCall              contained /[a-zA-Z]\k*\ze(/ nextgroup=typescriptFuncCallArg
syntax region  typescriptParenExp              matchgroup=typescriptParens start=/(/ end=/)/ contains=@typescriptComments,@typescriptValue,typescriptCastKeyword nextgroup=@typescriptSymbols skipwhite skipempty
syntax region  typescriptFuncCallArg           contained matchgroup=typescriptParens start=/(/ end=/)/ contains=@typescriptValue,@typescriptComments,typescriptCastKeyword nextgroup=@typescriptSymbols,typescriptDotNotation skipwhite skipempty skipnl
syntax region  typescriptEventFuncCallArg      contained matchgroup=typescriptParens start=/(/ end=/)/ contains=@typescriptEventExpression
syntax region  typescriptEventString           contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/ contains=typescriptASCII,@events

syntax region  typescriptDestructureString
  \ start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/
  \ contains=typescriptASCII
  \ nextgroup=typescriptDestructureAs
  \ contained skipwhite skipempty

syntax cluster typescriptVariableDeclarations
  \ contains=typescriptVariableDeclaration,@typescriptDestructures

syntax match typescriptVariableDeclaration /[A-Za-z_$]\k*/
  \ nextgroup=typescriptTypeAnnotation,typescriptAssign
  \ contained skipwhite skipempty

syntax cluster typescriptDestructureVariables contains=
  \ typescriptRestOrSpread,
  \ typescriptDestructureComma,
  \ typescriptDestructureLabel,
  \ typescriptDestructureVariable,
  \ @typescriptDestructures

syntax match typescriptDestructureVariable    /[A-Za-z_$]\k*/ contained
  \ nextgroup=typescriptDefaultParam
  \ contained skipwhite skipempty

syntax match typescriptDestructureLabel       /[A-Za-z_$]\k*\ze\_s*:/
  \ nextgroup=typescriptDestructureAs
  \ contained skipwhite skipempty

syntax match typescriptDestructureAs /:/
  \ nextgroup=typescriptDestructureVariable,@typescriptDestructures
  \ contained skipwhite skipempty

syntax match typescriptDestructureComma /,/ contained

syntax cluster typescriptDestructures contains=
  \ typescriptArrayDestructure,
  \ typescriptObjectDestructure

syntax region typescriptArrayDestructure matchgroup=typescriptBraces
  \ start=/\[/ end=/]/
  \ contains=@typescriptDestructureVariables,@typescriptComments
  \ nextgroup=typescriptTypeAnnotation,typescriptAssign
  \ transparent contained skipwhite skipempty fold

syntax region typescriptObjectDestructure matchgroup=typescriptBraces
  \ start=/{/ end=/}/
  \ contains=typescriptDestructureString,@typescriptDestructureVariables,@typescriptComments
  \ nextgroup=typescriptTypeAnnotation,typescriptAssign
  \ transparent contained skipwhite skipempty fold
