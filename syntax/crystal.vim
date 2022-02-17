if polyglot#init#is_disabled(expand('<sfile>:p'), 'crystal', 'syntax/crystal.vim')
  finish
endif

" Language: Crystal
" Maintainer:
"   rhysd <https://rhysd.github.io>
"   Jeffrey Crochet <jlcrochet@pm.me>
"
" Based on Ruby syntax highlight
" which was made by Mirko Nasato and Doug Kearns
" ----------------------------------------------

" Prelude
if exists('b:current_syntax')
  finish
endif

" Adding `@-@` should fix a wide variety of false positives related to
" instance/class variables with keywords in their name, like @def and
" @class
syn iskeyword @,48-57,_,192-255,@-@

" eCrystal Config
if exists('g:main_syntax') && g:main_syntax ==# 'ecrystal'
  let b:crystal_no_expensive = 1
end

" Folding Config
if has('folding') && exists('g:crystal_fold')
  setlocal foldmethod=syntax
endif

let s:foldable_groups = split(
      \   get(
      \     b:,
      \     'crystal_foldable_groups',
      \     get(g:, 'crystal_foldable_groups', 'ALL')
      \   )
      \ )

function! s:foldable(...) abort
  if index(s:foldable_groups, 'NONE') > -1
    return 0
  endif

  if index(s:foldable_groups, 'ALL') > -1
    return 1
  endif

  for l:i in a:000
    if index(s:foldable_groups, l:i) > -1
      return 1
    endif
  endfor

  return 0
endfunction

function! s:run_syntax_fold(args) abort
  let [_0, _1, groups, cmd; _] = matchlist(a:args, '\(["'']\)\(.\{-}\)\1\s\+\(.*\)')
  if call('s:foldable', split(groups))
    let cmd .= ' fold'
  endif
  exe cmd
endfunction

com! -nargs=* SynFold call s:run_syntax_fold(<q-args>)

" Top and Not-Top Clusters
syn cluster crystalTop    contains=TOP
syn cluster crystalNotTop contains=CONTAINED

" Whitespace Errors
if exists('g:crystal_space_errors')
  if !exists('g:crystal_no_trail_space_error')
    syn match crystalSpaceError display excludenl "\s\+$"
  endif
  if !exists('g:crystal_no_tab_space_error')
    syn match crystalSpaceError display " \+\t"me=e-1
  endif
endif

" Operators
if exists('g:crystal_operators')
  syn match  crystalOperator "[~!^&|*/%+-]\|<=>\|<=\|\%(<\|\<\%(class\|struct\)\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@1<!>\|\*\*\|\.\.\.\|\.\.\|::"
  syn match  crystalOperator "->\|-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\|//"
  syn region crystalBracketOperator matchgroup=crystalOperator start="\%(\w[?!]\=\|[]})]\)\@2<=\[" end="]" contains=TOP
endif

" Expression Substitution and Backslash Notation
syn match crystalStringEscape "\\\\\|\\[abefnrstv]\|\\\o\{1,3}\|\\x\x\{1,2}"                            contained display
syn match crystalStringEscape "\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)" contained display

syn region crystalInterpolation      matchgroup=crystalInterpolationDelim start="#{" end="}" contained contains=TOP
syn region crystalNoInterpolation    start="\\#{" end="}" contained
syn match  crystalNoInterpolation    "\\#{" display contained

syn match crystalDelimEscape "\\[(<{\[)>}\]]" transparent display contained contains=NONE

syn region crystalNestedParentheses    matchgroup=crystalString start="("  skip="\\\\\|\\)"  end=")"  transparent contained
syn region crystalNestedCurlyBraces    matchgroup=crystalString start="{"  skip="\\\\\|\\}"  end="}"  transparent contained
syn region crystalNestedAngleBrackets  matchgroup=crystalString start="<"  skip="\\\\\|\\>"  end=">"  transparent contained
syn region crystalNestedSquareBrackets matchgroup=crystalString start="\[" skip="\\\\\|\\\]" end="\]" transparent contained

" These are mostly Oniguruma ready
syn region crystalRegexpComment    matchgroup=crystalRegexpSpecial   start="(?#" skip="\\)" end=")" contained
syn region crystalRegexpParens     matchgroup=crystalRegexpSpecial   start="(\(?:\|?<\=[=!]\|?>\|?<[a-z_]\w*>\|?[imx]*-[imx]*:\=\|\%(?#\)\@!\)" skip="\\)" end=")" contained transparent contains=@crystalRegexpSpecial
syn region crystalRegexpBrackets   matchgroup=crystalRegexpCharClass start="\[\^\=" skip="\\\]" end="\]" contained transparent contains=crystalStringEscape,crystalRegexpEscape,crystalRegexpCharClass oneline
syn match  crystalRegexpCharClass  "\\[DdHhSsWw]" contained display
syn match  crystalRegexpCharClass  "\[:\^\=\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\):\]" contained
syn match  crystalRegexpEscape     "\\[].*?+^$|\\/(){}[]" contained
syn match  crystalRegexpQuantifier "[*?+][?+]\=" contained display
syn match  crystalRegexpQuantifier "{\d\+\%(,\d*\)\=}?\=" contained display
syn match  crystalRegexpAnchor     "[$^]\|\\[ABbGZz]" contained display
syn match  crystalRegexpDot        "\." contained display
syn match  crystalRegexpSpecial    "|"  contained display
syn match  crystalRegexpSpecial    "\\[1-9]\d\=\d\@!" contained display
syn match  crystalRegexpSpecial    "\\k<\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\=>" contained display
syn match  crystalRegexpSpecial    "\\k'\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\='" contained display
syn match  crystalRegexpSpecial    "\\g<\%([a-z_]\w*\|-\=\d\+\)>" contained display
syn match  crystalRegexpSpecial    "\\g'\%([a-z_]\w*\|-\=\d\+\)'" contained display

syn cluster crystalStringSpecial         contains=crystalInterpolation,crystalNoInterpolation,crystalStringEscape
syn cluster crystalExtendedStringSpecial contains=@crystalStringSpecial,crystalNestedParentheses,crystalNestedCurlyBraces,crystalNestedAngleBrackets,crystalNestedSquareBrackets,crystalNestedRawParentheses,crystalNestedRawCurlyBraces,crystalNestedRawAngleBrackets,crystalNestedRawSquareBrackets
syn cluster crystalRegexpSpecial         contains=crystalInterpolation,crystalNoInterpolation,crystalStringEscape,crystalRegexpSpecial,crystalRegexpEscape,crystalRegexpBrackets,crystalRegexpCharClass,crystalRegexpDot,crystalRegexpQuantifier,crystalRegexpAnchor,crystalRegexpParens,crystalRegexpComment

" Numbers and ASCII Codes
syn match crystalASCIICode "\%(\w\|[]})\"'/]\)\@1<!\%(?\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\=\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)\)"
syn match crystalInteger   "\<0x[[:xdigit:]_]\+\%([ui]\%(8\|16\|32\|64\|128\)\|f\%(32\|64\)\)\=\>" display
syn match crystalInteger   "\<0o[0-7_]\+\%([ui]\%(8\|16\|32\|64\|128\)\)\=\>" display
syn match crystalInteger   "\<0b[01_]\+\%([ui]\%(8\|16\|32\|64\|128\)\)\=\>" display
syn match crystalInteger   "\<\d[[:digit:]_]*\%([ui]\%(8\|16\|32\|64\|128\)\|f\%(32\|64\)\)\=\>" contains=crystalInvalidInteger display
syn match crystalFloat     "\<\d[[:digit:]_]*\.\d[[:digit:]_]*\%(f\%(32\|64\)\)\=\>" contains=crystalInvalidInteger display
syn match crystalFloat     "\<\d[[:digit:]_]*\%(\.\d[[:digit:]_]*\)\=\%([eE][-+]\=[[:digit:]_]\+\)\%(f\%(32\|64\)\)\=\>" contains=crystalInvalidInteger display
" Note: 042 is invalid but 0, 0_, 0_u8 and 0_1 are valid (#73)
syn match crystalInvalidInteger "\%(\.\|[eE][+-]\)\@2<!\<0\d\+\>" contained containedin=crystalFloat,crystalInteger display

" Identifiers
syn match crystalLocalVariableOrMethod "\<[_[:lower:]][_[:alnum:]]*[?!=]\=" contains=NONE display
syn match crystalBlockArgument         "&[_[:lower:]][_[:alnum:]]"          contains=NONE display transparent

syn match  crystalTypeName         "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=" contained
syn match  crystalClassName        "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=" contained
syn match  crystalModuleName       "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=" contained
syn match  crystalStructName       "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=" contained
syn match  crystalLibName          "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=" contained
syn match  crystalEnumName         "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=" contained
syn match  crystalAnnotationName   "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=" contained
syn match  crystalConstant         "\%(\%([.@$]\@1<!\.\)\@1<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@="
syn match  crystalClassVariable    "@@\%(\h\|%\|[^\x00-\x7F]\)\%(\w\|%\|[^\x00-\x7F]\)*" display
syn match  crystalInstanceVariable "@\%(\h\|%\|[^\x00-\x7F]\)\%(\w\|%\|[^\x00-\x7F]\)*" display
syn match  crystalFreshVariable    "\%(\h\|[^\x00-\x7F]\)\@1<!%\%(\h\|[^\x00-\x7F]\)\%(\w\|%\|[^\x00-\x7F]\)*" display
syn match  crystalSymbol           "[]})\"':]\@1<!:\%(\^\|\~\|<<\|<=>\|<=\|<\|===\|[=!]=\|[=!]\~\|!\|>>\|>=\|>\||\|-@\|-\|/\|\[][=?]\|\[]\|\*\*\|\*\|&\|%\|+@\|+\|`\)"
syn match  crystalSymbol           "[]})\"':]\@1<!:\$\%(-.\|[`~<=>_,;:!?/.'"@$*\&+0]\)"
syn match  crystalSymbol           "[]})\"':]\@1<!:\%(\$\|@@\=\)\=\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*"
syn match  crystalSymbol           "[]})\"':]\@1<!:\%(\h\|%\|[^\x00-\x7F]\)\%(\w\|%\|[^\x00-\x7F]\)*\%([?!=]>\@!\)\="
syn match  crystalSymbol           "\%([{(,]\_s*\)\@<=\l\w*[!?]\=::\@!"he=e-1
syn match  crystalSymbol           "[]})\"':]\@1<!\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:\s\@="he=e-1
syn match  crystalSymbol           "\%([{(,]\_s*\)\@<=[[:space:],{]\l\w*[!?]\=::\@!"hs=s+1,he=e-1
syn match  crystalSymbol           "[[:space:],{]\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:\s\@="hs=s+1,he=e-1

SynFold ':' syn region crystalSymbol start="[]})\"':]\@1<!:\"" end="\"" skip="\\\\\|\\\"" contains=@crystalStringSpecial

syn match  crystalBlockParameter     "\%(\h\|%\|[^\x00-\x7F]\)\%(\w\|%\|[^\x00-\x7F]\)*" contained
syn region crystalBlockParameterList start="\%(\%(\<do\>\|{\)\s*\)\@<=|" end="|" oneline display contains=crystalBlockParameter

" In Crystal, almost all special variables were removed and global variables
" are not supported https://github.com/crystal-lang/crystal/commit/e872c716d0e936557b34c614efc5a4c24d845f79
" NOTE: Only $~ and $? are supported since they are actually not global.
syn match crystalPredefinedVariable "$[~?]"
syn match crystalPredefinedConstant "\%(\%(\.\@1<!\.\)\@2<!\|::\)\_s*\zs\%(ARGF\|ARGV\|ENV\|STDERR\|STDIN\|STDOUT\)\>\%(\s*(\)\@!"

" Normal Regular Expression
SynFold '/' syn region crystalRegexp matchgroup=crystalRegexpDelimiter start="\%(\%(^\|\<\%(and\|or\|while\|until\|unless\|if\|elsif\|ifdef\|when\|in\|not\|then\|else\)\|[;\~=!|&(,[<>?:*+-]\)\s*\)\@<=/" end="/[imx]*" skip="\\\\\|\\/" contains=@crystalRegexpSpecial
SynFold '/' syn region crystalRegexp matchgroup=crystalRegexpDelimiter start="\%(\h\k*\s\+\)\@<=/[ \t=/]\@!" end="/[imx]*" skip="\\\\\|\\/" contains=@crystalRegexpSpecial

" Generalized Regular Expression
SynFold '%' syn region crystalRegexp matchgroup=crystalRegexpDelimiter start="%r{"  end="}[imx]*"  skip="\\\\\|\\}"  contains=@crystalRegexpSpecial,crystalNestedRawCurlyBraces
SynFold '%' syn region crystalRegexp matchgroup=crystalRegexpDelimiter start="%r<"  end=">[imx]*"  skip="\\\\\|\\>"  contains=@crystalRegexpSpecial,crystalNestedRawAngleBrackets
SynFold '%' syn region crystalRegexp matchgroup=crystalRegexpDelimiter start="%r\[" end="\][imx]*" skip="\\\\\|\\\]" contains=@crystalRegexpSpecial
SynFold '%' syn region crystalRegexp matchgroup=crystalRegexpDelimiter start="%r("  end=")[imx]*"  skip="\\\\\|\\)"  contains=@crystalRegexpSpecial
SynFold '%' syn region crystalRegexp matchgroup=crystalRegexpDelimiter start="%r|"  end="|[imx]*"  skip="\\\\\|\\|"  contains=@crystalRegexpSpecial

" Normal String
let s:spell_cluster = exists('crystal_spellcheck_strings') ? ',@Spell' : ''
let s:fold_arg      = s:foldable('string') ? ' fold' : ''
exe 'syn region crystalString matchgroup=crystalStringDelimiter start="\"" end="\"" skip="\\\\\|\\\"" contains=@crystalStringSpecial' . s:spell_cluster . s:fold_arg
unlet s:spell_cluster s:fold_arg

" Shell Command Output
SynFold 'string' syn region crystalString matchgroup=crystalStringDelimiter start="`" end="`" skip="\\\\\|\\`" contains=@crystalStringSpecial

" Character
syn match crystalCharLiteral "'\%([^\\]\|\\[abefnrstv'\\]\|\\\o\{1,3}\|\\x\x\{1,2}\|\\u\x\{4}\)'" contains=crystalStringEscape display

" Generalized Single Quoted String, Symbol and Array of Strings
syn region crystalNestedRawParentheses    matchgroup=crystalString start="("  end=")"  transparent contained
syn region crystalNestedRawCurlyBraces    matchgroup=crystalString start="{"  end="}"  transparent contained
syn region crystalNestedRawAngleBrackets  matchgroup=crystalString start="<"  end=">"  transparent contained
syn region crystalNestedRawSquareBrackets matchgroup=crystalString start="\[" end="\]" transparent contained

SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%q("  end=")"  contains=crystalNestedRawParentheses
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%q{"  end="}"  contains=crystalNestedRawCurlyBraces
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%q<"  end=">"  contains=crystalNestedRawAngleBrackets
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%q\[" end="\]" contains=crystalNestedRawSquareBrackets
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%q|"  end="|"

SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[wi]("  end=")"  skip="\\\\\|\\)"  contains=crystalNestedParentheses,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[wi]{"  end="}"  skip="\\\\\|\\}"  contains=crystalNestedCurlyBraces,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[wi]<"  end=">"  skip="\\\\\|\\>"  contains=crystalNestedAngleBrackets,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[wi]\[" end="\]" skip="\\\\\|\\\]" contains=crystalNestedSquareBrackets,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[wi]|"  end="|"  skip="\\\\\|\\|"  contains=crystalDelimEscape

" Generalized Double Quoted String and Array of Strings and Shell Command Output
" Note: %= is not matched here as the beginning of a double quoted string
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[Qx]\=("  end=")"  skip="\\\\\|\\)"  contains=@crystalStringSpecial,crystalNestedParentheses,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[Qx]\={"  end="}"  skip="\\\\\|\\}"  contains=@crystalStringSpecial,crystalNestedCurlyBraces,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[Qx]\=<"  end=">"  skip="\\\\\|\\>"  contains=@crystalStringSpecial,crystalNestedAngleBrackets,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[Qx]\=\[" end="\]" skip="\\\\\|\\\]" contains=@crystalStringSpecial,crystalNestedSquareBrackets,crystalDelimEscape
SynFold '%' syn region crystalString matchgroup=crystalStringDelimiter start="%[Qx]\=|"  end="|"  skip="\\\\\|\\|"  contains=@crystalStringSpecial,crystalDelimEscape

" Here Document
syn region crystalHeredocStart matchgroup=crystalStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs\%(\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\)+ end=+$+ oneline contains=TOP
syn region crystalHeredocStart matchgroup=crystalStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs"\%([^"]*\)"+ end=+$+ oneline contains=TOP
syn region crystalHeredocStart matchgroup=crystalStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs'\%([^']*\)'+ end=+$+ oneline contains=TOP
syn region crystalHeredocStart matchgroup=crystalStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs`\%([^`]*\)`+ end=+$+ oneline contains=TOP

SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<\z(\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2 matchgroup=crystalStringDelimiter end=+^\z1$+ contains=crystalHeredocStart,crystalHeredoc,@crystalStringSpecial keepend
SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<"\z([^"]*\)"\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2 matchgroup=crystalStringDelimiter end=+^\z1$+ contains=crystalHeredocStart,crystalHeredoc,@crystalStringSpecial keepend
SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<'\z([^']*\)'\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2 matchgroup=crystalStringDelimiter end=+^\z1$+ contains=crystalHeredocStart,crystalHeredoc keepend
SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]})"'.]\)\s\|\w\)\@<!<<`\z([^`]*\)`\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+2 matchgroup=crystalStringDelimiter end=+^\z1$+ contains=crystalHeredocStart,crystalHeredoc,@crystalStringSpecial keepend

SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-\z(\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*\)\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3 matchgroup=crystalStringDelimiter end=+^\s*\zs\z1$+ contains=crystalHeredocStart,@crystalStringSpecial keepend
SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-"\z([^"]*\)"\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3 matchgroup=crystalStringDelimiter end=+^\s*\zs\z1$+ contains=crystalHeredocStart,@crystalStringSpecial keepend
SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-'\z([^']*\)'\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3 matchgroup=crystalStringDelimiter end=+^\s*\zs\z1$+ contains=crystalHeredocStart keepend
SynFold '<<' syn region crystalString start=+\%(\%(class\|::\)\_s*\|\%([]}).]\)\s\|\w\)\@<!<<-`\z([^`]*\)`\ze\%(.*<<-\=['`"]\=\h\)\@!+hs=s+3 matchgroup=crystalStringDelimiter end=+^\s*\zs\z1$+ contains=crystalHeredocStart,@crystalStringSpecial keepend

" Module, Class, Method, and Alias Declarations
syn match crystalAliasDeclaration      "[^[:space:];#.()]\+" contained contains=crystalSymbol,crystalPredefinedVariable nextgroup=crystalAliasDeclaration2 skipwhite
syn match crystalAliasDeclaration2     "[^[:space:];#.()]\+" contained contains=crystalSymbol,crystalPredefinedVariable
syn match crystalMethodDeclaration     "[^[:space:];#(]\+"   contained contains=crystalConstant,crystalFunction,crystalBoolean,crystalPseudoVariable,crystalInstanceVariable,crystalClassVariable
syn match crystalFunctionDeclaration   "[^[:space:];#(=]\+"  contained contains=crystalFunction
syn match crystalTypeDeclaration       "[^[:space:];#=]\+"   contained contains=crystalTypeName
syn match crystalClassDeclaration      "[^[:space:];#<]\+"   contained contains=crystalClassName,crystalOperator
syn match crystalModuleDeclaration     "[^[:space:];#]\+"    contained contains=crystalModuleName,crystalOperator
syn match crystalStructDeclaration     "[^[:space:];#<]\+"   contained contains=crystalStructName,crystalOperator
syn match crystalLibDeclaration        "[^[:space:];#]\+"    contained contains=crystalLibName,crystalOperator
syn match crystalMacroDeclaration      "[^[:space:];#(]\+"   contained contains=crystalFunction
syn match crystalEnumDeclaration       "[^[:space:];#<\"]\+" contained contains=crystalEnumName
syn match crystalAnnotationDeclaration "[^[:space:];#]\+"    contained contains=crystalAnnotationName
syn match crystalFunction "\<[_[:alpha:]][_[:alnum:]]*[?!=]\=[[:alnum:]_.:?!=]\@!" contained containedin=crystalMethodDeclaration,crystalFunctionDeclaration
syn match crystalFunction "\%(\s\|^\)\@1<=[_[:alpha:]][_[:alnum:]]*[?!=]\=\%(\s\|$\)\@=" contained containedin=crystalAliasDeclaration,crystalAliasDeclaration2
syn match crystalFunction "\%([[:space:].]\|^\)\@1<=\%(\[\][=?]\=\|\*\*\|[+-]@\=\|[*/%|&^~]\|<<\|>>\|[<>]=\=\|<=>\|===\|[=!]=\|[=!]\~\|!\|`\)\%([[:space:];#(]\|$\)\@=" contained containedin=crystalAliasDeclaration,crystalAliasDeclaration2,crystalMethodDeclaration,crystalFunctionDeclaration

syn cluster crystalDeclaration contains=crystalAliasDeclaration,crystalAliasDeclaration2,crystalMethodDeclaration,crystalFunctionDeclaration,crystalModuleDeclaration,crystalClassDeclaration,crystalStructDeclaration,crystalLibDeclaration,crystalMacroDeclaration,crystalFunction,crystalBlockParameter,crystalTypeDeclaration,crystalEnumDeclaration,crystalAnnotationDeclaration

" Keywords
" Note: the following keywords have already been defined:
" begin case class def do end for if module unless until while
syn match crystalControl        "\<\%(break\|next\|rescue\|return\)\>[?!]\@!"
syn match crystalKeyword        "\<\%(super\|previous_def\|yield\|of\|with\|uninitialized\|union\|out\)\>[?!]\@!"
syn match crystalBoolean        "\<\%(true\|false\)\>[?!]\@!"
syn match crystalPseudoVariable "\<\%(nil\|__DIR__\|__FILE__\|__LINE__\|__END_LINE__\)\>[?!]\@!" " TODO: reorganise
syn match crystalPseudoVariable "\<self\>[?!]\@!"

" Expensive Mode - match 'end' with the appropriate opening keyword for syntax
" based folding and special highlighting of module/class/method definitions
if !exists('b:crystal_no_expensive') && !exists('g:crystal_no_expensive')
  syn match crystalDefine     "\<alias\>"      nextgroup=crystalAliasDeclaration skipwhite skipnl
  syn match crystalDefine     "\<def\>"        nextgroup=crystalMethodDeclaration skipwhite skipnl
  syn match crystalDefine     "\<fun\>"        nextgroup=crystalFunctionDeclaration skipwhite skipnl
  syn match crystalDefine     "\<\%(type\|alias\)\>\%(\s*\h\w*\s*=\)\@=" nextgroup=crystalTypeDeclaration skipwhite skipnl
  syn match crystalClass      "\<class\>"      nextgroup=crystalClassDeclaration skipwhite skipnl
  syn match crystalModule     "\<module\>"     nextgroup=crystalModuleDeclaration skipwhite skipnl
  syn match crystalStruct     "\<struct\>"     nextgroup=crystalStructDeclaration skipwhite skipnl
  syn match crystalLib        "\<lib\>"        nextgroup=crystalLibDeclaration skipwhite skipnl
  syn match crystalMacro      "\<macro\>"      nextgroup=crystalMacroDeclaration skipwhite skipnl
  syn match crystalEnum       "\<enum\>"       nextgroup=crystalEnumDeclaration skipwhite skipnl
  syn match crystalAnnotation "\<annotation\>" nextgroup=crystalAnnotationDeclaration skipwhite skipnl

  SynFold 'def'        syn region crystalMethodBlock start="\<def\>"        matchgroup=crystalDefine     end="\%(\<def\_s\+\)\@<!\<end\>"   contains=TOP,crystalForallKeyword
  SynFold 'macro'      syn region crystalMethodBlock start="\<macro\>"      matchgroup=crystalDefine     end="\%(\<macro\_s\+\)\@<!\<end\>" contains=TOP
  SynFold 'class'      syn region crystalBlock       start="\<class\>"      matchgroup=crystalClass      end="\<end\>"                      contains=TOP
  SynFold 'module'     syn region crystalBlock       start="\<module\>"     matchgroup=crystalModule     end="\<end\>"                      contains=TOP
  SynFold 'struct'     syn region crystalBlock       start="\<struct\>"     matchgroup=crystalStruct     end="\<end\>"                      contains=TOP
  SynFold 'lib'        syn region crystalBlock       start="\<lib\>"        matchgroup=crystalLib        end="\<end\>"                      contains=TOP
  SynFold 'enum'       syn region crystalBlock       start="\<enum\>"       matchgroup=crystalEnum       end="\<end\>"                      contains=TOP
  SynFold 'annotation' syn region crystalBlock       start="\<annotation\>" matchgroup=crystalAnnotation end="\<end\>"                      contains=TOP

  " keywords in method declaration
  syn match crystalForallKeyword "\<forall\>[?!]\@!" contained containedin=crystalMethodBlock

  " modifiers
  syn match crystalConditionalModifier "\<\%(if\|unless\|ifdef\)\>" display

  SynFold 'do' syn region crystalDoBlock matchgroup=crystalControl start="\<do\>" end="\<end\>" contains=TOP

  " curly bracket block or hash literal
  SynFold '{' syn region crystalCurlyBlock   matchgroup=crystalCurlyBlockDelimiter start="{"                      end="}" contains=TOP
  SynFold '[' syn region crystalArrayLiteral matchgroup=crystalArrayDelimiter      start="\%(\w\|[\]})]\)\@1<!\[" end="]" contains=TOP

  " statements without 'do'
  SynFold 'begin'  syn region crystalBlockExpression       matchgroup=crystalControl     start="\<begin\>"             end="\<end\>" contains=TOP
  SynFold 'while'  syn region crystalRepeatExpression      matchgroup=crystalRepeat      start="\<\%(while\|until\)\>" end="\<end\>" contains=TOP
  SynFold 'case'   syn region crystalCaseExpression        matchgroup=crystalConditional start="\<case\>"              end="\<end\>" contains=TOP
  SynFold 'select' syn region crystalSelectExpression      matchgroup=crystalConditional start="\<select\>"            end="\<end\>" contains=TOP
  SynFold 'if'     syn region crystalConditionalExpression matchgroup=crystalConditional start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+=-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![?!]\)\s*\)\@<=\%(if\|ifdef\|unless\)\>" end="\%(\%(\%(\.\@1<!\.\)\|::\)\s*\)\@<!\<end\>" contains=TOP

  syn match crystalConditional "\<\%(then\|else\|when\|in\)\>[?!]\@!" contained containedin=crystalCaseExpression
  syn match crystalConditional "\<\%(when\|else\)\>[?!]\@!" contained containedin=crystalSelectExpression
  syn match crystalConditional "\<\%(then\|else\|elsif\)\>[?!]\@!" contained containedin=crystalConditionalExpression

  syn match crystalExceptional       "\<\%(\%(\%(;\|^\)\s*\)\@<=rescue\|else\|ensure\)\>[?!]\@!" contained containedin=crystalBlockExpression
  syn match crystalMethodExceptional "\<\%(\%(\%(;\|^\)\s*\)\@<=rescue\|else\|ensure\)\>[?!]\@!" contained containedin=crystalMethodBlock

  SynFold 'macro' syn region crystalMacroBlock matchgroup=crystalMacroRegion start="\z(\\\=\){%\s*\%(\%(if\|for\|begin\)\>.*\|.*\<do\>\)\s*%}" end="\z1{%\s*end\s*%}" transparent contains=TOP

  if !exists('g:crystal_minlines')
    let g:crystal_minlines = 500
  endif
  exec 'syn sync minlines=' . g:crystal_minlines
else
  " Non-expensive mode
  syn match crystalControl "\<def\>[?!]\@!"        nextgroup=crystalMethodDeclaration skipwhite skipnl
  syn match crystalControl "\<fun\>[?!]\@!"        nextgroup=crystalFunctionDeclaration skipwhite skipnl
  syn match crystalControl "\<class\>[?!]\@!"      nextgroup=crystalClassDeclaration  skipwhite skipnl
  syn match crystalControl "\<module\>[?!]\@!"     nextgroup=crystalModuleDeclaration skipwhite skipnl
  syn match crystalControl "\<struct\>[?!]\@!"     nextgroup=crystalStructDeclaration skipwhite skipnl
  syn match crystalControl "\<lib\>[?!]\@!"        nextgroup=crystalLibDeclaration skipwhite skipnl
  syn match crystalControl "\<macro\>[?!]\@!"      nextgroup=crystalMacroDeclaration skipwhite skipnl
  syn match crystalControl "\<enum\>[?!]\@!"       nextgroup=crystalEnumDeclaration skipwhite skipnl
  syn match crystalControl "\<annotation\>[?!]\@!" nextgroup=crystalAnnotationDeclaration skipwhite skipnl
  syn match crystalControl "\<\%(case\|begin\|do\|if\|ifdef\|unless\|while\|select\|until\|else\|elsif\|ensure\|then\|when\|in\|end\)\>[?!]\@!"
  syn match crystalKeyword "\<alias\>[?!]\@!"
  syn match crystalForallKeyword "\<forall\>[?!]\@!"
endif

" Link attribute
syn region crystalLinkAttr matchgroup=crystalLinkAttrDelim start="@\[" end="]" contains=TOP display oneline

" Special Methods
if !exists('g:crystal_no_special_methods')
  syn keyword crystalAccess    protected private
  " attr is a common variable name
  syn keyword crystalAttribute abstract
  syn match   crystalAttribute "\<\%(\%(class_\)\=\%(getter\|setter\|property\)[!?]\=\|def_\%(clone\|equals\|equals_and_hash\|hash\)\|delegate\|forward_missing_to\)\s" display
  syn match   crystalControl   "\<\%(abort\|at_exit\|exit\|fork\|loop\)\>[?!]\@!" display
  syn keyword crystalException raise
  " false positive with 'include?'
  syn match   crystalInclude   "\<include\>[?!]\@!" display
  syn keyword crystalInclude   extend require
  syn keyword crystalKeyword   caller typeof pointerof sizeof instance_sizeof offsetof
  syn match   crystalRecord    "\<record\%(\s\+\u\w*\)\@=" display
endif

" Macro
" Note: This definition must be put after crystalNestedCurlyBraces to give higher priority
syn region crystalMacroRegion matchgroup=crystalMacroDelim start="\\\={%" end="%}" display oneline contains=@crystalMacroGroup containedin=ALL
syn region crystalMacroRegion matchgroup=crystalMacroDelim start="\\\={{" end="}}" display contains=TOP containedin=ALL

" Cluster for groups that can appear inside macro expressions
syn cluster crystalMacroGroup contains=@crystalTop

" Cluster for Expensive Mode groups that can't appear inside macro
" regions
syn cluster crystalExpensive contains=
      \ crystalMethodBlock,crystalBlock,crystalDoBlock,crystalBlockExpression,crystalRepeatExpression,
      \ crystalCaseExpression,crystalSelectExpression,crystalConditionalExpression

syn cluster crystalMacroGroup remove=@crystalExpensive

" Some keywords will have to be redefined for them to be highlighted
" properly
syn keyword crystalMacroKeyword contained
      \ if unless else elsif end for in do while until loop begin

syn cluster crystalMacroGroup add=crystalMacroKeyword

" Comments and Documentation
syn match   crystalSharpBang "\%^#!.*" display
syn keyword crystalTodo      FIXME NOTE TODO OPTIMIZE XXX todo contained
syn match   crystalCommentDirective ":\%(nodoc\|nodoc\|inherit\):" contained

if exists('g:main_syntax') && g:main_syntax ==# 'ecrystal'
  " eCrystal tags can contain Crystal comments, so we need to modify the
  " pattern for comments so that it does not consume delimiters
  syn match crystalComment "#.*\ze\%($\|-\=%>\)" contains=crystalSharpBang,crystalSpaceError,crystalTodo,crystalCommentDirective,@Spell
else
  syn match crystalComment "#.*" contains=crystalSharpBang,crystalSpaceError,crystalTodo,crystalCommentDirective,@Spell
endif

SynFold '#' syn region crystalMultilineComment start="\%(\%(^\s*#.*\n\)\@<!\%(^\s*#.*\n\)\)\%(\(^\s*#.*\n\)\{1,}\)\@=" end="\%(^\s*#.*\n\)\@<=\%(^\s*#.*\n\)\%(^\s*#\)\@!" contains=crystalComment transparent keepend

" Note: this is a hack to prevent 'keywords' being highlighted as such when called as methods with an explicit receiver
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(alias\|begin\|break\|case\|class\|def\|defined\|do\|else\|select\)\>" transparent contains=NONE
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(elsif\|end\|ensure\|false\|for\|if\|ifdef\|in\|module\|next\|nil\)\>" transparent contains=NONE
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(rescue\|return\|self\|super\|previous_def\|then\|true\)\>" transparent contains=NONE
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(unless\|until\|when\|in\|while\|yield\|with\|__FILE__\|__LINE__\)\>" transparent contains=NONE

syn match crystalKeywordAsMethod "\<\%(alias\|begin\|case\|class\|def\|do\|end\)[?!]" transparent contains=NONE
syn match crystalKeywordAsMethod "\<\%(if\|ifdef\|module\|unless\|until\|while\)[?!]" transparent contains=NONE

syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(abort\|at_exit\|caller\|exit\)\>" transparent contains=NONE
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(extend\|fork\|include\|asm\)\>" transparent contains=NONE
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(loop\|private\|protected\)\>" transparent contains=NONE
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(require\|raise\)\>" transparent contains=NONE
syn match crystalKeywordAsMethod "\%(\%(\.\@1<!\.\)\|::\)\_s*\%(typeof\|pointerof\|sizeof\|instance_sizeof\|offsetof\|\)\>" transparent contains=NONE

hi def link crystalClass               crystalDefine
hi def link crystalModule              crystalDefine
hi def link crystalStruct              crystalDefine
hi def link crystalLib                 crystalDefine
hi def link crystalEnum                crystalDefine
hi def link crystalAnnotation          crystalDefine
hi def link crystalMethodExceptional   crystalDefine
hi def link crystalDefine              Define
hi def link crystalFunction            Function
hi def link crystalConditional         Conditional
hi def link crystalConditionalModifier crystalConditional
hi def link crystalExceptional         crystalConditional
hi def link crystalRepeat              Repeat
hi def link crystalControl             Statement
hi def link crystalInclude             Include
hi def link crystalRecord              Statement
hi def link crystalInteger             Number
hi def link crystalASCIICode           Character
hi def link crystalFloat               Float
hi def link crystalBoolean             Boolean
hi def link crystalException           Exception
if !exists('g:crystal_no_identifiers')
  hi def link crystalIdentifier Identifier
else
  hi def link crystalIdentifier NONE
endif
hi def link crystalClassVariable        crystalIdentifier
hi def link crystalConstant             Type
hi def link crystalTypeName             crystalConstant
hi def link crystalClassName            crystalConstant
hi def link crystalModuleName           crystalConstant
hi def link crystalStructName           crystalConstant
hi def link crystalLibName              crystalConstant
hi def link crystalEnumName             crystalConstant
hi def link crystalAnnotationName       crystalConstant
hi def link crystalBlockParameter       crystalIdentifier
hi def link crystalInstanceVariable     crystalIdentifier
hi def link crystalFreshVariable        crystalIdentifier
hi def link crystalPredefinedIdentifier crystalIdentifier
hi def link crystalPredefinedConstant   crystalPredefinedIdentifier
hi def link crystalPredefinedVariable   crystalPredefinedIdentifier
hi def link crystalSymbol               Constant
hi def link crystalKeyword              Keyword
hi def link crystalOperator             Operator
hi def link crystalAccess               Statement
hi def link crystalAttribute            Statement
hi def link crystalPseudoVariable       Constant
hi def link crystalCharLiteral          Character
hi def link crystalComment              Comment
hi def link crystalTodo                 Todo
hi def link crystalCommentDirective     SpecialComment
hi def link crystalStringEscape         Special
hi def link crystalInterpolationDelim   Delimiter
hi def link crystalNoInterpolation      crystalString
hi def link crystalSharpBang            PreProc
hi def link crystalRegexpDelimiter      crystalStringDelimiter
hi def link crystalSymbolDelimiter      crystalStringDelimiter
hi def link crystalStringDelimiter      Delimiter
hi def link crystalString               String
hi def link crystalHeredoc              crystalString
hi def link crystalRegexpEscape         crystalRegexpSpecial
hi def link crystalRegexpQuantifier     crystalRegexpSpecial
hi def link crystalRegexpAnchor         crystalRegexpSpecial
hi def link crystalRegexpDot            crystalRegexpCharClass
hi def link crystalRegexpCharClass      crystalRegexpSpecial
hi def link crystalRegexpSpecial        Special
hi def link crystalRegexpComment        Comment
hi def link crystalRegexp               crystalString
hi def link crystalMacro                PreProc
hi def link crystalMacroDelim           crystalMacro
hi def link crystalMacroKeyword         crystalKeyword
hi def link crystalForallKeyword        crystalDefine
hi def link crystalLinkAttrDelim        crystalMacroDelim
hi def link crystalError                Error
hi def link crystalSpaceError           crystalError
hi def link crystalInvalidInteger       crystalError

let b:current_syntax = 'crystal'

delc SynFold

" vim: sw=2 sts=2 et:
