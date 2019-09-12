if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emblem') == -1

" Language:    emblem
" Maintainer:  Yulij Andreevich Lesov <yalesov@gmail.com>
" URL:         http://github.com/yalesov/vim-emblem
" Version:     2.0.1
" Last Change: 2016 Jul 6
" License:     ISC

" Quit when a syntax file is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'emblem'
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'emblem'
endif

syn match eblLineStart '^\s*' nextgroup=@eblStartElements                     display
syn match eblLineOp    '\s*:' nextgroup=@eblStartElements skipwhite contained display
hi def link eblLineOp eblOperator

syn cluster eblStartElements contains=eblIdOp,eblClassOp,eblHbsOp,@eblHbsHelpers,eblHbsPartialOp,eblView,@eblTag,eblComment,eblText

syn cluster eblComponent     contains=eblIdOp,eblClassOp,eblInlineText,eblAttr,eblHbsOp,eblHbsAttrRegion,eblHbsPartialOp,eblLineOp

syn match eblIdOp    '#'         nextgroup=eblId         contained display
syn match eblId      '\v(\w|-)+' nextgroup=@eblComponent contained display
syn match eblClassOp '\.'        nextgroup=eblClass      contained display
syn match eblClass   '\v(\w|-)+' nextgroup=@eblComponent contained display
hi def link eblIdOp    eblId
hi def link eblClassOp eblClass

syn region eblHbsAttrRegion matchgroup=eblHbsAttrRegionOp start='{\|(\|\[' end='}\|)\|\]' contains=@eblHbsHelpers nextgroup=@eblComponent keepend contained display
hi def link eblHbsAttrRegionOp eblOperator

syn match eblInlineText '\v\s+[^:]+.*$' contains=eblItpl contained display
hi def link eblInlineText eblRaw

syn cluster eblHbsComponent contains=eblHbsArg,eblHbsAttr,eblHbsTextOp,eblLineOp

syn match eblHbsOp             '\v\s*\=+'                                                      nextgroup=@eblHbsHelpers     skipwhite contained display
syn match eblHbsHelper         '\v\w(\w|-|\.|\/)*'                                             nextgroup=@eblHbsComponent   skipwhite contained display
syn match eblHbsTextOp         '|'                                                             nextgroup=eblHbsText                   contained display
syn match eblHbsText           '.*'                                                                                                   contained display
hi def link eblHbsOp             eblOperator
hi def link eblHbsHelper         eblFunction
hi def link eblHbsTextOp         eblOperator
hi def link eblHbsText           eblRaw

syn cluster eblHbsHelpers contains=eblHbsHelper,eblHbsCtrlFlowHelper,eblHbsEachHelper,eblHbsWithHelper

syn match eblHbsCtrlFlowHelper   '\v<(else if|if|unless|else)>'                                  nextgroup=@eblHbsComponent                           skipwhite contained display
syn match eblHbsEachHelper       '\v<each>'                                                      nextgroup=eblHbsEachArg                              skipwhite contained display
syn match eblHbsEachArg          /\v((["'])[^\2]{-}\2|(\w|\.|-|\>)+)/                            nextgroup=eblHbsIn,eblLineOp                         skipwhite contained display
syn match eblHbsIn               '\v<in>'                                                        nextgroup=eblHbsInArg                                skipwhite contained display
syn match eblHbsInArg            /\v((["'])[^\2]{-}\2|(\w|\.|-|\>)+)/                            nextgroup=eblLineOp                                  skipwhite contained display
syn match eblHbsWithHelper       '\v<with>'                                                      nextgroup=eblHbsWithArg                              skipwhite contained display
syn match eblHbsWithArg          /\v((["'])[^\2]{-}\2|(\w|\.|-|\>)+)/                            nextgroup=eblHbsAs                                   skipwhite contained display
syn match eblHbsAs               '\v<as>'                                                        nextgroup=eblHbsAsBlockStartArg                      skipwhite contained display
syn match eblHbsAsBlockStartArg  /\v\|/                                                          nextgroup=eblHbsAsBlockFirstArg                      skipwhite contained display
syn match eblHbsAsBlockFirstArg  /\v((["'])[^\2]{-}\2|(\w|\.|-|\>)+)/                            nextgroup=eblHbsAsBlockSecondArg,eblHbsAsBlockEndArg skipwhite contained display
syn match eblHbsAsBlockSecondArg /\v((["'])[^\2]{-}\2|(\w|\.|-|\>)+)/                            nextgroup=eblHbsAsBlockEndArg                        skipwhite contained display
syn match eblHbsAsBlockEndArg    /\v\|/                                                          nextgroup=eblLineOp                                  skipwhite contained display
hi def link eblHbsCtrlFlowHelper   eblKeyword
hi def link eblHbsEachHelper       eblKeyword
hi def link eblHbsEachArg          eblLiteral
hi def link eblHbsIn               eblKeyword
hi def link eblHbsInArg            eblLiteral
hi def link eblHbsWithHelper       eblKeyword
hi def link eblHbsWithArg          eblLiteral
hi def link eblHbsAs               eblKeyword
hi def link eblHbsAsBlockStartArg  eblOperator
hi def link eblHbsAsBlockFirstArg  eblLiteral
hi def link eblHbsAsBlockSecondArg eblLiteral
hi def link eblHbsAsBlockEndArg    eblOperator

syn match eblHbsArg            /\v\s*((["'])[^\2]{-}\2|(\w|\.|-|\>)+)/                         nextgroup=@eblHbsComponent   skipwhite contained display
syn match eblHbsAttr           '\v\s*(\w|-)+\=@='                      contains=eblHbsAttrBind nextgroup=eblHbsAttrOp                 contained display
syn match eblHbsAttrBind       /\v<(\w|-)+Bind>/                                                                                      contained display
syn match eblHbsAttrOp         '='                                                             nextgroup=eblHbsAttrLit                contained display
syn match eblHbsAttrLit        /\v(["'])[^\1]{-}\1|[^\.: ]+/             contains=eblItpl        nextgroup=@eblHbsComponent   skipwhite contained display
hi def link eblHbsArg            eblLiteral
hi def link eblHbsAttr           eblAttr
hi def link eblhbsAttrBind       eblBind
hi def link eblHbsAttrOp         eblOperator
hi def link eblHbsAttrLit        eblLiteral

syn cluster eblAttrComponent contains=eblAttr,eblInlineText,eblLineOp

syn match eblAttr                '\v\s*(\w|-)+\=@='   contains=eblKnownEvent nextgroup=eblAttrOp                                                         contained display
syn match eblAttrOp              '='                                         nextgroup=eblAttrLit,eblAttrClassLit,eblAttrBind,eblAttrRegion              contained display
syn match eblAttrLit             /\v(["'])[^\1]{-}\1/ contains=eblItpl       nextgroup=@eblAttrComponent                                       skipwhite contained display
syn match eblAttrBind            /\v(\w|-)+/                                 nextgroup=eblAttrBindAltOp,eblAttrBindUnboundOp,@eblAttrComponent skipwhite contained display
syn match eblAttrBindAltOp       '\v(\w|-|:)@=:(\w|-|:)@='                   nextgroup=eblAttrBindAlt,eblAttrBindAltOp                                   contained display
syn match eblAttrBindAlt         /\v(\w|-)+/                                 nextgroup=eblAttrBindAltOp,@eblAttrComponent                      skipwhite contained display
syn match eblAttrClassLit        '\v:(\w|-)+'                                nextgroup=@eblAttrComponent                                       skipwhite contained display
syn match eblAttrBindUnboundOp   '\v(\w|-)@!!'                               nextgroup=@eblAttrComponent                                       skipwhite contained display
hi def link eblAttrOp               eblOperator
hi def link eblAttrLit              eblLiteral
hi def link eblAttrBind             eblBind
hi def link eblAttrBindAltOp        eblOperator
hi def link eblAttrBindAlt          eblBool
hi def link eblAttrClassLit         eblLiteral
hi def link eblAttrBindUnboundOp    eblOperator

syn region eblAttrRegion matchgroup=eblAttrRegionOp start='{' end='}' keepend contains=eblAttrRegionBind,eblAttrRegionClassLit nextgroup=@eblAttrComponent skipwhite contained display
syn match eblAttrRegionBind      /\v(\w|-)+/                                 nextgroup=eblAttrRegionBindAltOp                                            contained display
syn match eblAttrRegionBindAltOp '\v(\w|-|:)@=:(\w|-|:)@='                   nextgroup=eblAttrRegionBindAlt,eblAttrRegionBindAltOp                       contained display
syn match eblAttrRegionBindAlt   /\v(\w|-)+/                                 nextgroup=eblAttrRegionBindAltOp                                            contained display
syn match eblAttrRegionClassLit  '\v:(\w|-)+:@!'                             nextgroup=eblAttrRegionBind                                       skipwhite contained display
hi def link eblAttrRegionOp         eblOperator
hi def link eblAttrRegionBind       eblBind
hi def link eblAttrRegionBindAltOp  eblOperator
hi def link eblAttrRegionBindAlt    eblBool
hi def link eblAttrRegionClassLit   eblLiteral

syn match eblKnownEvent '\v\s*<(touchStart|touchMove|touchEnd|touchCancel|keyDown|keyUp|keyPress|mouseDown|mouseUp|contextMenu|click|doubleClick|mouseMove|focusIn|focusOut|mouseEnter|mouseLeave|submit|input|change|dragStart|drag|dragEnter|dragLeave|dragOver|drop|dragEnd)>' contained display
hi def link eblKnownEvent eblEvent

syn region eblItpl matchgroup=eblItplOp start='#{' end='}'  contains=@eblHbsHelpers,eblHbsPartialOp keepend contained display
syn region eblItpl matchgroup=eblItplOp start='{{' end='}}' contains=@eblHbsHelpers,eblHbsPartialOp keepend contained display
syn region eblItpl matchgroup=eblItplOp start='(' end=')'   contains=@eblHbsHelpers,eblHbsPartialOp keepend contained display
hi def link eblItplOp eblOperator

syn match eblHbsPartialOp '\s*>' nextgroup=@eblHbsHelpers skipwhite contained display
hi def link eblhbsPartialOp eblOperator

syn match eblView        '\v[A-Z](\w|\.)*' nextgroup=@eblViewComponent skipwhite contained display

syn cluster eblViewComponent contains=eblViewIdOp,eblViewClassOp,eblHbsArg,eblHbsAttr,eblLineOp

syn match eblViewIdOp    '#'               nextgroup=eblViewId                   contained display
syn match eblViewId      '\v(\w|-)+'       nextgroup=@eblViewComponent           contained display
syn match eblViewClassOp '\.'              nextgroup=eblViewClass                contained display
syn match eblViewClass   '\v(\w|-)+'       nextgroup=@eblViewComponent           contained display
hi def link eblViewIdOp     eblId
hi def link eblViewId       eblId
hi def link eblViewClassOp  eblClass
hi def link eblViewClass    eblClass

syn cluster eblTag contains=eblKnownTag,eblCustomTag

syn match eblKnownTag '\v<(figcaption|blockquote|plaintext|textarea|progress|optgroup|noscript|noframes|frameset|fieldset|datalist|colgroup|basefont|summary|section|marquee|listing|isindex|details|command|caption|bgsound|article|address|acronym|strong|strike|spacer|source|select|script|output|option|object|legend|keygen|iframe|hgroup|header|footer|figure|center|canvas|button|applet|video|track|title|thead|tfoot|tbody|table|style|small|param|meter|label|input|frame|embed|blink|audio|aside|time|span|samp|ruby|nobr|meta|menu|mark|main|link|html|head|form|font|data|code|cite|body|base|area|abbr|xmp|wbr|var|sup|sub|pre|nav|map|kbd|ins|img|div|dir|dfn|del|col|big|bdo|bdi|ul|tt|tr|th|td|rt|rp|ol|li|hr|h6|h5|h4|h3|h2|h1|em|dt|dl|dd|br|u|s|q|p|i|b|a)>' nextgroup=@eblComponent contained display
syn match eblCustomTag '%[a-z][a-z0-9-]*' nextgroup=@eblComponent contained display
hi def link eblKnownTag  eblTag
hi def link eblCustomTag eblTag

syn match eblTextOp '\v^(\s*)[|']' contained display
syn region eblText    start='\v^\z(\s*)[|']' end='\v^(\z1 )@!' contains=eblTextOp,eblItpl
syn region eblComment start='\v^\z(\s*)/'    end='\v^(\z1 )@!'
hi def link eblText   eblRaw
hi def link eblTextOp eblOperator


hi def link eblOperator Operator
hi def link eblFunction Function
hi def link eblBool     Boolean
hi def link eblLiteral  String
hi def link eblRaw      NONE
hi def link eblComment  Comment

hi def link eblAttr     Label
hi def link eblBind     Identifier
hi def link eblKeyword  Keyword
hi def link eblEvent    Special

hi def link eblView     Type
hi def link eblTag      Type
hi def link eblId       Constant
hi def link eblClass    Identifier

let b:current_syntax = 'emblem'

endif
