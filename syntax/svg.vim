if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'svg') == -1

" Vim syntax file
" Language:	SVG
" Filenames:	*.svg
" Maintainer:	Michal Gorny <michal-gorny@wp.pl>
" Last_change:	2006-03-23

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'svg'
endif

if main_syntax == 'svg'
  runtime! syntax/xml.vim
  syn cluster xmlTagHook add=svgElement
  syn cluster xmlAttribHook add=svgAttr
  syn match xmlDecl /\<\(<?\)\@<=xml\(-stylesheet\)\?\>/ containedin=xmlProcessing contained
  syn keyword xmlDeclAttr version encoding standalone containedin=xmlProcessing contained
  syn keyword xmlDeclAttr alternate charset media href title type containedin=xmlProcessing contained
else
  syn cluster xhtmlTagHook add=svgElement
  syn cluster xhtmlAttribHook add=svgAttr
endif

syn case match

" SVG elements
syn match   svgElement contained /\<svg\>[^:]/me=e-1
syn keyword svgElement contained altGlyph altGlyphDef altGlyphItem animate
syn keyword svgElement contained animateColor animateMotion animateTransform
syn keyword svgElement contained circle clipPath cursor defs desc ellipse
syn keyword svgElement contained feBlend feColorMatrix feComponentTransfer
syn keyword svgElement contained feComposite feConvolveMatrix feDiffuseLighting
syn keyword svgElement contained feDisplacementMap feDistantLight feFlood
syn keyword svgElement contained feFuncA feFuncB feFuncG feFuncR feGaussianBlur
syn keyword svgElement contained feImage feMerge feMergeNode feMorphology
syn keyword svgElement contained feOffset fePointLight feSpecularLighting
syn keyword svgElement contained feSpotLight feTile feTurbulence filter
syn keyword svgElement contained foreignObject glyph glyphRef hkern image line
syn keyword svgElement contained linearGradient marker mask metadata mpath path
syn keyword svgElement contained pattern polygon polyline radialGradient rect
syn keyword svgElement contained script set stop style switch symbol text
syn keyword svgElement contained textPath title tref tspan use view vkern
syn match   svgElement contained /\<\(font\|font-face\)\>[^-]/me=e-1
syn match   svgElement contained /\<font-face-\(format\|name\|src\|uri\)\>/
syn match   svgElement contained /\<\(color-profile\|definition-src\)\>/
syn match   svgElement contained /\<missing-glyph\>/
syn match   svgElement contained /\<\(a\|g\)\>[^:]/me=e-1

" SVG 1.0 attributes
syn keyword svgAttr contained accumulate additive alphabetic amplitude ascent attributeName attributeType azimuth baseFrequency bbox begin bias by
syn keyword svgAttr contained calcMode class clipPathUnits contentScriptType contentStyleType cursor cx cy d descent diffuseConstant direction display
syn keyword svgAttr contained divisor dur dx dy edgeMode elevation end exponent externalResourcesRequired filter filterRes filterUnits format from fx fy
syn keyword svgAttr contained g1 g2 glyphRef gradientTransform gradientUnits hanging height id ideographic in in2 intercept k k1 k2 k3 k4 kernelMatrix
syn keyword svgAttr contained kernelUnitLength kerning keyPoints keySplines keyTimes lang lengthAdjust limitingConeAngle local markerHeight markerUnits
syn keyword svgAttr contained markerWidth mask maskContentUnits maskUnits mathematical max media method min mode name numOctaves offset opacity operator
syn keyword svgAttr contained order orient orientation origin overflow path pathLength patternContentUnits patternTransform patternUnits points pointsAtX
syn keyword svgAttr contained pointsAtY pointsAtZ preserveAlpha preserveAspectRatio primitiveUnits r radius refX refY repeatCount repeatDur
syn keyword svgAttr contained requiredExtensions requiredFeatures restart result rotate rx ry scale seed slope spacing specularConstant specularExponent
syn keyword svgAttr contained spreadMethod startOffset stdDeviation stemh stemv stitchTiles string style surfaceScale systemLanguage tableValues target
syn keyword svgAttr contained targetX targetY textLength title to transform type u1 u2 values version viewBox viewTarget visibility width widths x x1 x2
syn keyword svgAttr contained xChannelSelector y y1 y2 yChannelSelector z zoomAndPan
syn match svgAttr contained /\<xmlns\>[^:]/me=e-1
syn match svgAttr contained /\<\(clip\|color\|fill\)\>[^-]/me=e-1
syn match svgAttr contained /\<\(stroke\|unicode\)\>[^-]/me=e-1
syn match svgAttr contained /\<\(color-interpolation\|font-size\)\>[^-]/me=e-1
syn match svgAttr contained /\<\(\accent-height\|alignment-baseline\|arabic-form\|baseline-shift\|cap-height\|clip-\(path\|rule\)\|dominant-baseline\)\>/
syn match svgAttr contained /\<\(color-\(interpolation-filters\|profile\|rendering\)\|enable-background\|fill-\(opacity\|rule\)\)\>/
syn match svgAttr contained /\<\(flood-\(color\|opacity\)\|font-\(family\|size-adjust\|stretch\|style\|variant\|weight\)\|image-rendering\)\>/
syn match svgAttr contained /\<\(glyph-\(name\|orientation-\(horizontal\|vertical\)\)\|horiz-\(adv-x\|origin-\(x\|y\)\)\)\>/
syn match svgAttr contained /\<\(letter-spacing\|lighting-color\|marker-\(end\|mid\|start\)\|overline-\(position\|thickness\)\|panose-1\)\>/
syn match svgAttr contained /\<\(pointer-events\|rendering-intent\|shape-rendering\|stop-\(color\|opacity\)\|strikethrough-\(position\|thickness\)\)\>/
syn match svgAttr contained /\<\(text-\(anchor\|decoration\|rendering\)\|stroke-\(dasharray\|dashoffset\|linecap\|linejoin\|miterlimit\|opacity\|width\)\)\>/
syn match svgAttr contained /\<\(underline-\(position\|thickness\)\|unicode-\(bidi\|range\)\|units-per-em\|writing-mode\|x-height\)\>/
syn match svgAttr contained /\(vert-\(adv-y\|origin-\(x\|y\)\)\|v-\(alphabetic\|hanging\|ideographic\|mathematical\)\|word-spacing\)\>/
syn match svgAttr contained /\<\(xlink:\)\@<=\(actuate\|arcrole\|href\)\>/
syn match svgAttr contained /\<\(xlink:\)\@<=\(role\|show\|title\|type\)\>/
syn match svgAttr contained /\<\(xml:\)\@<=\(base\|lang\|space\)\>/
syn match svgAttr contained /\<\(xmlns:\)\@<=xlink\>/
" Events attributes
if exists("svg_no_events_rendering")
  syn match svgEventAttr contained /\<on\(abort\|activate\|begin\|click\|end\|error\|focus\(in\|out\)\|\(un\)\?load\|mouse\(down\|move\|out\|over\|up\)\|repeat\|resize\|scroll\|zoom\)\>/
  if main_syntax == 'svg'
    syn cluster xmlAttribHook add=svgEventAttr
  else
    syn cluster xhtmlAttribHook add=svgEventAttr
  endif
endif

" Attribute new in SVG 1.1
syn keyword svgAttr contained baseProfile

" Embedded ECMAScript (JavaScript)
if main_syntax == 'svg'
  syn include @svgJavaScript syntax/javascript.vim
  unlet b:current_syntax
  syn region javaScript start=+<script[^>]*[^/]>+ keepend end=+</script>+me=s-1 contains=@svgJavaScript,svgScriptTag
  syn region svgScriptTag contained start=+<script+ end=+>+ contains=xmlTagName,xmlString,xmlAttrib
endif
 
" Events attributes rendering
if !exists("svg_no_events_rendering")
  syn region svgEvent contained start=+\<on\(abort\|activate\|begin\|click\|end\|error\|focus\(in\|out\)\|\(un\)\?load\|mouse\(down\|move\|out\|over\|up\)\|repeat\|resize\|scroll\|zoom\)\s*=\s*'+ keepend end=+'+ contains=svgEventSQ
  syn region svgEvent contained start=+\<on\(abort\|activate\|begin\|click\|end\|error\|focus\(in\|out\)\|\(un\)\?load\|mouse\(down\|move\|out\|over\|up\)\|repeat\|resize\|scroll\|zoom\)\s*=\s*"+ keepend end=+"+ contains=svgEventDQ
  if main_syntax == 'svg'
    syn cluster xmlAttribHook add=svgEvent
  else
    syn cluster xhtmlAttribHook add=svgEvent
  endif
  syn region svgEventSQ contained start=+'+ms=s+1 end=+'+me=s-1 contains=@svgJavaScript,@xhtmlJavaScript
  syn region svgEventDQ contained start=+"+ms=s+1 end=+"+me=s-1 contains=@svgJavaScript,@xhtmlJavaScript
  hi def link svgEventSQ svgEvent
  hi def link svgEventDQ svgEvent
endif  

" Rendering
if !exists("svg_no_rendering")
  syn region svgTitle start="<title\>" end="</title>"me=e-8 contains=xmlTag,xmlEndTag,xmlEntity,xmlComment
  syn region svgDesc start="<desc\>" end="</desc>"me=e-8 contains=xmlTag,xmlEndTag,xmlEntity,xmlComment
endif

" Highlighting
hi link     xmlAttrib		Function
hi def link xmlDecl		Statement
hi def link xmlDeclAttr 	Type
hi link     xmlEntity		Special
hi link     xmlEntityPunct	Special
hi def link svgElement		Statement
hi def link svgAttr		Type
hi def link javaScript		Special
hi def link svgEvent		javaScript
hi def link svgEventAttr	Type
if !exists("svg_no_rendering")
  hi def link svgTitle		Title
  hi def link svgDesc		Title
endif

let b:current_syntax = "svg"

if main_syntax == 'svg'
  unlet main_syntax
endif

" vim: ts=8

endif
