if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'html5') == -1

" Vim syntax file
" Language:     HTML (version 5.1)
"               SVG (SVG 1.1 Second Edition)
"               MathML (MathML 3.0 Second Edition)
" Last Change:  2017 Mar 07
" License:      Public domain
"               (but let me know if you like :) )
"
" Note: This file just add new tags from HTML 5
"       and don't replace default html.vim syntax file
"
" Maintainer:   Kao, Wei-Ko(othree) ( othree AT gmail DOT com )
" Changes:      update to Draft 2016 Jan 13
"               add microdata Attributes
" Maintainer:   Rodrigo Machado <rcmachado@gmail.com>
" URL:          http://rm.blog.br/vim/syntax/html.vim
" Modified:     htdebeer <H.T.de.Beer@gmail.com>
" Changes:      add common SVG elements and attributes for inline SVG

" Patch 7.4.1142
if has("patch-7.4-1142")
  if has("win32")
    syn iskeyword @,48-57,_,128-167,224-235,-
  else
    syn iskeyword @,48-57,_,192-255,-
  endif
endif

" HTML 5 tags
syn keyword htmlTagName contained article aside audio canvas command
syn keyword htmlTagName contained datalist details dialog embed figcaption figure footer
syn keyword htmlTagName contained header hgroup keygen main mark meter menu menuitem nav output
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
syn keyword htmlTagName contained metadata title

" MathML tags
" https://www.w3.org/TR/MathML3/appendixi.html#index.elem
syn keyword htmlTagName contained abs and annotation annotation-xml apply approx arccos arccosh arccot arccoth
syn keyword htmlTagName contained arccsc arccsch arcsec arcsech arcsin arcsinh arctan arctanh arg bind
syn keyword htmlTagName contained bvar card cartesianproduct cbytes ceiling cerror ci cn codomain complexes
syn keyword htmlTagName contained compose condition conjugate cos cosh cot coth cs csc csch
syn keyword htmlTagName contained csymbol curl declare degree determinant diff divergence divide domain domainofapplication
syn keyword htmlTagName contained emptyset eq equivalent eulergamma exists exp exponentiale factorial factorof false
syn keyword htmlTagName contained floor fn forall gcd geq grad gt ident image imaginary
syn keyword htmlTagName contained imaginaryi implies in infinity int integers intersect interval inverse lambda
syn keyword htmlTagName contained laplacian lcm leq limit list ln log logbase lowlimit lt
syn keyword htmlTagName contained maction maligngroup malignmark math matrix matrixrow max mean median menclose
syn keyword htmlTagName contained merror mfenced mfrac mglyph mi mi" min minus mlabeledtr mlongdiv
syn keyword htmlTagName contained mmultiscripts mn mo mode moment momentabout mover mpadded mphantom mprescripts
syn keyword htmlTagName contained mroot mrow ms mscarries mscarry msgroup msline mspace msqrt msrow
syn keyword htmlTagName contained mstack mstyle msub msubsup msup mtable mtd mtext mtr munder
syn keyword htmlTagName contained munderover naturalnumbers neq none not notanumber notin notprsubset notsubset or
syn keyword htmlTagName contained otherwise outerproduct partialdiff pi piece piecewise plus power primes product
syn keyword htmlTagName contained prsubset quotient rationals real reals reln rem root scalarproduct sdev
syn keyword htmlTagName contained sec sech selector semantics sep set setdiff share sin sinh
syn keyword htmlTagName contained span subset sum tan tanh tendsto times transpose true union
syn keyword htmlTagName contained uplimit variance vector vectorproduct xor

" Custom Element
syn match htmlTagName contained "\<[a-z][-.0-9_a-z]*-[-.0-9_a-z]*\>"
syn match htmlTagName contained "[.0-9_a-z]\@<=-[-.0-9_a-z]*\>"

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
syn keyword htmlArg contained autoplay preload controls loop poster media kind charset srclang track playsinline
" <form>, <input>, <button>
syn keyword htmlArg contained form autocomplete autofocus list min max step
syn keyword htmlArg contained formaction autofocus formenctype formmethod formtarget formnovalidate
syn keyword htmlArg contained required placeholder pattern
" <command>, <details>, <time>
syn keyword htmlArg contained label icon open datetime-local pubdate
" <script>
syn keyword htmlArg contained async
" <content>
syn keyword htmlArg contained select
" <iframe>
syn keyword htmlArg contained seamless srcdoc sandbox allowfullscreen allowusermedia allowpaymentrequest allowpresentation
" <picture>
syn keyword htmlArg contained srcset sizes
" <a>
syn keyword htmlArg contained download media
" <script>, <style>
syn keyword htmlArg contained nonce
" <area>, <a>, <img>, <iframe>, <link>
syn keyword htmlArg contained referrerpolicy
" https://w3c.github.io/webappsec-subresource-integrity/#the-integrity-attribute
syn keyword htmlArg contained integrity crossorigin
" <link>
syn keyword htmlArg contained prefetch 
" syn keyword htmlArg contained preload
" <img>
syn keyword htmlArg contained decoding
" https://w3c.github.io/selection-api/#extensions-to-globaleventhandlers
syn keyword htmlArg contained onselectstart onselectionchange

" Custom Data Attributes
" http://w3c.github.io/html/single-page.html#embedding-custom-non-visible-data-with-the-data-attributes
syn match   htmlArg "\<data[-.0-9_a-z]*-[-.0-9_a-z]*\>" contained

" Vendor Extension Attributes
" http://w3c.github.io/html/single-page.html#conformance-requirements-extensibility
syn match   htmlArg "\<x[-.0-9_a-z]*-[-.0-9_a-z]*\>" contained

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
syn keyword htmlArg contained hanging height horiz-adv-x horiz-origin-x horiz-origin-y 
syn keyword htmlArg contained id ideographic in in2 intercept 
syn keyword htmlArg contained k k1 k2 k3 k4 kernelMatrix kernelUnitLength keyPoints keySplines keyTimes 
syn keyword htmlArg contained lang lengthAdjust limitingConeAngle local 
syn keyword htmlArg contained markerHeight markerUnits markerWidth maskContentUnits maskUnits mathematical max media method min mode name 
syn keyword htmlArg contained numOctaves 
syn keyword htmlArg contained offset onabort onactivate onbegin onclick onend onerror onfocusin onfocusout onload onmousedown onmousemove onmouseout onmouseover onmouseup onrepeat onresize onscroll onunload onzoom operator order orient orientation origin overline-position overline-thickness 
syn keyword htmlArg contained panose-1 path pathLength patternContentUnits patternTransform patternUnits points pointsAtX pointsAtY pointsAtZ preserveAlpha preserveAspectRatio primitiveUnits 
syn keyword htmlArg contained r radius refX refY rendering-intent repeatCount repeatDur requiredExtensions requiredFeatures restart result rotate rx ry 
syn keyword htmlArg contained scale seed slope spacing specularConstant specularExponent spreadMethod startOffset stdDeviation stemh stemv stitchTiles strikethrough-position strikethrough-thickness string surfaceScale systemLanguage 
syn keyword htmlArg contained tableValues target targetX targetY textLength title to transform type
syn keyword htmlArg contained u1 u2 underline-position underline-thickness unicode unicode-range units-per-em 
syn keyword htmlArg contained v-alphabetic v-hanging v-ideographic v-mathematical values version vert-adv-y vert-origin-x vert-origin-y viewBox viewTarget 
syn keyword htmlArg contained width widths 
syn keyword htmlArg contained x x-height x1 x2 xChannelSelector xlink:actuate xlink:actuate xlink:arcrole xlink:href xlink:role xlink:show xlink:title xlink:type xml:base xml:lang xml:space 
syn keyword htmlArg contained y y1 y2 yChannelSelector 
syn keyword htmlArg contained z zoomAndPan 
syn keyword htmlArg contained alignment-baseline baseline-shift clip-path clip-rule clip color-interpolation-filters color-interpolation color-profile color-rendering color cursor direction display dominant-baseline enable-background fill-opacity fill-rule fill filter flood-color flood-opacity font-family font-size-adjust font-size font-stretch font-style font-variant font-weight glyph-orientation-horizontal glyph-orientation-vertical image-rendering kerning letter-spacing lighting-color marker-end marker-mid marker-start mask opacity overflow pointer-events shape-rendering stop-color stop-opacity stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width stroke text-anchor text-decoration text-rendering unicode-bidi visibility word-spacing writing-mode

" MathML attributes
" https://www.w3.org/TR/MathML3/chapter2.html#interf.toplevel.atts
syn keyword htmlArg contained accent accentunder actiontype align alignmentscope altimg altimg-height altimg-valign altimg-width alttext
syn keyword htmlArg contained annotation-xml background base baseline bevelled cd cdgroup charalign charspacing close
syn keyword htmlArg contained closure color columnalign columnalignment columnlines columnspacing columnspan columnwidth crossout decimalpoint
syn keyword htmlArg contained definitionURL denomalign depth display displaystyle edge encoding equalcolumns equalrows fence
syn keyword htmlArg contained fontfamily fontsize fontstyle fontweight form frame framespacing groupalign height indentalign
syn keyword htmlArg contained indentalignfirst indentalignlast indentshift indentshiftfirst indentshiftlast indenttarget index infixlinebreakstyle integer largeop
syn keyword htmlArg contained leftoverhang length linebreak linebreakmultchar linebreakstyle lineleading linethickness location longdivstyle lquote
syn keyword htmlArg contained lspace ltr macros math mathbackground mathcolor mathsize mathvariant maxsize maxwidth
syn keyword htmlArg contained mediummathspace menclose minlabelspacing minsize mode movablelimits msgroup mslinethickness name nargs
syn keyword htmlArg contained newline notation numalign number occurrence open order other overflow position
syn keyword htmlArg contained rightoverhang role rowalign rowlines rowspacing rowspan rquote rspace schemaLocation scope
syn keyword htmlArg contained scriptlevel scriptminsize scriptsize scriptsizemultiplier selection separator separators shift side stackalign
syn keyword htmlArg contained stretchy subscriptshift superscriptshift symmetric thickmathspace thinmathspace type valign verythickmathspace verythinmathspace
syn keyword htmlArg contained veryverythickmathspace veryverythinmathspace voffset width xref


endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jinja') == -1

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
" Changes:      update to Draft 28 August 2010
"               add complete new attributes
"               add wai-aria attributes
"               add microdata attributes
"               add rdfa attributes


syn keyword htmlTagName contained script
" HTML 5 tags
syn keyword htmlTagName contained article aside audio canvas command
syn keyword htmlTagName contained datalist details dialog embed figcaption figure footer
syn keyword htmlTagName contained header hgroup keygen mark meter menu nav output
syn keyword htmlTagName contained progress time ruby rt rp section source summary time track video wbr

" HTML 5 arguments
" Core Attributes
syn keyword htmlArg contained accesskey class contenteditable contextmenu dir 
syn keyword htmlArg contained draggable hidden id lang spellcheck style tabindex title
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
syn keyword htmlArg contained xml:lang xml:space xml:base
" new features
" <body>
syn keyword htmlArg contained onafterprint onbeforeprint onbeforeunload onblur onerror onfocus onhashchange onload 
syn keyword htmlArg contained onmessage onoffline ononline onpopstate onredo onresize onstorage onundo onunload
" <video>, <audio>, <source>, <track>
syn keyword htmlArg contained autoplay preload controls loop poster media kind charset srclang track
" <form>, <input>, <button>
syn keyword htmlArg contained form autocomplete autofocus list min max step
syn keyword htmlArg contained formaction autofocus formenctype formmethod formtarget formnovalidate
" <command>, <details>, <time>
syn keyword htmlArg contained label icon open datetime pubdate

" Custom Data Attributes
" http://dev.w3.org/html5/spec/Overview.html#custom-data-attribute
syn match   htmlArg "\<\(data(\-[a-z]\+)\+\)=" contained

" Microdata
" http://dev.w3.org/html5/md/
syn keyword htmlArg contained item itemid itemscope itemtype itemprop 

" RDFa
" http://www.w3.org/TR/rdfa-syntax/#a_xhtmlrdfa_dtd
syn keyword htmlArg contained about typeof property resource content datatype rel rev 

" WAI-ARIA States and Properties
" http://www.w3.org/TR/wai-aria/states_and_properties
syn keyword htmlArg contained role
" Global States and Properties
syn match  htmlArg contained "\<aria-\(atomic\|busy\|controls\|describedby\)\>"
syn match  htmlArg contained "\<aria-\(disabled\|dropeffect\|flowto\|grabbed\)\>"
syn match  htmlArg contained "\<aria-\(haspopup\|hidden\|invalid\|label\)\>"
syn match  htmlArg contained "\<aria-\(labelledby\|live\|owns\|relevant\)\>"

" Widget Attributes
syn match  htmlArg contained "\<aria-\(autocomplete\|checked\|disabled\|expanded\)\>"
syn match  htmlArg contained "\<aria-\(haspopup\|hidden\|invalid\|label\)\>"
syn match  htmlArg contained "\<aria-\(level\|multiline\|multiselectable\|orientation\)\>"
syn match  htmlArg contained "\<aria-\(pressed\|readonly\|required\|selected\)\>"
syn match  htmlArg contained "\<aria-\(sort\|valuemax\|valuemin\|valuenow\|valuetext\|\)\>"

" Live Region Attributes
syn match  htmlArg contained "\<aria-\(atomic\|busy\|live\|relevant\|\)\>"

" Drag-and-Drop attributes
syn match  htmlArg contained "\<aria-\(dropeffect\|grabbed\)\>"

" Relationship Attributes
syn match  htmlArg contained "\<aria-\(activedescendant\|controls\|describedby\|flowto\|\)\>"
syn match  htmlArg contained "\<aria-\(labelledby\|owns\|posinset\|setsize\|\)\>"

endif
