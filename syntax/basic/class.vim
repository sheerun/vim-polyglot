if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

"don't add typescriptMembers to nextgroup, let outer scope match it
" so we won't match abstract method outside abstract class
syntax keyword typescriptAbstract              abstract
  \ nextgroup=typescriptClassKeyword
  \ skipwhite skipnl
syntax keyword typescriptClassKeyword          class
  \ nextgroup=typescriptClassName,typescriptClassExtends,typescriptClassBlock
  \ skipwhite

syntax match   typescriptClassName             contained /\K\k*/
  \ nextgroup=typescriptClassBlock,typescriptClassExtends,typescriptClassTypeParameter
  \ skipwhite skipnl

syntax region typescriptClassTypeParameter
  \ start=/</ end=/>/
  \ contains=typescriptTypeParameter
  \ nextgroup=typescriptClassBlock,typescriptClassExtends
  \ contained skipwhite skipnl

syntax keyword typescriptClassExtends          contained extends implements nextgroup=typescriptClassHeritage skipwhite skipnl

syntax match   typescriptClassHeritage         contained /\v(\k|\.|\(|\))+/
  \ nextgroup=typescriptClassBlock,typescriptClassExtends,typescriptMixinComma,typescriptClassTypeArguments
  \ contains=@typescriptValue
  \ skipwhite skipnl
  \ contained

syntax region typescriptClassTypeArguments matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/
  \ contains=@typescriptType
  \ nextgroup=typescriptClassExtends,typescriptClassBlock,typescriptMixinComma
  \ contained skipwhite skipnl

syntax match typescriptMixinComma /,/ contained nextgroup=typescriptClassHeritage skipwhite skipnl

" we need add arrowFunc to class block for high order arrow func
" see test case
syntax region  typescriptClassBlock matchgroup=typescriptBraces start=/{/ end=/}/
  \ contains=@typescriptPropertyMemberDeclaration,typescriptAbstract,@typescriptComments,typescriptBlock,typescriptAssign,typescriptDecorator,typescriptAsyncFuncKeyword,typescriptArrowFunc
  \ contained fold

syntax keyword typescriptInterfaceKeyword          interface nextgroup=typescriptInterfaceName skipwhite
syntax match   typescriptInterfaceName             contained /\k\+/
  \ nextgroup=typescriptObjectType,typescriptInterfaceExtends,typescriptInterfaceTypeParameter
  \ skipwhite skipnl
syntax region typescriptInterfaceTypeParameter
  \ start=/</ end=/>/
  \ contains=typescriptTypeParameter
  \ nextgroup=typescriptObjectType,typescriptInterfaceExtends
  \ contained
  \ skipwhite skipnl

syntax keyword typescriptInterfaceExtends          contained extends nextgroup=typescriptInterfaceHeritage skipwhite skipnl

syntax match typescriptInterfaceHeritage contained /\v(\k|\.)+/
  \ nextgroup=typescriptObjectType,typescriptInterfaceComma,typescriptInterfaceTypeArguments
  \ skipwhite

syntax region typescriptInterfaceTypeArguments matchgroup=typescriptTypeBrackets
  \ start=/</ end=/>/ skip=/\s*,\s*/
  \ contains=@typescriptType
  \ nextgroup=typescriptObjectType,typescriptInterfaceComma
  \ contained skipwhite

syntax match typescriptInterfaceComma /,/ contained nextgroup=typescriptInterfaceHeritage skipwhite skipnl

endif
