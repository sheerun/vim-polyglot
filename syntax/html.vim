" Vim syntax file
" Language:	HTML (version 5)
" Maintainer:	Rodrigo Machado <rcmachado@gmail.com>
" URL:		http://rm.blog.br/vim/syntax/html.vim
" Last Change:  2009 Aug 19
" License:      Public domain
"               (but let me know if you like :) )
"
" Note: This file just adds the new tags from HTML 5
"       and don't replace default html.vim syntax file
"
" Modified:     othree <othree@gmail.com>
" Changes:      update to Draft 13 January 2011
"               add complete new attributes
"               add microdata Attributes
"               add bdi element
" Modified:     htdebeer <H.T.de.Beer@gmail.com>
" Changes:      add common SVG elements and attributes for inline SVG

" HTML 5 tags
syn keyword htmlTagName contained article aside audio canvas command
syn keyword htmlTagName contained datalist details dialog embed figcaption figure footer
syn keyword htmlTagName contained header hgroup keygen main mark meter menu nav output
syn keyword htmlTagName contained progress ruby rt rp rb rtc section source summary time track video data
syn keyword htmlTagName contained template content shadow
syn keyword htmlTagName contained wbr bdi
syn keyword htmlTagName contained picture

" SVG tags
" http://www.w3.org/TR/SVG/
" as found in http://www.w3.org/TR/SVG/eltindex.html
syn keyword htmlTagName contained svg 
syn keyword htmlTagName contained altGlyph altGlyphDef altGlyphItem 
syn keyword htmlTagName contained animate animateColor animateMotion animateTransform 
syn keyword htmlTagName contained circle ellipse rect line polyline polygon image path
syn keyword htmlTagName contained clipPath color-profile cursor 
syn keyword htmlTagName contained defs desc g symbol view use switch foreignObject
syn keyword htmlTagName contained filter feBlend feColorMatrix feComponentTransfer feComposite feConvolveMatrix feDiffuseLighting feDisplacementMap feDistantLight feFlood feFuncA feFuncB feFuncG feFuncR feGaussianBlur feImage feMerge feMergeNode feMorphology feOffset fePointLight feSpecularLighting feSpotLight feTile feTurbulence 
syn keyword htmlTagName contained font font-face font-face-format font-face-name font-face-src font-face-uri 
syn keyword htmlTagName contained glyph glyphRef hkern 
syn keyword htmlTagName contained linearGradient marker mask pattern radialGradient set stop
syn keyword htmlTagName contained missing-glyph mpath 
syn keyword htmlTagName contained text textPath tref tspan vkern

" Custom Element
syn match htmlTagName contained "\<[a-z_]\([a-z0-9_.]\+\)\?\(\-[a-z0-9_.]\+\)\+\>"

" HTML 5 arguments
" Core Attributes
syn keyword htmlArg contained accesskey class contenteditable contextmenu dir 
syn keyword htmlArg contained draggable hidden id is lang spellcheck style tabindex title translate
" Event-handler Attributes
syn keyword htmlArg contained onabort onblur oncanplay oncanplaythrough onchange
syn keyword htmlArg contained onclick oncontextmenu ondblclick ondrag ondragend ondragenter ondragleave ondragover 
syn keyword htmlArg contained ondragstart ondrop ondurationchange onemptied onended onerror onfocus onformchange 
syn keyword htmlArg contained onforminput oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata 
syn keyword htmlArg contained onloadedmetadata onloadstart onmousedown onmousemove onmouseout onmouseover onmouseup
syn keyword htmlArg contained onmousewheel onpause onplay onplaying onprogress onratechange onreadystatechange 
syn keyword htmlArg contained onscroll onseeked onseeking onselect onshow onstalled onsubmit onsuspend ontimeupdate 
syn keyword htmlArg contained onvolumechange onwaiting
" XML Attributes
syn keyword htmlArg contained xml:lang xml:space xml:base xmlns
" new features
" <body>
syn keyword htmlArg contained onafterprint onbeforeprint onbeforeunload onblur onerror onfocus onhashchange onload 
syn keyword htmlArg contained onmessage onoffline ononline onpopstate onredo onresize onstorage onundo onunload
" <video>, <audio>, <source>, <track>
syn keyword htmlArg contained autoplay preload controls loop poster media kind charset srclang track
" <form>, <input>, <button>
syn keyword htmlArg contained form autocomplete autofocus list min max step
syn keyword htmlArg contained formaction autofocus formenctype formmethod formtarget formnovalidate
syn keyword htmlArg contained required placeholder pattern
" <command>, <details>, <time>
syn keyword htmlArg contained label icon open datetime pubdate
" <script>
syn keyword htmlArg contained async
" <content>
syn keyword htmlArg contained select
" <iframe>
syn keyword htmlArg contained seamless srcdoc sandbox
" <picture>
syn keyword htmlArg contained srcset sizes

" Custom Data Attributes
" http://dev.w3.org/html5/spec/elements.html#embedding-custom-non-visible-data
syn match   htmlArg "\<\(data\-\([a-z_][a-z0-9_.\-]*\)\+\)\=\>" contained

" Microdata
" http://dev.w3.org/html5/md/
syn keyword htmlArg contained itemid itemscope itemtype itemprop itemref

" SVG
" http://www.w3.org/TR/SVG/
" Some common attributes from http://www.w3.org/TR/SVG/attindex.html
syn keyword htmlArg contained accent-height accumulate additive alphabetic amplitude arabic-form ascent attributeName attributeType azimuth 
syn keyword htmlArg contained baseFrequency baseProfile bbox begin bias by 
syn keyword htmlArg contained calcMode cap-height class clipPathUnits contentScriptType contentStyleType cx cy 
syn keyword htmlArg contained d descent diffuseConstant divisor dur dx dy 
syn keyword htmlArg contained edgeMode elevation end exponent externalResourcesRequired 
syn keyword htmlArg contained fill filterRes filterUnits font-family font-size font-stretch font-style font-variant font-weight format format from fx fy 
syn keyword htmlArg contained g1 g2 glyph-name glyphRef gradientTransform gradientUnits 
syn keyword htmlArg contained hanging height horiz-adv-x horiz-origin-y 
syn keyword htmlArg contained id ideographic in in2 intercept 
syn keyword htmlArg contained k k1 k2 k3 k4 kernelMatrix kernelUnitLength keyPoints keySplines keyTimes 
syn keyword htmlArg contained lang lengthAdjust limitingConeAngle local 
syn keyword htmlArg contained markerHeight markerUnits markerWidth maskContentUnits maskUnits mathematical max media method min mode name 
syn keyword htmlArg contained numOctaves 
syn keyword htmlArg contained offset offset onabort onactivate onbegin onclick onend onerror onfocusin onfocusout onload onload onmousedown onmousemove onmouseout onmouseover onmouseup onrepeat onresize onscroll onunload onzoom operator order orient orientation origin overline-position overline-thickness 
syn keyword htmlArg contained panose-1 path pathLength patternContentUnits patternTransform patternUnits points pointsAtX pointsAtY pointsAtZ preserveAlpha preserveAspectRatio primitiveUnits 
syn keyword htmlArg contained r radius refX refY rendering-intent repeatCount repeatDur requiredExtensions requiredFeatures restart result rotate rx ry 
syn keyword htmlArg contained scale seed slope spacing specularConstant specularExponent spreadMethod startOffset stdDeviation stemh stemv stitchTiles strikethrough-position strikethrough-thickness string surfaceScale systemLanguage 
syn keyword htmlArg contained tableValues target targetX targetY textLength title to transform type u
syn keyword htmlArg contained 1 u2 underline-position underline-thickness unicode unicode-range units-per-em 
syn keyword htmlArg contained v-alphabetic v-hanging v-ideographic v-mathematical values version vert-adv-y vert-origin-x vert-origin-y viewBox viewTarget 
syn keyword htmlArg contained width widths 
syn keyword htmlArg contained x x-height x1 x2 xChannelSelector xlink:actuate xlink:actuate xlink:arcrole xlink:href xlink:role xlink:show xlink:show xlink:title xlink:type xml:base xml:lang xml:space 
syn keyword htmlArg contained y y1 y2 yChannelSelector 
syn keyword htmlArg contained z zoomAndPan 
syn keyword htmlArg contained alignment-baseline baseline-shift clip-path clip-rule clip color-interpolation-filters color-interpolation color-profile color-rendering color cursor direction display dominant-baseline enable-background fill-opacity fill-rule fill filter flood-color flood-opacity font-family font-size-adjust font-size font-stretch font-style font-variant font-weight glyph-orientation-horizontal glyph-orientation-vertical image-rendering kerning letter-spacing lighting-color marker-end marker-mid marker-start mask opacity overflow pointer-events shape-rendering stop-color stop-opacity stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width stroke text-anchor text-decoration text-rendering unicode-bidi visibility word-spacing writing-mode
