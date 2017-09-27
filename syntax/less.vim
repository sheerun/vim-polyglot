if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim syntax file
" Language:	less
" Maintainer:	Alessandro Vioni <jenoma@gmail.com>
" URL: https://github.com/genoma/vim-less
" Last Change:	2014 November 24

if exists("b:current_syntax")
  finish
endif

runtime! syntax/css.vim
runtime! after/syntax/css.vim

syn case ignore

syn cluster lessCssProperties contains=cssFontProp,cssFontDescriptorProp,cssColorProp,cssTextProp,cssBoxProp,cssGeneratedContentProp,cssPagingProp,cssUIProp,cssRenderProp,cssAuralProp,cssTableProp
syn cluster lessCssAttributes contains=css.*Attr,lessEndOfLineComment,lessComment,cssValue.*,cssColor,cssURL,lessDefault,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssRenderProp

syn region lessDefinition matchgroup=cssBraces start="{" end="}" contains=TOP

syn match lessProperty "\%([{};]\s*\|^\)\@<=\%([[:alnum:]-]\|#{[^{}]*}\)\+\s*:" contains=css.*Prop skipwhite nextgroup=lessCssAttribute contained containedin=lessDefinition
syn match lessProperty "^\s*\zs\s\%(\%([[:alnum:]-]\|#{[^{}]*}\)\+\s*:\|:[[:alnum:]-]\+\)"hs=s+1 contains=css.*Prop skipwhite nextgroup=lessCssAttribute
syn match lessProperty "^\s*\zs\s\%(:\=[[:alnum:]-]\+\s*=\)"hs=s+1 contains=css.*Prop skipwhite nextgroup=lessCssAttribute
syn match lessCssAttribute +\%("\%([^"]\|\\"\)*"\|'\%([^']\|\\'\)*'\|#{[^{}]*}\|[^{};]\)*+ contained contains=@lessCssAttributes,lessVariable,lessFunction,lessInterpolation
syn match lessDefault "!default\>" contained

" less variables and media queries
syn match lessVariable "@[[:alnum:]_-]\+" nextgroup=lessCssAttribute skipwhite
syn match lessMedia "@media" nextgroup=lessCssAttribute skipwhite

" Less functions
syn match lessFunction "\<\%(escape\|e\|unit\)\>(\@=" contained
syn match lessFunction "\<\%(ceil\|floor\|percentage\|round\|sqrt\|abs\|sin\|asin\|cos\|acos\|tan\|atan\|pi\|pow\|min\|max\)\>(\@=" contained
syn match lessFunction "\<\%(rgb\|rgba\|argb\|argb\|hsl\|hsla\|hsv\|hsva\)\>(\@=" contained
syn match lessFunction "\<\%(hue\|saturation\|lightness\|red\|green\|blue\|alpha\|luma\)\>(\@=" contained
syn match lessFunction "\<\%(saturate\|desaturate\|lighten\|darken\|fadein\|fadeout\|fade\|spin\|mix\|greyscale\|contrast\)\>(\@=" contained
syn match lessFunction "\<\%(multiply\|screen\|overlay\|softlight\|hardlight\|difference\|exclusion\|average\|negation\)\>(\@=" contained

" Less id class visualization
syn match lessIdChar     "#[[:alnum:]_-]\@=" nextgroup=lessId,lessClassIdCall
syn match lessId         "[[:alnum:]_-]\+" contained
syn match lessClassIdCall  "[[:alnum:]_-]\+()" contained

syn match lessClassChar  "\.[[:alnum:]_-]\@=" nextgroup=lessClass,lessClassCall
syn match lessClass      "[[:alnum:]_-]\+" contained
syn match lessClassCall  "[[:alnum:]_-]\+()" contained

syn match lessAmpersand  "&" contains=lessIdChar,lessClassChar

syn region lessInclude start="@import" end=";\|$" contains=lessComment,cssURL,cssUnicodeEscape,cssMediaType,cssStringQ,cssStringQQ

syn keyword lessTodo        FIXME NOTE TODO OPTIMIZE XXX contained
syn region  lessComment     start="^\z(\s*\)//"  end="^\%(\z1 \)\@!" contains=lessTodo,@Spell
syn region  lessCssComment  start="^\z(\s*\)/\*" end="^\%(\z1 \)\@!" contains=lessTodo,@Spell
syn match   lessEndOfLineComment "//.*" contains=lessComment,lessTodo,@Spell

hi def link lessEndOfLineComment        lessComment
hi def link lessCssComment              lessComment
hi def link lessComment                 Comment
hi def link lessDefault                 cssImportant
hi def link lessVariable                Identifier
hi def link lessFunction                PreProc
hi def link lessTodo                    Todo
hi def link lessInclude                 Include
hi def link lessIdChar                  Special
hi def link lessClassChar               Special
hi def link lessAmpersand               Character
hi def link lessId                      Identifier
hi def link lessClass                   Type
hi def link lessCssAttribute            PreProc
hi def link lessClassCall               Type
hi def link lessClassIdCall             Type
hi def link lessTagName                 cssTagName
hi def link lessDeprecated              cssDeprecated
hi def link lessMedia                   cssMedia

let b:current_syntax = "less"

" vim:set sw=2:

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'less') == -1
  
if exists("b:current_syntax")
  finish
endif

runtime! syntax/css.vim
runtime! after/syntax/css.vim
" load files from vim-css3-syntax plugin (https://github.com/hail2u/vim-css3-syntax)
runtime! after/syntax/css/*.vim

syn case ignore

syn region lessDefinition transparent matchgroup=cssBraces start='{' end='}' contains=css.*Attr,css.*Prop,cssComment,cssValue.*,cssColor,cssTagName,cssPseudoClass,cssUrl,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,lessDefinition,lessComment,lessClassChar,lessVariable,lessMixinChar,lessAmpersandChar,lessFunction,lessNestedSelector,@cssColors fold

syn match lessVariable "@[[:alnum:]_-]\+" contained
syn match lessVariable "@[[:alnum:]_-]\+" nextgroup=lessVariableAssignment skipwhite
syn match lessVariableAssignment ":" contained nextgroup=lessVariableValue skipwhite
syn match lessVariableValue ".*;"me=e-1 contained contains=lessVariable,lessOperator,lessDefault,cssValue.*,@cssColors "me=e-1 means that the last char of the pattern is not highlighted

syn match lessOperator "+" contained
syn match lessOperator "-" contained
syn match lessOperator "/" contained
syn match lessOperator "*" contained

syn match lessNestedSelector "[^/]* {"me=e-1 contained contains=cssTagName,cssAttributeSelector,lessAmpersandChar,lessVariable,lessMixinChar,lessFunction,lessNestedProperty
syn match lessNestedProperty "[[:alnum:]]\+:"me=e-1 contained

syn match lessDefault "!default" contained

syn match lessMixinChar "\.[[:alnum:]_-]\@=" contained nextgroup=lessClass
syn match lessAmpersandChar "&" contained nextgroup=lessClass,cssPseudoClass
syn match lessClass "[[:alnum:]_-]\+" contained

" functions {{{

" string functions
syn keyword lessFunction escape e % containedin=cssDefinition contained
" misc functions
syn keyword lessFunction unit containedin=cssDefinition contained
" math functions
syn keyword lessFunction ceil floor percentage round containedin=cssDefinition contained
" color definition
syn keyword lessFunction rgb rgba argb hsl hsla hsv hsva containedin=cssDefinition contained
" color channel information
syn keyword lessFunction hue saturation lightness red green blue alpha luma containedin=cssDefinition contained
" color operations
syn keyword lessFunction saturate desaturate lighten darken fadein fadeout fade spin mix greyscale contrast containedin=cssDefinition contained
" color blending
syn keyword lessFunction multiply screen overlay softlight hardlight difference exclusion average negation containedin=cssDefinition contained

" }}}

syn match lessComment "//.*$" contains=@Spell

hi def link lessVariable Special
hi def link lessVariableValue Constant
hi def link lessDefault Special
hi def link lessComment Comment
hi def link lessFunction Function
hi def link lessMixinChar Special
hi def link lessAmpersandChar Special
hi def link lessNestedProperty Type
hi def link lessClass PreProc

let b:current_syntax = "less"

endif
