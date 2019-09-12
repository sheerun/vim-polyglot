if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

"Block VariableStatement EmptyStatement ExpressionStatement IfStatement IterationStatement ContinueStatement BreakStatement ReturnStatement WithStatement LabelledStatement SwitchStatement ThrowStatement TryStatement DebuggerStatement
syntax cluster typescriptStatement
  \ contains=typescriptBlock,typescriptVariable,
  \ @typescriptTopExpression,typescriptAssign,
  \ typescriptConditional,typescriptRepeat,typescriptBranch,
  \ typescriptLabel,typescriptStatementKeyword,
  \ typescriptFuncKeyword,
  \ typescriptTry,typescriptExceptions,typescriptDebugger,
  \ typescriptExport,typescriptInterfaceKeyword,typescriptEnum,
  \ typescriptModule,typescriptAliasKeyword,typescriptImport

syntax cluster typescriptPrimitive  contains=typescriptString,typescriptTemplate,typescriptRegexpString,typescriptNumber,typescriptBoolean,typescriptNull,typescriptArray

syntax cluster typescriptEventTypes            contains=typescriptEventString,typescriptTemplate,typescriptNumber,typescriptBoolean,typescriptNull

" top level expression: no arrow func
" also no func keyword. funcKeyword is contained in statement
" funcKeyword allows overloading (func without body)
" funcImpl requires body
syntax cluster typescriptTopExpression
  \ contains=@typescriptPrimitive,
  \ typescriptIdentifier,typescriptIdentifierName,
  \ typescriptOperator,typescriptUnaryOp,
  \ typescriptParenExp,typescriptRegexpString,
  \ typescriptGlobal,typescriptAsyncFuncKeyword,
  \ typescriptClassKeyword,typescriptTypeCast

" no object literal, used in type cast and arrow func
" TODO: change func keyword to funcImpl
syntax cluster typescriptExpression
  \ contains=@typescriptTopExpression,
  \ typescriptArrowFuncDef,
  \ typescriptFuncImpl

syntax cluster typescriptValue
  \ contains=@typescriptExpression,typescriptObjectLiteral

syntax cluster typescriptEventExpression       contains=typescriptArrowFuncDef,typescriptParenExp,@typescriptValue,typescriptRegexpString,@typescriptEventTypes,typescriptOperator,typescriptGlobal,jsxRegion

endif
