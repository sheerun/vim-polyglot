if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1

"Syntax coloring for Node.js shebang line
syntax match   shellbang "^#!.*node\>"
syntax match   shellbang "^#!.*iojs\>"


"JavaScript comments
syntax keyword typescriptCommentTodo TODO FIXME XXX TBD
syntax match   typescriptLineComment "//.*"
  \ contains=@Spell,typescriptCommentTodo,typescriptRef
syntax region  typescriptComment
  \ start="/\*"  end="\*/"
  \ contains=@Spell,typescriptCommentTodo extend
syntax cluster typescriptComments
  \ contains=typescriptDocComment,typescriptComment,typescriptLineComment

syntax match   typescriptRef  +///\s*<reference\s\+.*\/>$+
  \ contains=typescriptString
syntax match   typescriptRef  +///\s*<amd-dependency\s\+.*\/>$+
  \ contains=typescriptString
syntax match   typescriptRef  +///\s*<amd-module\s\+.*\/>$+
  \ contains=typescriptString

"JSDoc
syntax case ignore

syntax region  typescriptDocComment            matchgroup=typescriptComment
  \ start="/\*\*"  end="\*/"
  \ contains=typescriptDocNotation,typescriptCommentTodo,@Spell
  \ fold keepend
syntax match   typescriptDocNotation           contained /@/ nextgroup=typescriptDocTags

syntax keyword typescriptDocTags               contained constant constructor constructs function ignore inner private public readonly static
syntax keyword typescriptDocTags               contained const dict expose inheritDoc interface nosideeffects override protected struct internal
syntax keyword typescriptDocTags               contained example global
syntax keyword typescriptDocTags               contained alpha beta defaultValue eventProperty experimental label
syntax keyword typescriptDocTags               contained packageDocumentation privateRemarks remarks sealed typeParam

" syntax keyword typescriptDocTags               contained ngdoc nextgroup=typescriptDocNGDirective
syntax keyword typescriptDocTags               contained ngdoc scope priority animations
syntax keyword typescriptDocTags               contained ngdoc restrict methodOf propertyOf eventOf eventType nextgroup=typescriptDocParam skipwhite
syntax keyword typescriptDocNGDirective        contained overview service object function method property event directive filter inputType error

syntax keyword typescriptDocTags               contained abstract virtual access augments

syntax keyword typescriptDocTags               contained arguments callback lends memberOf name type kind link mixes mixin tutorial nextgroup=typescriptDocParam skipwhite
syntax keyword typescriptDocTags               contained variation nextgroup=typescriptDocNumParam skipwhite

syntax keyword typescriptDocTags               contained author class classdesc copyright default defaultvalue nextgroup=typescriptDocDesc skipwhite
syntax keyword typescriptDocTags               contained deprecated description external host nextgroup=typescriptDocDesc skipwhite
syntax keyword typescriptDocTags               contained file fileOverview overview namespace requires since version nextgroup=typescriptDocDesc skipwhite
syntax keyword typescriptDocTags               contained summary todo license preserve nextgroup=typescriptDocDesc skipwhite

syntax keyword typescriptDocTags               contained borrows exports nextgroup=typescriptDocA skipwhite
syntax keyword typescriptDocTags               contained param arg argument property prop module nextgroup=typescriptDocNamedParamType,typescriptDocParamName skipwhite
syntax keyword typescriptDocTags               contained define enum extends implements this typedef nextgroup=typescriptDocParamType skipwhite
syntax keyword typescriptDocTags               contained return returns throws exception nextgroup=typescriptDocParamType,typescriptDocParamName skipwhite
syntax keyword typescriptDocTags               contained see nextgroup=typescriptDocRef skipwhite

syntax keyword typescriptDocTags               contained function func method nextgroup=typescriptDocName skipwhite
syntax match   typescriptDocName               contained /\h\w*/

syntax keyword typescriptDocTags               contained fires event nextgroup=typescriptDocEventRef skipwhite
syntax match   typescriptDocEventRef           contained /\h\w*#\(\h\w*\:\)\?\h\w*/

syntax match   typescriptDocNamedParamType     contained /{.\+}/ nextgroup=typescriptDocParamName skipwhite
syntax match   typescriptDocParamName          contained /\[\?0-9a-zA-Z_\.]\+\]\?/ nextgroup=typescriptDocDesc skipwhite
syntax match   typescriptDocParamType          contained /{.\+}/ nextgroup=typescriptDocDesc skipwhite
syntax match   typescriptDocA                  contained /\%(#\|\w\|\.\|:\|\/\)\+/ nextgroup=typescriptDocAs skipwhite
syntax match   typescriptDocAs                 contained /\s*as\s*/ nextgroup=typescriptDocB skipwhite
syntax match   typescriptDocB                  contained /\%(#\|\w\|\.\|:\|\/\)\+/
syntax match   typescriptDocParam              contained /\%(#\|\w\|\.\|:\|\/\|-\)\+/
syntax match   typescriptDocNumParam           contained /\d\+/
syntax match   typescriptDocRef                contained /\%(#\|\w\|\.\|:\|\/\)\+/
syntax region  typescriptDocLinkTag            contained matchgroup=typescriptDocLinkTag start=/{/ end=/}/ contains=typescriptDocTags

syntax cluster typescriptDocs                  contains=typescriptDocParamType,typescriptDocNamedParamType,typescriptDocParam

if main_syntax == "typescript"
  syntax sync clear
  syntax sync ccomment typescriptComment minlines=200
endif

syntax case match

endif
