if polyglot#init#is_disabled(expand('<sfile>:p'), 'typescript', 'syntax/basic/literal.vim')
  finish
endif

"Syntax in the JavaScript code

" String
syntax match   typescriptASCII                 contained /\\\d\d\d/

syntax region  typescriptTemplateSubstitution matchgroup=typescriptTemplateSB
  \ start=/\${/ end=/}/
  \ contains=@typescriptValue,typescriptCastKeyword
  \ contained


syntax region  typescriptString
  \ start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+
  \ contains=typescriptSpecial,@Spell
  \ nextgroup=@typescriptSymbols
  \ skipwhite skipempty
  \ extend

syntax match   typescriptSpecial            contained "\v\\%(x\x\x|u%(\x{4}|\{\x{1,6}})|c\u|.)"

" From vim runtime
" <https://github.com/vim/vim/blob/master/runtime/syntax/javascript.vim#L48>
syntax region  typescriptRegexpString          start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gimsuy]\{0,5\}\s*$+ end=+/[gimsuy]\{0,5\}\s*[;.,)\]}:]+me=e-1 nextgroup=typescriptDotNotation oneline

syntax region  typescriptTemplate
  \ start=/`/  skip=/\\\\\|\\`\|\n/  end=/`\|$/
  \ contains=typescriptTemplateSubstitution,typescriptSpecial,@Spell
  \ nextgroup=@typescriptSymbols
  \ skipwhite skipempty

"Array
syntax region  typescriptArray matchgroup=typescriptBraces
  \ start=/\[/ end=/]/
  \ contains=@typescriptValue,@typescriptComments,typescriptCastKeyword
  \ nextgroup=@typescriptSymbols,typescriptDotNotation
  \ skipwhite skipempty fold

" Number
syntax match typescriptNumber /\<0[bB][01][01_]*\>/        nextgroup=@typescriptSymbols skipwhite skipempty
syntax match typescriptNumber /\<0[oO][0-7][0-7_]*\>/       nextgroup=@typescriptSymbols skipwhite skipempty
syntax match typescriptNumber /\<0[xX][0-9a-fA-F][0-9a-fA-F_]*\>/ nextgroup=@typescriptSymbols skipwhite skipempty
syntax match typescriptNumber /\<\%(\d[0-9_]*\%(\.\d[0-9_]*\)\=\|\.\d[0-9_]*\)\%([eE][+-]\=\d[0-9_]*\)\=\>/
  \ nextgroup=@typescriptSymbols skipwhite skipempty
