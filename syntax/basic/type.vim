if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/basic/type.vim')
  finish
endif

" Types
syntax match typescriptOptionalMark /?/ contained

syntax cluster typescriptTypeParameterCluster contains=
  \ typescriptTypeParameter,
  \ typescriptGenericDefault

syntax region typescriptTypeParameters matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/
  \ contains=@typescriptTypeParameterCluster
  \ contained

syntax match typescriptTypeParameter /\K\k*/
  \ nextgroup=typescriptConstraint
  \ contained skipwhite skipnl

syntax keyword typescriptConstraint extends
  \ nextgroup=@typescriptType
  \ contained skipwhite skipnl

syntax match typescriptGenericDefault /=/
  \ nextgroup=@typescriptType
  \ contained skipwhite

"><
" class A extend B<T> {} // ClassBlock
" func<T>() // FuncCallArg
syntax region typescriptTypeArguments matchgroup=typescriptTypeBrackets
  \ start=/\></ end=/>/
  \ contains=@typescriptType
  \ nextgroup=typescriptFuncCallArg,@typescriptTypeOperator
  \ contained skipwhite


syntax cluster typescriptType contains=
  \ @typescriptPrimaryType,
  \ typescriptUnion,
  \ @typescriptFunctionType,
  \ typescriptConstructorType

" array type: A[]
" type indexing A['key']
syntax region typescriptTypeBracket contained
  \ start=/\[/ end=/\]/
  \ contains=typescriptString,typescriptNumber
  \ nextgroup=@typescriptTypeOperator
  \ skipwhite skipempty

syntax cluster typescriptPrimaryType contains=
  \ typescriptParenthesizedType,
  \ typescriptPredefinedType,
  \ typescriptTypeReference,
  \ typescriptObjectType,
  \ typescriptTupleType,
  \ typescriptTypeQuery,
  \ typescriptStringLiteralType,
  \ typescriptTemplateLiteralType,
  \ typescriptReadonlyArrayKeyword,
  \ typescriptAssertType

syntax region  typescriptStringLiteralType contained
  \ start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1\|$/
  \ nextgroup=typescriptUnion
  \ skipwhite skipempty

syntax region  typescriptTemplateLiteralType contained
  \ start=/`/  skip=/\\\\\|\\`\|\n/  end=/`\|$/
  \ contains=typescriptTemplateSubstitutionType
  \ nextgroup=typescriptTypeOperator
  \ skipwhite skipempty

syntax region  typescriptTemplateSubstitutionType matchgroup=typescriptTemplateSB
  \ start=/\${/ end=/}/
  \ contains=@typescriptType
  \ contained

syntax region typescriptParenthesizedType matchgroup=typescriptParens
  \ start=/(/ end=/)/
  \ contains=@typescriptType
  \ nextgroup=@typescriptTypeOperator
  \ contained skipwhite skipempty fold

syntax match typescriptTypeReference /\K\k*\(\.\K\k*\)*/
  \ nextgroup=typescriptTypeArguments,@typescriptTypeOperator,typescriptUserDefinedType
  \ skipwhite contained skipempty

syntax keyword typescriptPredefinedType any number boolean string void never undefined null object unknown
  \ nextgroup=@typescriptTypeOperator
  \ contained skipwhite skipempty

syntax match typescriptPredefinedType /unique symbol/
  \ nextgroup=@typescriptTypeOperator
  \ contained skipwhite skipempty

syntax region typescriptObjectType matchgroup=typescriptBraces
  \ start=/{/ end=/}/
  \ contains=@typescriptTypeMember,typescriptEndColons,@typescriptComments,typescriptAccessibilityModifier,typescriptReadonlyModifier
  \ nextgroup=@typescriptTypeOperator
  \ contained skipwhite skipnl fold

syntax cluster typescriptTypeMember contains=
  \ @typescriptCallSignature,
  \ typescriptConstructSignature,
  \ typescriptIndexSignature,
  \ @typescriptMembers

syntax match typescriptTupleLable /\K\k*?\?:/
    \ contained

syntax region typescriptTupleType matchgroup=typescriptBraces
  \ start=/\[/ end=/\]/
  \ contains=@typescriptType,@typescriptComments,typescriptRestOrSpread,typescriptTupleLable
  \ contained skipwhite

syntax cluster typescriptTypeOperator
  \ contains=typescriptUnion,typescriptTypeBracket,typescriptConstraint,typescriptConditionalType

syntax match typescriptUnion /|\|&/ contained nextgroup=@typescriptPrimaryType skipwhite skipempty

syntax match typescriptConditionalType /?\|:/ contained nextgroup=@typescriptPrimaryType skipwhite skipempty

syntax cluster typescriptFunctionType contains=typescriptGenericFunc,typescriptFuncType
syntax region typescriptGenericFunc matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/
  \ contains=typescriptTypeParameter
  \ nextgroup=typescriptFuncType
  \ containedin=typescriptFunctionType
  \ contained skipwhite skipnl

syntax region typescriptFuncType matchgroup=typescriptParens
  \ start=/(\(\k\+:\|)\)\@=/ end=/)\s*=>/me=e-2
  \ contains=@typescriptParameterList
  \ nextgroup=typescriptFuncTypeArrow
  \ contained skipwhite skipnl oneline

syntax match typescriptFuncTypeArrow /=>/
  \ nextgroup=@typescriptType
  \ containedin=typescriptFuncType
  \ contained skipwhite skipnl

syntax keyword typescriptConstructorType new
  \ nextgroup=@typescriptFunctionType
  \ contained skipwhite skipnl

syntax keyword typescriptUserDefinedType is
  \ contained nextgroup=@typescriptType skipwhite skipempty

syntax keyword typescriptTypeQuery typeof keyof
  \ nextgroup=typescriptTypeReference
  \ contained skipwhite skipnl

syntax keyword typescriptAssertType asserts
  \ nextgroup=typescriptTypeReference
  \ contained skipwhite skipnl

syntax cluster typescriptCallSignature contains=typescriptGenericCall,typescriptCall
syntax region typescriptGenericCall matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/
  \ contains=typescriptTypeParameter
  \ nextgroup=typescriptCall
  \ contained skipwhite skipnl
syntax region typescriptCall matchgroup=typescriptParens
  \ start=/(/ end=/)/
  \ contains=typescriptDecorator,@typescriptParameterList,@typescriptComments
  \ nextgroup=typescriptTypeAnnotation,typescriptBlock
  \ contained skipwhite skipnl

syntax match typescriptTypeAnnotation /:/
  \ nextgroup=@typescriptType
  \ contained skipwhite skipnl

syntax cluster typescriptParameterList contains=
  \ typescriptTypeAnnotation,
  \ typescriptAccessibilityModifier,
  \ typescriptReadonlyModifier,
  \ typescriptOptionalMark,
  \ typescriptRestOrSpread,
  \ typescriptFuncComma,
  \ typescriptDefaultParam

syntax match typescriptFuncComma /,/ contained

syntax match typescriptDefaultParam /=/
  \ nextgroup=@typescriptValue
  \ contained skipwhite

syntax keyword typescriptConstructSignature new
  \ nextgroup=@typescriptCallSignature
  \ contained skipwhite

syntax region typescriptIndexSignature matchgroup=typescriptBraces
  \ start=/\[/ end=/\]/
  \ contains=typescriptPredefinedType,typescriptMappedIn,typescriptString
  \ nextgroup=typescriptTypeAnnotation
  \ contained skipwhite oneline

syntax keyword typescriptMappedIn in
  \ nextgroup=@typescriptType
  \ contained skipwhite skipnl skipempty

syntax keyword typescriptAliasKeyword type
  \ nextgroup=typescriptAliasDeclaration
  \ skipwhite skipnl skipempty

syntax region typescriptAliasDeclaration matchgroup=typescriptUnion
  \ start=/ / end=/=/
  \ nextgroup=@typescriptType
  \ contains=typescriptConstraint,typescriptTypeParameters
  \ contained skipwhite skipempty

syntax keyword typescriptReadonlyArrayKeyword readonly
  \ nextgroup=@typescriptPrimaryType
  \ skipwhite
