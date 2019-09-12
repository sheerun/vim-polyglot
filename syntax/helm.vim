if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'helm') == -1

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'yaml'
endif

let b:current_syntax = ''
unlet b:current_syntax
runtime! syntax/yaml.vim

let b:current_syntax = ''
unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim

syn case match

" Go escapes
syn match       goEscapeOctal       display contained "\\[0-7]\{3}"
syn match       goEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       goEscapeX           display contained "\\x\x\{2}"
syn match       goEscapeU           display contained "\\u\x\{4}"
syn match       goEscapeBigU        display contained "\\U\x\{8}"
syn match       goEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     goEscapeOctal       goSpecialString
hi def link     goEscapeC           goSpecialString
hi def link     goEscapeX           goSpecialString
hi def link     goEscapeU           goSpecialString
hi def link     goEscapeBigU        goSpecialString
hi def link     goSpecialString     Special
hi def link     goEscapeError       Error

" Strings and their contents
syn cluster     goStringGroup       contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syn region      goString            contained start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@goStringGroup
syn region      goRawString         contained start=+`+ end=+`+

hi def link     goString            String
hi def link     goRawString         String

" Characters; their contents
syn cluster     goCharacterGroup    contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU
syn region      goCharacter         contained start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@goCharacterGroup

hi def link     goCharacter         Character

" Integers
syn match       goDecimalInt        contained "\<\d\+\([Ee]\d\+\)\?\>"
syn match       goHexadecimalInt    contained "\<0x\x\+\>"
syn match       goOctalInt          contained "\<0\o\+\>"
syn match       goOctalError        contained "\<0\o*[89]\d*\>"
syn cluster     goInt               contains=goDecimalInt,goHexadecimalInt,goOctalInt
" Floating point
syn match       goFloat             contained "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match       goFloat             contained "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match       goFloat             contained "\<\d\+[Ee][-+]\d\+\>"
" Imaginary literals
syn match       goImaginary         contained "\<\d\+i\>"
syn match       goImaginary         contained "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syn match       goImaginary         contained "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syn match       goImaginary         contained "\<\d\+[Ee][-+]\d\+i\>"

hi def link     goInt        Number
hi def link     goFloat      Number
hi def link     goImaginary  Number

" Token groups
syn cluster     gotplLiteral     contains=goString,goRawString,goCharacter,@goInt,goFloat,goImaginary
syn keyword     gotplControl     contained   if else end range with template include tpl required define
syn keyword     gotplFunctions   contained   and call html index js len not or print printf println urlquery eq ne lt le gt ge
syn keyword     goSprigFunctions contained   abbrev abbrevboth add add1 adler32sum ago append atoi b32dec b32enc b64dec b64enc base biggest buildCustomCert camelcase cat ceil clean coalesce \contains compact date dateInZone dateModify date_in_zone date_modify default derivePassword dict dir div empty ext fail first float64 floor fromJson fromYaml genCA genPrivateKey genSelfSignedCert genSignedCert has hasKey hasPrefix hasSuffix hello htmlDate htmlDateInZone indent initial initials int int64 isAbs join kebabcase keys kindIs kindOf last list lower max merge mergeOverwrite min mod mul nindent nospace now omit pick pluck plural prepend quote randAlpha randAlphaNum randAscii randNumeric regexFind regexFindAll regexMatch regexReplaceAll regexReplaceAllLiteral regexSplit repeat replace rest reverse round semver semverCompare set sha1sum sha256sum shuffle slice snakecase sortAlpha split splitList splitn squote sub substr swapcase ternary title toDate toJson toPrettyJson toString toStrings toToml toYaml trim trimAll trimPrefix trimSuffix trimall trunc tuple typeIs typeIsLike typeOf uniq unixEpoch unset until untilStep untitle upper uuidv4 values without wrap wrapWith
syn match       gotplVariable    contained   /\$[a-zA-Z0-9_]*\>/
syn match       goTplIdentifier  contained   /\.[^\s}]+\>/

hi def link     gotplControl        Keyword
hi def link     gotplFunctions      Function
hi def link     goSprigFunctions    Function
hi def link     goTplVariable       Special

syn region gotplAction start="{{" end="}}" contains=@gotplLiteral,gotplControl,gotplFunctions,goSprigFunctions,gotplVariable,goTplIdentifier containedin=yamlFlowString display
syn region gotplAction start="\[\[" end="\]\]" contains=@gotplLiteral,gotplControl,gotplFunctions,goSprigFunctions,gotplVariable containedin=yamlFlowString display
syn region goTplComment start="{{\(- \)\?/\*" end="\*/\( -\)\?}}" display
syn region goTplComment start="\[\[\(- \)\?/\*" end="\*/\( -\)\?\]\]" display

hi def link gotplAction PreProc
hi def link goTplComment Comment
let b:current_syntax = "helm"

" vim: sw=2 ts=2 et

endif
