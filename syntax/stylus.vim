if polyglot#init#is_disabled(expand('<sfile>:p'), 'stylus', 'syntax/stylus.vim')
  finish
endif

" Vim syntax file
" Language:	Stylus
" Author:	Ilia Loginov <iloginow@outlook.com>
" Created:	Jan 5, 2018

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'stylus'
endif

syntax case ignore

" First of all define indented and not indented lines
syntax match stylusNewLine "^\S\@="
      \ nextgroup=stylusComment,stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusVariable,stylusExplicitVariable,stylusInterpolationSelectors,stylusFunctionName,stylusConditional,stylusOperatorReturn,stylusAtRuleMedia,stylusAtRuleKeyframes,stylusAtRuleNamespace,stylusAtRuleSupports,stylusAtRuleDocument,stylusAtRulePage,stylusAtRuleViewport

syntax match stylusNewLineIndented "^\s\+"
      \ nextgroup=stylusComment,stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusProperty,stylusVariable,stylusExplicitVariable,stylusInterpolation,stylusFunctionName,stylusUnitInt,stylusParenthesised,stylusOperatorReturn,stylusConditional,stylusAtRuleMedia,stylusAtRuleKeyframes,stylusAtRuleKeyframesOffset,stylusAtRuleNamespace,stylusAtRuleSupports,stylusAtRuleDocument,stylusAtRulePageMarginBoxTypes,stylusAtRuleViewport,stylusAtRuleExtends

" ===============================================
" ENCLOSURES
" ===============================================

syntax match stylusEnclosure "\(\[\|\]\|{\|}\|(\|)\)"
      \ contained

highlight def link stylusEnclosure SpecialChar

" ===============================================
" VARIABLES
" ===============================================

syntax match stylusVariable "\<\(\w\|-\|\$\)*\>"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusOperatorAssignment,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusSubscript,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorVarDefinition,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional,stylusHashDotGetter
      \ skipwhite

syntax match stylusExplicitVariable "\$\(\w\|-\|\$\)*\>"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusOperatorAssignment,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusSubscript,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorVarDefinition,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional,stylusHashDotGetter,stylusOptional
      \ skipwhite

syntax match stylusExplicitVariable "\<arguments\|block\>"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusSubscript,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorVarDefinition,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional,stylusHashDotGetter
      \ skipwhite

highlight def link stylusExplicitVariable Identifier

" ===============================================
" OPERATORS
" ===============================================

" Unary
syntax match stylusOperatorUnary "\([-+\!\~]\+\|\<not\>\)"
      \ contained
      \ nextgroup=stylusVariable,stylusExplicitVariable,stylusUnitInt,stylusUnitFloat,stylusParenthesised,stylusPropertyLookup,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorUnary Operator

" Additive
syntax match stylusOperatorAdditive "[-+]"
      \ contained
      \ nextgroup=stylusVariable,stylusExplicitVariable,stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusParenthesised,stylusPropertyLookup,stylusColor,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorAdditive Operator

" Multiplicative
syntax match stylusOperatorMultiplicative "\([/\%]\|\*\{1,2}\)"
      \ contained
      \ nextgroup=stylusVariable,stylusExplicitVariable,stylusUnitInt,stylusUnitFloat,stylusParenthesised,stylusPropertyLookup,stylusFunctionName
      \ skipwhite
highlight def link stylusOperatorMultiplicative Operator

" Ternary
syntax match stylusOperatorTernary "[:?]"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorTernary Operator

" Assignment
syntax match stylusOperatorAssignment "[/\*+-:?]\=="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName,stylusHash,stylusAtRuleBlock
      \ skipwhite

highlight def link stylusOperatorAssignment Operator

" Relational
syntax match stylusOperatorRelational "\(=\{2}\|\<is\>\(\s\<not\>\)\=\|\!=\|\<isnt\>\|>=\|<=\|>\|<\)"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusVariable,stylusExplicitVariable,stylusParenthesised,stylusPropertyLookup,stylusColor,stylusBoolean,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorRelational Operator

" Logical
syntax match stylusOperatorLogical "\(&&\|||\|\<and\>\|\<or\>\)"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorLogical Operator

" Existence
syntax match stylusOperatorExistence "\<in\>"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorExistence Operator

" Instance
syntax match stylusOperatorInstance "\<is a\>"
      \ contained
      \ skipwhite

highlight def link stylusOperatorInstance Operator

" Variable definition
syntax match stylusOperatorVarDefinition "\<is defined\>"
      \ contained
      \ nextgroup=stylusOperatorLogical,stylusOperatorTernary,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorVarDefinition Operator

" Return
syntax match stylusOperatorReturn "\<return\>"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

highlight def link stylusOperatorReturn Operator

" Comma
syntax match stylusComma /,\(\s\=\(\a\w\{-}:\|\('\|"\).\{-}\('\|"\):\)\)\@!/
      \ containedin=ALLBUT,stylusString,stylusComment,stylusHash,stylusAtRuleMediaComma
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

" Range
syntax match stylusOperatorRange "\.\.\.\="
      \ contained
      \ nextgroup=stylusUnitInt,stylusVariable,stylusExplicitVariable,stylusFunctionName

highlight def link stylusOperatorRange Operator

" ===============================================
" CONDITIONALS
" ===============================================

syntax match stylusConditional "\<\(if\|else\|unless\|for\)\>"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName,stylusConditional
      \ skipwhite

highlight def link stylusConditional Conditional

" ===============================================
" SPRINTF
" ===============================================

syntax match stylusSprintfPlaceholder "%s"
      \ contained

highlight def link stylusSprintfPlaceholder Operator

syntax match stylusSprintfDefinition "%"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

highlight def link stylusSprintfDefinition Operator

" ===============================================
" SUBSCRIPT
" ===============================================

syntax region stylusSubscript matchgroup=stylusEnclosure start="\[" end="\]"
      \ contained
      \ contains=stylusExplicitVariable,stylusVariable,stylusUnitInt,stylusParenthesised,stylusPropertyLookup,stylusFunctionName
      \ keepend
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional,stylusOperatorAssignment,stylusHashDotGetter
      \ oneline
      \ skipwhite

" ===============================================
" UNITS
" ===============================================

syntax match stylusUnitInt "[-+]\=\d\+%\="
      \ contained
      \ nextgroup=stylusOperatorRange,stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite

syntax match stylusUnitInt "\<PI\>"
      \ contained
      \ nextgroup=stylusOperatorRange,stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite

highlight def link stylusUnitInt Number

syntax match stylusUnitFloat "[-+]\=\d\=\.\d\+%\="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite

highlight def link stylusUnitFloat Number

execute 'syntax match stylusUnitName "\(\<\|\d\@<=\)\(' . join(g:css_units, '\|') . '\)\>"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite'

highlight def link stylusUnitName Number

" Resolve 'in' unit name and operator conflict
syntax match stylusOperatorExistence "\s\@<=\<in\>"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName
      \ skipwhite

" ===============================================
" BOOLEAN
" ===============================================

syntax match stylusBoolean "\<\(true\|false\|null\)\>"
      \ contained
      \ nextgroup=stylusOperatorRelational,stylusOperatorAssignment,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusFunctionName,stylusConditional
      \ skipwhite

highlight def link stylusBoolean Boolean

" ===============================================
" SELECTORS
" ===============================================

" HTML or SVG elements
execute 'syn match stylusSelectorElement "\<\(' . join(g:html_elements, '\|') . '\)\(\>\|#\@=\)"
      \ contained
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional
      \ oneline
      \ skipwhite'

syn match stylusSelectorElement "\(^\|\s\)\@<=\*\($\|\s\)\@="
      \ contained
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional
      \ oneline
      \ skipwhite

highlight def link stylusSelectorElement Statement

" CSS Class
syntax region stylusSelectorClass start="\." skip="\w-\@=" end="\(\w\|-+\)\(\W\|$\)\@="
      \ contained
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional,stylusOptional
      \ oneline
      \ skipwhite

syntax match stylusSelectorClass "\.{\@="
      \ contained
      \ nextgroup=stylusInterpolationSelectors

highlight def link stylusSelectorClass Identifier

" CSS Id
syntax region stylusSelectorId start="#" skip="\w-\@=" end="\(\w\|-+\)\(\W\|$\)\@="
      \ contained
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional
      \ oneline
      \ skipwhite

syntax match stylusSelectorId "#{\@="
      \ contained
      \ nextgroup=stylusInterpolationSelectors

highlight def link stylusSelectorId Identifier

" Attribute selectors
syntax match stylusSelectorAttributeOperator "\(=\|\~=\||=\|\^=\|\$=\|\*=\)"
      \ contained

highlight def link stylusSelectorAttributeOperator Operator

syntax region stylusSelectorAttribute matchgroup=stylusEnclosure start="\[" skip="{.\{-}}" end="\]"
      \ contained
      \ contains=stylusSelectorAttributeOperator,stylusInterpolation
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional
      \ oneline
      \ skipwhite

highlight def link stylusSelectorAttribute Type

" Parent reference
syntax match stylusSelectorReference "\(&\|\~/\|\(\.\./\)\+\|/\)"
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional
      \ skipwhite

highlight def link stylusSelectorReference Statement

" Partial reference
syntax region stylusSelectorPartialReference matchgroup=stylusSelectorReference start="\^\[\@=" skip="{.\{-}}" matchgroup=NONE end="\]"
      \ contained
      \ contains=stylusEnclosure,stylusUnitInt,stylusInterpolation
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional
      \ oneline
      \ skipwhite

syntax region stylusSelectorClass start="\(&\|\~/\|\(\.\./\)\+\|/\)" skip="\w[-()]\@=" end="\(\w\|(\|)\)\(\W\|$\)\@="
      \ contained
      \ contains=stylusSelectorReference
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusOptional
      \ oneline
      \ skipwhite

" CSS pseudo classes and elements
execute 'syntax match stylusSelectorPseudo ":\(' . join(g:css_pseudo, '\|') . '\)-\@!"
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusSelectorPseudo,stylusOptional
      \ skipwhite'

syntax match stylusSelectorPseudo ":\(\(first\|last\|only\)-\(child\|of-type\)\)"
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusSelectorPseudo,stylusOptional
      \ skipwhite

syntax match stylusSelectorPseudo ":not(.\{-})"
      \ contained
      \ contains=stylusSelectorElement,stylusEnclosure,stylusInterpolationSelectors
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusSelectorPseudo,stylusOptional
      \ skipwhite

syntax match stylusSelectorPseudo ":lang(.\{-})"
      \ contained
      \ contains=stylusEnclosure,stylusInterpolationSelectors
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusSelectorPseudo,stylusOptional
      \ skipwhite

syntax match stylusSelectorPseudo ":\(nth-last-\|nth-\)\(child\|of-type\)(.\{-})"
      \ contained
      \ contains=stylusUnitInt,stylusEnclosure,stylusInterpolationSelectors
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusSelectorPseudo,stylusOptional
      \ skipwhite

syntax match stylusSelectorPseudo /::\=\(first-\(line\|letter\)\|before\|after\|selection\|placeholder\)/
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusSelectorPseudo,stylusOptional
      \ skipwhite

highlight def link stylusSelectorPseudo Define

" CSS Selector operators
syntax match stylusSelectorCombinator "[>\~+|,]"
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusExplicitVariable
      \ skipwhite

highlight def link stylusSelectorCombinator Operator

" ===============================================
" PROPERTIES
" ===============================================

execute 'syntax match stylusProperty "\<\(' . join(g:css_single_props, '\|') . '\)\>-\@!:\="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite'

execute 'syntax match stylusProperty "\<\(' . join(g:css_multi_props, '\|') . '\)\>-\@!:\="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite'

execute 'syntax match stylusProperty "\<\(' . join(g:svg_props, '\|') . '\)\>-\@!:\="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite'

syntax match stylusProperty "\(-webkit-\|-moz-\|-o-\|-ms-\|-khtml-\)\(\w\|-\)*:\="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite

highlight def link stylusProperty Type

" ===============================================
" PROPERTY LOOKUP
" ===============================================

execute 'syntax match stylusPropertyLookup "@\(' . join(g:css_props, '\|') . '\)\>-\@!"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite'

execute 'syntax match stylusPropertyLookup "@\(' . join(g:svg_props, '\|') . '\)\>-\@!"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite'

syntax match stylusPropertyLookup "@\(-webkit-\|-moz-\|-o-\|-ms-\|-khtml-\)\(\w\|-\)*"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite

highlight def link stylusPropertyLookup Type

" ===============================================
" VALUES
" ===============================================

execute 'syntax match stylusValues "\<\(' . join(g:css_values, '\|') . '\)\>-\@!"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName
      \ skipwhite'

execute 'syntax match stylusValues "\<\(' . join(g:css_animatable_props, '\|') . '\)\>-\@!"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName
      \ skipwhite'

highlight def link stylusValues PreCondit

" ===============================================
" COLORS
" ===============================================

" Named
execute 'syntax match stylusColor "\<\(' . join(g:css_colors, '\|') . '\)\>-\@!"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusOperatorAdditive,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite'

syntax match stylusColor "\<transparent\>"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusOperatorAdditive,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite

" Hexadecimal
syntax match stylusColor "#\x\{3,6\}\>"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusOperatorAdditive,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite

highlight stylusColor term=underline ctermfg=133 guifg=#b169b2

" ===============================================
" FONT
" ===============================================

" Highlight generic font families
syntax match stylusFont "\<\(serif\|sans-serif\|monospace\)\>"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite

highlight def link stylusFont Directory

" ===============================================
" Explicitly point out that the word before assignment operator is a variable
syntax match stylusVariable "\<\(\w\|-\)*\(\s\=[:?]\==[^=]\)\@="
      \ contained
      \ nextgroup=stylusOperatorAssignment
      \ skipwhite
" ===============================================

" ===============================================
" IMPORTANT
" ===============================================

syntax match stylusImportant "!important"
      \ contained

highlight def link stylusImportant Special

" ===============================================
" INTERPOLATION
" ===============================================

" Prepend is always a property
syntax match stylusProperty "\(\w\|-\)\+{\@="
      \ contained
      \ nextgroup=stylusInterpolationProperties

syntax region stylusInterpolation matchgroup=stylusEnclosure start="{" end="}"
      \ contained
      \ contains=stylusVariable,stylusExplicitVariable,stylusOperatorUnary,stylusUnitInt,stylusUnitFloat,stylusParenthesised,stylusConditional,stylusFunctionName
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusInterpolationSelectorsTail,stylusInterpolationPropertiesTail,stylusFunctionName
      \ oneline
      \ skipwhite

syntax region stylusInterpolationSelectors matchgroup=stylusEnclosure start="{" end="}"
      \ contained
      \ contains=stylusVariable,stylusExplicitVariable,stylusOperatorUnary,stylusUnitInt,stylusUnitFloat,stylusParenthesised,stylusConditional,stylusFunctionName
      \ keepend
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectorsTail
      \ oneline
      \ skipwhite

syntax region stylusInterpolationProperties matchgroup=stylusEnclosure start="{" end="}"
      \ contained
      \ contains=stylusVariable,stylusExplicitVariable,stylusOperatorUnary,stylusUnitInt,stylusUnitFloat,stylusParenthesised,stylusConditional,stylusFunctionName
      \ keepend
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusProperty,stylusInterpolationPropertiesTail,stylusFunctionName
      \ oneline
      \ skipwhite

syntax match stylusInterpolationPropertiesTail "}\@<=\(\w\|-\)\+"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusProperty,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite

highlight def link stylusInterpolationPropertiesTail Type

" Tail is a selector by default
syntax match stylusInterpolationSelectorsTail "}\@<=\(\w\|-\)\+"
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors
      \ skipwhite

highlight def link stylusInterpolationSelectorsTail Identifier

" Tail is a property if followed by anything
syntax match stylusInterpolationPropertiesTail "}\@<=\(\w\|-\)\+:\=\s\S\@="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusProperty,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite

" Tail is a selector if followed by .#[]$~^&
syntax match stylusInterpolationSelectorsTail "}\@<=\(\w\|-\)\+:\=\s[\.#\[~^&+|,>]\@="
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors
      \ skipwhite

" Tail is a property if followed by float number
syntax match stylusInterpolationPropertiesTail "}\@<=\(\w\|-\)\+:\=\s\(\.\d\)\@="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusProperty,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite

" Tail is a property if followed by hex color
syntax match stylusInterpolationPropertiesTail "}\@<=\(\w\|-\)\+:\=\s\(#\x\{3,6}\)\@="
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusProperty,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite

execute 'syntax match stylusInterpolationSelectorsTail "}\@<=\(\w\|-\)\+:\=\s\(' . join(g:html_elements, '\|') . '\)\@="
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors
      \ skipwhite'

" ===============================================
" MIXINS & FUNCTIONS
" ===============================================

syntax match stylusFunctionBlock "+"
      \ contained

highlight def link stylusFunctionBlock Operator

syntax match stylusFunctionRest "\w\@<=\.\.\."
      \ contained

highlight def link stylusFunctionRest Operator

syntax match stylusFunctionName "\(\<\|+\)\(\w\|\$\)\(-\|\w\|\$\)\{-}(\@="
      \ contained
      \ contains=stylusFunctionBlock
      \ nextgroup=stylusFunctionProps

syntax match stylusFunctionName "@\{-}(\@="
      \ contained
      \ contains=stylusFunctionBlock
      \ nextgroup=stylusFunctionProps

highlight def link stylusFunctionName Function

syntax region stylusFunctionProps matchgroup=stylusEnclosure start="\S\@<=(" end=")"
      \ contained
      \ contains=stylusOperatorUnary,stylusVariable,stylusExplicitVariable,stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusColor,stylusFunctionName,stylusFunctionRest,stylusValues
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusSubscript,stylusConditional,stylusOperatorRelational
      \ skipwhite


" ===============================================
" PARENTHESISED EXPRESSIONS
" ===============================================

syntax region stylusParenthesised matchgroup=stylusEnclosure start="\W\@<=(" skip=/["'].\{-}["']/ end=")"
      \ contained
      \ contains=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ keepend
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusUnitName,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ oneline
      \ skipwhite

" Resolve '%' unit name and operator conflict
syntax match stylusUnitName ")\@<=%"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional
      \ skipwhite
" ===============================================
" STRINGS
" ===============================================

syntax region stylusString start=/\('\|"\)/ end=/\('\|"\)/
      \ containedin=ALLBUT,stylusComment,stylusHash,stylusHashStringKey
      \ contains=stylusSprintfPlaceholder
      \ keepend
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusOperatorAdditive,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorTernary,stylusSprintfDefinition,stylusImportant,stylusFunctionName,stylusConditional
      \ oneline
      \ skipwhite

highlight def link stylusString String

" ===============================================
" HASHES
" ===============================================

syntax match stylusHashKey "\a\w\{-}:"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName,stylusHash,stylusString
      \ skipwhite

highlight def link stylusHashKey NonText

syntax region stylusHashStringKey start=/\('\|"\)/ end=/\('\|"\):/
      \ contained
      \ keepend
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusBoolean,stylusFunctionName,stylusHash,stylusString
      \ oneline
      \ skipwhite

highlight def link stylusHashStringKey String

syntax match stylusHashDotGetter "\S\@<=\."
      \ contained
      \ nextgroup=stylusHashIdent

highlight def link stylusHashDotGetter Operator

syntax match stylusHashComma ","
      \ contained
      \ nextgroup=stylusHashKey,stylusHashStringKey
      \ skipwhite

syntax match stylusHashIdent "\<\(\w\|-\|\$\)*\>"
      \ contained
      \ nextgroup=stylusColor,stylusUnitInt,stylusUnitFloat,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusOperatorAssignment,stylusPropertyLookup,stylusParenthesised,stylusOperatorAdditive,stylusOperatorMultiplicative,stylusSubscript,stylusOperatorRelational,stylusOperatorLogical,stylusOperatorExistence,stylusOperatorInstance,stylusOperatorVarDefinition,stylusOperatorTernary,stylusImportant,stylusFunctionName,stylusConditional,stylusHashDotGetter
      \ skipwhite

highlight def link stylusHashIdent NonText

syntax region stylusHash matchgroup=stylusEnclosure start="{" end="}"
      \ contained
      \ contains=stylusHashKey,stylusHashStringKey,stylusHash,stylusHashComma
      \ skipwhite

" ===============================================
" @ RULES
" ===============================================

syntax match stylusAtRuleImport "@\(import\|require\)\>"
      \ containedin=ALLBUT,stylusString,stylusComment
      \ nextgroup=stylusFunctionName,stylusVariable,stylusExplicitVariable
      \ skipwhite

highlight def link stylusAtRuleImport Macro

syntax match stylusAtRuleMedia "@media\>"
      \ contained
      \ nextgroup=stylusAtRuleMediaType,stylusAtRuleMediaFeatureExpression
      \ skipwhite

highlight def link stylusAtRuleMedia Macro

syntax match stylusAtRuleMediaType "\<\(all\|print\|screen\|speech\)\>"
      \ contained
      \ nextgroup=stylusAtRuleMediaType,stylusAtRuleMediaFeatureExpression,stylusAtRuleMediaLogical
      \ skipwhite

highlight def link stylusAtRuleMediaType Macro

syntax match stylusAtRuleMediaLogical "\<\(and\|not\|only\)\>"
      \ contained
      \ nextgroup=stylusAtRuleMediaType,stylusAtRuleMediaFeatureExpression,stylusAtRuleMediaLogical
      \ skipwhite

highlight def link stylusAtRuleMediaLogical Operator

syntax region stylusAtRuleMediaFeatureExpression matchgroup=stylusEnclosure start="(" end=")"
      \ contained
      \ contains=stylusAtRuleMediaFeature,stylusInterpolationProperties,stylusInterpolationPropertiesTail
      \ nextgroup=stylusAtRuleMediaComma,stylusAtRuleMediaLogical
      \ oneline
      \ skipwhite

execute 'syntax match stylusAtRuleMediaFeature "\(min-\|max-\)\=\(' . join(g:css_media_features, '\|') . '\)\>:"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite'

syntax match stylusAtRuleMediaFeature "\(\w\|-\)\+{\@="
      \ contained
      \ nextgroup=stylusInterpolationProperties

syntax match stylusAtRuleMediaFeature "}\@<=:"
      \ contained
      \ nextgroup=stylusUnitInt,stylusUnitFloat,stylusColor,stylusValues,stylusFont,stylusVariable,stylusExplicitVariable,stylusPropertyLookup,stylusParenthesised,stylusOperatorUnary,stylusInterpolationProperties,stylusFunctionName
      \ skipwhite

highlight def link stylusAtRuleMediaFeature Type

syntax match stylusAtRuleMediaComma ","
      \ contained
      \ nextgroup=stylusAtRuleMediaFeatureExpression
      \ skipwhite

syntax match stylusAtRuleFont "@font-face\>"
      \ containedin=ALLBUT,stylusString,stylusComment

highlight def link stylusAtRuleFont Macro

syntax match stylusAtRuleKeyframes "@\(-\(o\|webkit\|moz\)-\)\=keyframesi\>"
      \ contained
      \ nextgroup=stylusAtRuleKeyframesName,stylusInterpolationSelectors
      \ skipwhite

highlight def link stylusAtRuleKeyframes Macro

syntax match stylusAtRuleKeyframesName "\<\(\w\|-\|\$\)*\>"
      \ contained
      \ nextgroup=stylusInterpolationSelectors
      \ skipwhite

highlight def link stylusAtRuleKeyframesName Identifier

syntax match stylusAtRuleKeyframesOffset "\d\{1,3}%"
      \ contained

syntax match stylusAtRuleKeyframesOffset "\<\(from\|to\)\>"
      \ contained

highlight def link stylusAtRuleKeyframesOffset Macro

syntax match stylusAtRuleNamespace "@namespace\>"
      \ contained
      \ nextgroup=stylusAtRuleNamespacePrefix,stylusAtRuleNamespaceUrl
      \ skipwhite

highlight def link stylusAtRuleNamespace Macro

syntax match stylusAtRuleNamespacePrefix "\<\(\w\|-\|\$\)*\>"
      \ contained
      \ nextgroup=stylusAtRuleNamespaceUrl
      \ skipwhite

highlight def link stylusAtRuleNamespacePrefix Macro

syntax match stylusAtRuleNamespaceUrl "\<url(\@="
      \ contained
      \ nextgroup=stylusAtRuleNamespaceUrlAdress

highlight def link stylusAtRuleNamespaceUrl Function

syntax region stylusAtRuleNamespaceUrlAdress matchgroup=stylusEnclosure start="(" end=")"
      \ contained

highlight def link stylusAtRuleNamespaceUrlAdress String

syntax match stylusAtRuleSupports "@supports\>"
      \ contained
      \ nextgroup=stylusAtRuleSupportsLogic,stylusAtRuleSupportsDeclaration
      \ skipwhite

highlight def link stylusAtRuleSupports Macro

syntax region stylusAtRuleSupportsDeclaration matchgroup=stylusEnclosure start="(" end=")"
      \ contained
      \ contains=stylusProperty,stylusAtRuleSupportsLogic,stylusAtRuleSupportsDeclaration
      \ nextgroup=stylusAtRuleSupportsLogic,stylusAtRuleSupportsDeclaration
      \ oneline
      \ skipwhite

syntax match stylusAtRuleSupportsLogic "\<\(and\|not\|or\)\>"
      \ contained
      \ nextgroup=stylusAtRuleSupportsLogic,stylusAtRuleSupportsDeclaration
      \ skipwhite

highlight def link stylusAtRuleSupportsLogic Operator

syntax match stylusAtRuleDocument "@document\>"
      \ contained
      \ nextgroup=stylusAtRuleDocumentFunc
      \ skipwhite

highlight def link stylusAtRuleDocument Macro

syntax match stylusAtRuleDocumentFunc "\<\(url\|url-prefix\|domain\|regexp\)(\@="
      \ contained
      \ nextgroup=stylusAtRuleNamespaceUrlAdress

highlight def link stylusAtRuleDocumentFunc Function

syntax match stylusAtRulePage "@page\>"
      \ contained
      \ nextgroup=stylusAtRulePagePseudo
      \ skipwhite

highlight def link stylusAtRulePage Macro

syntax match stylusAtRulePagePseudo ":\(left\|right\|first\|blank\)\>"
      \ contained

highlight def link stylusAtRulePagePseudo Macro

syntax match stylusAtRulePageMarginBoxTypes "@\(top-left-corner\|top-left\|top-center\|top-right\|top-right-corner\|bottom-left-corner\|bottom-left\|bottom-center\|bottom-right\|bottom-right-corner\|left-top\|left-middle\|left-bottom\|right-top\|right-middle\|right-bottom\)\>"
      \ contained

highlight def link stylusAtRulePageMarginBoxTypes Macro

syntax match stylusAtRuleViewport "@viewport\>"
      \ contained
      \ skipwhite

highlight def link stylusAtRuleViewport Macro

syntax match stylusAtRuleBlock "@block\>"
      \ contained

highlight def link stylusAtRuleBlock Macro

syntax match stylusAtRuleExtends "@extends\=\>"
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusExplicitVariable
      \ skipwhite

highlight def link stylusAtRuleExtends Macro

syntax match stylusOptional "!optional"
      \ contained
      \ nextgroup=stylusSelectorClass,stylusSelectorId,stylusSelectorCombinator,stylusSelectorElement,stylusSelectorAttribute,stylusSelectorPseudo,stylusSelectorReference,stylusSelectorPartialReference,stylusInterpolationSelectors,stylusExplicitVariable
      \ skipwhite

highlight def link stylusOptional Special
" ===============================================
" COMMENTS
" ===============================================

" Single-line
syntax region stylusComment start="//" end="$"
      \ containedin=ALLBUT,stylusString
      \ keepend
      \ oneline

" Multi-line
syntax region stylusComment start="/\*" end="\*/"
      \ containedin=ALLBUT,stylusString
      \ keepend

highlight def link stylusComment Comment

" ===============================================

let b:current_syntax = "stylus"
