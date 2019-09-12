if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

syntax keyword typescriptConstructor           contained constructor
  \ nextgroup=@typescriptCallSignature
  \ skipwhite skipempty


syntax cluster memberNextGroup contains=typescriptMemberOptionality,typescriptTypeAnnotation,@typescriptCallSignature

syntax match typescriptMember /\K\k*/
  \ nextgroup=@memberNextGroup
  \ contained skipwhite

syntax match typescriptMethodAccessor contained /\v(get|set)\s\K/me=e-1
  \ nextgroup=@typescriptMembers

syntax cluster typescriptPropertyMemberDeclaration contains=
  \ typescriptClassStatic,
  \ typescriptAccessibilityModifier,
  \ typescriptReadonlyModifier,
  \ typescriptMethodAccessor,
  \ @typescriptMembers
  " \ typescriptMemberVariableDeclaration

syntax match typescriptMemberOptionality /?\|!/ contained
  \ nextgroup=typescriptTypeAnnotation,@typescriptCallSignature
  \ skipwhite skipempty

syntax cluster typescriptMembers contains=typescriptMember,typescriptStringMember,typescriptComputedMember

syntax keyword typescriptClassStatic static
  \ nextgroup=@typescriptMembers,typescriptAsyncFuncKeyword,typescriptReadonlyModifier
  \ skipwhite contained

syntax keyword typescriptAccessibilityModifier public private protected contained

syntax keyword typescriptReadonlyModifier readonly contained

syntax region  typescriptStringMember   contained
  \ start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1/
  \ nextgroup=@memberNextGroup
  \ skipwhite skipempty

syntax region  typescriptComputedMember   contained matchgroup=typescriptProperty
  \ start=/\[/rs=s+1 end=/]/
  \ contains=@typescriptValue,typescriptMember,typescriptMappedIn
  \ nextgroup=@memberNextGroup
  \ skipwhite skipempty

endif
