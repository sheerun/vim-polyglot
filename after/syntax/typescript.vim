if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'jsx') != -1
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file
"
" Language: javascript.jsx
" Maintainer: MaxMellon <maxmellon1994@gmail.com>
" Depends:  leafgarland/typescript-vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:jsx_cpo = &cpo
set cpo&vim

syntax case match

if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif

if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

" refine the typescript line comment
syntax region typescriptLineComment start=+//+ end=/$/ contains=@Spell,typescriptCommentTodo,typescriptRef extend keepend

" add a typescriptBlock group for typescript
syntax region typescriptBlock
      \ contained
      \ matchgroup=typescriptBraces
      \ start="{"
      \ end="}"
      \ extend
      \ contains=@typescriptAll,@typescriptExpression,typescriptBlock
      \ fold

" because this is autoloaded, when developing you're going to need to source
" the autoload/jsx_pretty/*.vim file manually, or restart vim
call jsx_pretty#syntax#highlight()

syntax cluster typescriptExpression add=jsxRegion

let b:current_syntax = 'typescript.tsx'

let &cpo = s:jsx_cpo
unlet s:jsx_cpo
if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'styled-components') != -1
  finish
endif

" Vim syntax file
" Language:   styled-components (js/ts)
" Maintainer: Karl Fleischmann <fleischmann.karl@gmail.com>
" URL:        https://github.com/styled-components/vim-styled-components

if exists("b:current_syntax")
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif


" fix for "-" before cssPositioningProp
"   - needs to be above CSS include to not match cssVendor definitions
syn region cssCustomPositioningPrefix contained
      \ start='-' end='\%(\s\{-}:\)\@='
      \ contains=cssPositioningProp

" introduce CSS cluster from built-in (or single third party syntax file)
syn include @CSS syntax/css.vim

" try to include CSS3 definitions from multiple files
" this is only possible on vim version above 7
if v:version >= 700
  try
    syn include @CSS3 syntax/css/*.vim
  catch
  endtry
endif

" TODO: include react-native keywords

" define custom cssAttrRegion
"   - add ",", "`" and "{" to the end characters
"   - add "cssPseudoClassId" to it's containing elements
"     this will incorrectly highlight pseudo elements incorrectly used as
"     attributes but correctly highlight actual attributes
syn region cssCustomAttrRegion contained
      \ start=":" end="\ze\%(;\|)\|{\|}\|`\)"
      \ contains=css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,
      \          cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,
      \          cssError,cssAttrComma,cssNoise,cssPseudoClassId,
      \          jsTemplateExpression,
      \          typescriptInterpolation,typescriptTemplateSubstitution
syn region cssCustomAttrRegion contained
      \ start="transition\s*:" end="\ze\%(;\|)\|{\|}\|`\)"
      \ contains=css.*Prop,css.*Attr,cssColor,cssImportant,cssValue.*,
      \          cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,
      \          cssVendor,cssError,cssAttrComma,cssNoise,cssPseudoClassId,
      \          jsTemplateExpression,
      \          typescriptInterpolation,typescriptTemplateSubstitution

" define custom css elements to not utilize cssDefinition
syn region cssCustomMediaBlock contained fold transparent matchgroup=cssBraces
      \ start="{" end="}"
      \ contains=css.*Attr,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,
      \          cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,
      \          cssUnicodeEscape,cssVendor,cssTagName,cssClassName,
      \          cssIdentifier,cssPseudoClass,cssSelectorOp,cssSelectorOp2,
      \          cssAttributeSelector
syn region cssCustomPageWrap contained transparent matchgroup=cssBraces
      \ start="{" end="}"
      \ contains=cssPageMargin,cssPageProp,cssCustomAttrRegion,css.*Prop,
      \          cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,
      \          cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,
      \          cssHacks
syn match cssCustomPageMargin contained skipwhite skipnl
      \ "@\%(\%(top\|left\|right\|bottom\)-\%(left\|center\|right\|middle\|bottom\)\)\%(-corner\)\="
syn match cssCustomKeyFrameSelector "\%(\d*%\|\<from\>\|\<to\>\)" contained
      \ skipwhite skipnl

" define css include customly to overwrite nextgroup
syn region cssInclude start="@media\>" end="\ze{" skipwhite skipnl
      \ contains=cssMediaProp,cssValueLength,cssMediaKeyword,cssValueInteger,
      \          cssMediaMediaAttr,cssVencor,cssMediaType,cssIncludeKeyword,
      \          cssMediaComma,cssComment
      \ nextgroup=cssCustomMediaBlock

" define all non-contained css definitions
syn cluster CSSTop
      \ contains=cssTagName,cssSelectorOp,cssAttributeSelector,cssClassName,
      \          cssBraces,cssIdentifier,cssIncludeKeyword,cssPage,cssKeyFrame,
      \          cssFontDescriptor,cssAttrComma,cssPseudoClass,cssUnicodeEscape

" custom highlights for styled components
"   - "&" inside top level
"   - cssTagName inside of jsStrings inside of styledPrefix regions
"     TODO: override highlighting of cssTagName with more subtle one
syn match  styledAmpersand contained "&"
syn region styledTagNameString matchgroup=jsString contained
      \ start=+'+ end=+'+ skip=+\\\%(\'\|$\)+
      \ contains=cssTagName
syn region styledTagNameString matchgroup=jsString contained
      \ start=+"+ end=+"+ skip=+\\\%(\"\|$\)+
      \ contains=cssTagName
syn region styledTagNameString matchgroup=jsString contained
      \ start=+`+ end=+`+ skip=+\\\%(\`\|$\)+
      \ contains=cssTagName

" define custom API sections that trigger the styledDefinition highlighting
syn match styledPrefix "\<styled\>\.\k\+"
      \ transparent fold
      \ nextgroup=styledDefinition
      \ contains=cssTagName,javascriptTagRef
      \ containedin=jsFuncBlock
syn match styledPrefix "\.\<attrs\>\s*(\%(\n\|\s\|.\)\{-})"
      \ transparent fold extend
      \ nextgroup=styledDefinition
      \ contains=jsObject,jsParen
      \ containedin=jsFuncBlock
syn match styledPrefix "\.\<extend\>"
      \ transparent fold
      \ nextgroup=styledDefinition
      \ containedin=jsFuncBlock

" define custom API section, that contains typescript annotations
" this is structurally similar to `jsFuncCall`, but allows type
" annotations (delimited by brackets (e.g. "<>")) between `styled` and
" the function call parenthesis
syn match styledTypescriptPrefix
      \ "\<styled\><\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>(\%('\k\+'\|\"\k\+\"\|\k\+\))"
      \ transparent fold
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,
      \          styledTagNameString
syn match styledTypescriptPrefix
      \ "\<styled\>\%((\%('\k\+'\|\"\k\+\"\|\k\+\))\|\.\k\+\)<\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ transparent fold
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,
      \          styledTagNameString
syn match styledTypescriptPrefix "\.\<attrs\>\s*(\%(\n\|\s\|.\)\{-})<\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ transparent fold extend
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,
      \          styledTagNameString
syn match styledTypescriptPrefix "\.\<extend\><\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ transparent fold extend
      \ nextgroup=styledDefinition
      \ contains=cssTagName,
      \          typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,
      \          styledTagNameString

" define emotion css prop
" to bypass problems from top-level defined xml/js definitions, this
" plugin re-defines keywords/noise for highlighting inside of the custom
" xmlAttrib definition
syn keyword styledXmlRegionKeyword css contained
syn match   styledXmlRegionNoise "\%(=\|{\|}\)" contained
" only include styledDefinitions inside of xmlAttribs, that are wrapped
" in `css={}` regions, `keepend` is necessary to correctly break on the
" higher-level xmlAttrib region end
syn region styledXmlRegion
      \ start="\<css\>={" end="}"
      \ keepend fold
      \ containedin=xmlAttrib
      \ contains=styledXmlRegionKeyword,styledXmlRegionNoise,styledDefinition

" define nested region for indenting
syn region styledNestedRegion contained transparent
      \ matchgroup=cssBraces
      \ start="{" end="}"

" re-define cssError to be highlighted correctly in styledNestedRegion
syn match cssError contained "{@<>"

" extend javascript matches to trigger styledDefinition highlighting
syn match jsTaggedTemplate extend
      \ "\<css\>\|\<keyframes\>\|\<injectGlobal\>\|\<fontFace\>\|\<createGlobalStyle\>"
      \ nextgroup=styledDefinition
syn match jsFuncCall "\<styled\>\s*(.\+)" transparent
      \ nextgroup=styledDefinition
syn match jsFuncCall "\<styled\>\s*(\%('\k\+'\|\"\k\+\"\|`\k\+`\))"
      \ contains=styledTagNameString
      \ nextgroup=styledDefinition
syn match jsFuncCall "\<styled\>\s*(\%('\k\+'\|\"\k\+\"\|`\k\+`\))<\%(\[\|\]\|{\|}\||\|&\|:\|;\|,\|?\|'\|\"\|\k\|\s\|\n\)\+>"
      \ contains=typescriptBraces,typescriptOpSymbols,typescriptEndColons,
      \          typescriptParens,typescriptStringS,@typescriptType,
      \          typescriptType,
      \          styledTagNameString
      \ nextgroup=styledDefinition
syn match jsFuncCall "\.\<withComponent\>\s*(\%('\k\+'\|\"\k\+\"\|`\k\+`\))"
      \ contains=styledTagNameString
syn match jsFuncCall "\<dc\>\s*(\%('\k\+'\|\"\k\+\"\|`\k\+`\))\%((\)\@="
      \ contains=styledTagNameString
      \ nextgroup=styledDefinitionArgument

" inject css highlighting into custom jsTemplateString region
"   - use `extend` to not end all nested jsTemplateExpression on the first
"     closing one
syn region styledDefinition contained transparent fold extend
      \ start="`" end="`" skip="\\\%(`\|$\)"
      \ contains=@CSSTop,
      \          css.*Prop,cssValue.*,cssColor,cssUrl,cssImportant,cssError,
      \          cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,
      \          cssHacks,
      \          cssCustom.*,
      \          jsComment,jsTemplateExpression,
      \          typescriptInterpolation,typescriptTemplateSubstitution,
      \          styledAmpersand,styledNestedRegion
syn region styledDefinitionArgument contained transparent start=+(+ end=+)+
      \ contains=styledDefinition

syn cluster typescriptValue add=styledPrefix,jsFuncCall,styledTypescriptPrefix

""" yajs specific extensions
" define template tag keywords, that trigger styledDefinitions again to be
" contained in and also do contain the `javascriptTagRef` region
syn match javascriptTagRefStyledPrefix transparent fold
      \ "\<css\>\|\<keyframes\>\|\<injectGlobal\>\|\<fontFace\>\|\<createGlobalStyle\>"
      \ containedin=javascriptTagRef
      \ contains=javascriptTagRef
      \ nextgroup=styledDefinition
" extend the yajs clusters to include the previously and extraneously defined
" styled-related matches
syn cluster javascriptExpression
      \ add=styledPrefix,jsFuncCall,javascriptTagRefStyledPrefix
syn cluster javascriptAfterIdentifier add=styledPrefix,jsFuncCall

""" yats specific extensions
" extend typescriptIdentifierName to allow styledDefinitions in their
" tagged templates
syn match typescriptIdentifierName extend
      \ "\<css\>\|\<keyframes\>\|\<injectGlobal\>\|\<fontFace\>\|\<createGlobalStyle\>"
      \ nextgroup=styledDefinition

" color the custom highlight elements
hi def link cssCustomKeyFrameSelector  Constant
hi def link cssCustomPositioningPrefix StorageClass
hi def link styledAmpersand            Special

hi def link styledXmlRegionKeyword Type
hi def link styledXmlRegionNoise   Noise
hi def link styledXmlRegion        String


if exists("s:current_syntax")
  let b:current_syntax=s:current_syntax
endif
