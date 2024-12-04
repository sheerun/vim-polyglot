if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/ts-common/object.vim')
  finish
endif

syntax region  typescriptObjectLiteral         matchgroup=typescriptBraces
  \ start=/{/ end=/}/
  \ contains=@typescriptComments,typescriptObjectLabel,typescriptStringProperty,typescriptComputedPropertyName,typescriptObjectAsyncKeyword,typescriptTernary,typescriptCastKeyword
  \ fold contained

syntax keyword typescriptObjectAsyncKeyword async contained

syntax match   typescriptObjectLabel  contained /\k\+\_s*/
  \ nextgroup=typescriptObjectColon,@typescriptCallImpl
  \ skipwhite skipempty

syntax region  typescriptStringProperty   contained
  \ start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1/
  \ nextgroup=typescriptObjectColon,@typescriptCallImpl
  \ skipwhite skipempty

" syntax region  typescriptPropertyName    contained start=/\z(["']\)/  skip=/\\\\\|\\\z1\|\\\n/  end=/\z1(/me=e-1 nextgroup=@typescriptCallSignature skipwhite skipempty oneline
syntax region  typescriptComputedPropertyName  contained matchgroup=typescriptBraces
  \ start=/\[/rs=s+1 end=/]/
  \ contains=@typescriptValue
  \ nextgroup=typescriptObjectColon,@typescriptCallImpl
  \ skipwhite skipempty

" syntax region  typescriptComputedPropertyName  contained matchgroup=typescriptPropertyName start=/\[/rs=s+1 end=/]\_s*:/he=e-1 contains=@typescriptValue nextgroup=@typescriptValue skipwhite skipempty
" syntax region  typescriptComputedPropertyName  contained matchgroup=typescriptPropertyName start=/\[/rs=s+1 end=/]\_s*(/me=e-1 contains=@typescriptValue nextgroup=@typescriptCallSignature skipwhite skipempty
" Value for object, statement for label statement
syntax match typescriptRestOrSpread /\.\.\./ contained
syntax match typescriptObjectSpread /\.\.\./ contained containedin=typescriptObjectLiteral,typescriptArray nextgroup=@typescriptValue

syntax match typescriptObjectColon contained /:/ nextgroup=@typescriptValue skipwhite skipempty
