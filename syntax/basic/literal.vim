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

" From pangloss/vim-javascript
" <https://github.com/pangloss/vim-javascript/blob/d6e137563c47fb59f26ed25d044c0c7532304f18/syntax/javascript.vim#L64-L72>
syntax region  typescriptRegexpCharClass    contained start=+\[+ skip=+\\.+ end=+\]+ contains=typescriptSpecial extend
syntax match   typescriptRegexpBoundary     contained "\v\c[$^]|\\b"
syntax match   typescriptRegexpBackRef      contained "\v\\[1-9]\d*"
syntax match   typescriptRegexpQuantifier   contained "\v[^\\]%([?*+]|\{\d+%(,\d*)?})\??"lc=1
syntax match   typescriptRegexpOr           contained "|"
syntax match   typescriptRegexpMod          contained "\v\(\?[:=!>]"lc=1
syntax region  typescriptRegexpGroup        contained start="[^\\]("lc=1 skip="\\.\|\[\(\\.\|[^]]\+\)\]" end=")" contains=typescriptRegexpCharClass,@typescriptRegexpSpecial keepend
syntax region  typescriptRegexpString
  \ start=+\%(\%(\<return\|\<typeof\|\_[^)\]'"[:blank:][:alnum:]_$]\)\s*\)\@<=/\ze[^*/]+ skip=+\\.\|\[[^]]\{1,}\]+ end=+/[gimyus]\{,6}+
  \ contains=typescriptRegexpCharClass,typescriptRegexpGroup,@typescriptRegexpSpecial
  \ oneline keepend extend
syntax cluster typescriptRegexpSpecial    contains=typescriptSpecial,typescriptRegexpBoundary,typescriptRegexpBackRef,typescriptRegexpQuantifier,typescriptRegexpOr,typescriptRegexpMod

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
