" Vim syntax file
" Language: TypeScript
" Author: MicroSoft Open Technologies Inc.
" Version: 0.1
" Credits: Zhao Yi, Claudio Fleiner, Scott Shattuck, Jose Elera Campana

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = "typescript"
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("typeScript_fold")
  unlet typeScript_fold
endif

"" dollar sign is permitted anywhere in an identifier
setlocal iskeyword+=$

syntax sync fromstart

"" syntax coloring for Node.js shebang line
syn match shebang "^#!.*/bin/env\s\+node\>"
hi link shebang Comment

"" typeScript comments"{{{
syn keyword typeScriptCommentTodo TODO FIXME XXX TBD contained
syn match typeScriptLineComment "\/\/.*" contains=@Spell,typeScriptCommentTodo,typeScriptRef
syn match typeScriptRef /\/\/\/<reference\s\+.*\/>$/ contains=typeScriptRefD,typeScriptRefS
syn region typeScriptRefD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+
syn region typeScriptRefS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+

syn match typeScriptCommentSkip "^[ \t]*\*\($\|[ \t]\+\)"
syn region typeScriptComment start="/\*" end="\*/" contains=@Spell,typeScriptCommentTodo
"}}}
"" JSDoc support start"{{{
if !exists("typeScript_ignore_typeScriptdoc")
  syntax case ignore

" syntax coloring for JSDoc comments (HTML)
"unlet b:current_syntax

  syntax region typeScriptDocComment matchgroup=typeScriptComment start="/\*\*\s*$" end="\*/" contains=typeScriptDocTags,typeScriptCommentTodo,typeScriptCvsTag,@typeScriptHtml,@Spell fold
  syntax match typeScriptDocTags contained "@\(param\|argument\|requires\|exception\|throws\|type\|class\|extends\|see\|link\|member\|module\|method\|title\|namespace\|optional\|default\|base\|file\)\>" nextgroup=typeScriptDocParam,typeScriptDocSeeTag skipwhite
  syntax match typeScriptDocTags contained "@\(beta\|deprecated\|description\|fileoverview\|author\|license\|version\|returns\=\|constructor\|private\|protected\|final\|ignore\|addon\|exec\)\>"
  syntax match typeScriptDocParam contained "\%(#\|\w\|\.\|:\|\/\)\+"
  syntax region typeScriptDocSeeTag contained matchgroup=typeScriptDocSeeTag start="{" end="}" contains=typeScriptDocTags

  syntax case match
endif "" JSDoc end
"}}}
syntax case match

"" Syntax in the typeScript code"{{{
syn match typeScriptSpecial "\\\d\d\d\|\\."
syn region typeScriptStringD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+	contains=typeScriptSpecial,@htmlPreproc
syn region typeScriptStringS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+	contains=typeScriptSpecial,@htmlPreproc

syn match typeScriptSpecialCharacter "'\\.'"
syn match typeScriptNumber "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region typeScriptRegexpString start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
" syntax match typeScriptSpecial "\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\."
" syntax region typeScriptStringD start=+"+ skip=+\\\\\|\\$"+ end=+"+ contains=typeScriptSpecial,@htmlPreproc
" syntax region typeScriptStringS start=+'+ skip=+\\\\\|\\$'+ end=+'+ contains=typeScriptSpecial,@htmlPreproc
" syntax region typeScriptRegexpString start=+/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{,3}+ contains=typeScriptSpecial,@htmlPreproc oneline
" syntax match typeScriptNumber /\<-\=\d\+L\=\>\|\<0[xX]\x\+\>/
syntax match typeScriptFloat /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
" syntax match typeScriptLabel /\(?\s*\)\@<!\<\w\+\(\s*:\)\@=/
"}}}
"" typeScript Prototype"{{{
syntax keyword typeScriptPrototype prototype
"}}}
" DOM, Browser and Ajax Support {{{
""""""""""""""""""""""""
syntax keyword typeScriptBrowserObjects window navigator screen history location

syntax keyword typeScriptDOMObjects document event HTMLElement Anchor Area Base Body Button Form Frame Frameset Image Link Meta Option Select Style Table TableCell TableRow Textarea
syntax keyword typeScriptDOMMethods createTextNode createElement insertBefore replaceChild removeChild appendChild hasChildNodes cloneNode normalize isSupported hasAttributes getAttribute setAttribute removeAttribute getAttributeNode setAttributeNode removeAttributeNode getElementsByTagName hasAttribute getElementById adoptNode close compareDocumentPosition createAttribute createCDATASection createComment createDocumentFragment createElementNS createEvent createExpression createNSResolver createProcessingInstruction createRange createTreeWalker elementFromPoint evaluate getBoxObjectFor getElementsByClassName getSelection getUserData hasFocus importNode
syntax keyword typeScriptDOMProperties nodeName nodeValue nodeType parentNode childNodes firstChild lastChild previousSibling nextSibling attributes ownerDocument namespaceURI prefix localName tagName

syntax keyword typeScriptAjaxObjects XMLHttpRequest
syntax keyword typeScriptAjaxProperties readyState responseText responseXML statusText
syntax keyword typeScriptAjaxMethods onreadystatechange abort getAllResponseHeaders getResponseHeader open send setRequestHeader

syntax keyword typeScriptPropietaryObjects ActiveXObject
syntax keyword typeScriptPropietaryMethods attachEvent detachEvent cancelBubble returnValue

syntax keyword typeScriptHtmlElemProperties className clientHeight clientLeft clientTop clientWidth dir href id innerHTML lang length offsetHeight offsetLeft offsetParent offsetTop offsetWidth scrollHeight scrollLeft scrollTop scrollWidth style tabIndex target title

syntax keyword typeScriptEventListenerKeywords blur click focus mouseover mouseout load item

syntax keyword typeScriptEventListenerMethods scrollIntoView addEventListener dispatchEvent removeEventListener preventDefault stopPropagation
" }}}
"" Programm Keywords"{{{
syntax keyword typeScriptSource import export
syntax keyword typeScriptIdentifier arguments this let var void yield
syntax keyword typeScriptOperator delete new instanceof typeof
syntax keyword typeScriptBoolean true false
syntax keyword typeScriptNull null undefined
syntax keyword typeScriptMessage alert confirm prompt status
syntax keyword typeScriptGlobal self top parent
syntax keyword typeScriptDeprecated escape unescape all applets alinkColor bgColor fgColor linkColor vlinkColor xmlEncoding
"}}}
"" Statement Keywords"{{{
syntax keyword typeScriptConditional if else switch
syntax keyword typeScriptRepeat do while for in
syntax keyword typeScriptBranch break continue
syntax keyword typeScriptLabel case default
syntax keyword typeScriptStatement return with

syntax keyword typeScriptGlobalObjects Array Boolean Date Function Infinity Math Number NaN Object Packages RegExp String netscape

syntax keyword typeScriptExceptions try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError

syntax keyword typeScriptReserved constructor declare as interface module abstract enum int short export interface static byte extends long super char final native synchronized class float package throws const goto private transient debugger implements protected volatile double import public type
"}}}
"" TypeScript/DOM/HTML/CSS specified things"{{{

" TypeScript Objects"{{{
  syn match typeScriptFunction "(super\s*|constructor\s*)" contained nextgroup=typeScriptVars
  syn region typeScriptVars start="(" end=")" contained contains=typeScriptParameters transparent keepend
  syn match typeScriptParameters "([a-zA-Z0-9_?.$][\w?.$]*)\s*:\s*([a-zA-Z0-9_?.$][\w?.$]*)" contained skipwhite
"}}}
" DOM2 Objects"{{{
  syntax keyword typeScriptType DOMImplementation DocumentFragment Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction void any string boolean number
  syntax keyword typeScriptExceptions DOMException
"}}}
" DOM2 CONSTANT"{{{
  syntax keyword typeScriptDomErrNo INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
  syntax keyword typeScriptDomNodeConsts ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE
"}}}
" HTML events and internal variables"{{{
  syntax case ignore
  syntax keyword typeScriptHtmlEvents onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize onload onsubmit
  syntax case match
"}}}

" Follow stuff should be highligh within a special context
" While it can't be handled with context depended with Regex based highlight
" So, turn it off by default
if exists("typeScript_enable_domhtmlcss")

" DOM2 things"{{{
    syntax match typeScriptDomElemAttrs contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
    syntax match typeScriptDomElemFuncs contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=typeScriptParen skipwhite
"}}}
" HTML things"{{{
    syntax match typeScriptHtmlElemAttrs contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
    syntax match typeScriptHtmlElemFuncs contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=typeScriptParen skipwhite
"}}}
" CSS Styles in typeScript"{{{
    syntax keyword typeScriptCssStyles contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
    syntax keyword typeScriptCssStyles contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
    syntax keyword typeScriptCssStyles contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
    syntax keyword typeScriptCssStyles contained bottom height left position right top width zIndex
    syntax keyword typeScriptCssStyles contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
    syntax keyword typeScriptCssStyles contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
    syntax keyword typeScriptCssStyles contained listStyle listStyleImage listStylePosition listStyleType
    syntax keyword typeScriptCssStyles contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
    syntax keyword typeScriptCssStyles contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
    syntax keyword typeScriptCssStyles contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
    syntax keyword typeScriptCssStyles contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor
"}}}
" Highlight ways"{{{
    syntax match typeScriptDotNotation "\." nextgroup=typeScriptPrototype,typeScriptDomElemAttrs,typeScriptDomElemFuncs,typeScriptHtmlElemAttrs,typeScriptHtmlElemFuncs
    syntax match typeScriptDotNotation "\.style\." nextgroup=typeScriptCssStyles
"}}}
endif "DOM/HTML/CSS

"" end DOM/HTML/CSS specified things""}}}


"" Code blocks
syntax cluster typeScriptAll contains=typeScriptComment,typeScriptLineComment,typeScriptDocComment,typeScriptStringD,typeScriptStringS,typeScriptRegexpString,typeScriptNumber,typeScriptFloat,typeScriptLabel,typeScriptSource,typeScriptType,typeScriptOperator,typeScriptBoolean,typeScriptNull,typeScriptFuncKeyword,typeScriptConditional,typeScriptGlobal,typeScriptRepeat,typeScriptBranch,typeScriptStatement,typeScriptGlobalObjects,typeScriptMessage,typeScriptIdentifier,typeScriptExceptions,typeScriptReserved,typeScriptDeprecated,typeScriptDomErrNo,typeScriptDomNodeConsts,typeScriptHtmlEvents,typeScriptDotNotation,typeScriptBrowserObjects,typeScriptDOMObjects,typeScriptAjaxObjects,typeScriptPropietaryObjects,typeScriptDOMMethods,typeScriptHtmlElemProperties,typeScriptDOMProperties,typeScriptEventListenerKeywords,typeScriptEventListenerMethods,typeScriptAjaxProperties,typeScriptAjaxMethods,typeScriptFuncArg

if main_syntax == "typeScript"
  syntax sync clear
  syntax sync ccomment typeScriptComment minlines=200
" syntax sync match typeScriptHighlight grouphere typeScriptBlock /{/
endif

syntax keyword typeScriptFuncKeyword function contained
syntax region typeScriptFuncDef start="function" end="\([^)]*\)" contains=typeScriptFuncKeyword,typeScriptFuncArg keepend
syntax match typeScriptFuncArg "\(([^()]*)\)" contains=typeScriptParens,typeScriptFuncComma contained
syntax match typeScriptFuncComma /,/ contained
" syntax region typeScriptFuncBlock contained matchgroup=typeScriptFuncBlock start="{" end="}" contains=@typeScriptAll,typeScriptParensErrA,typeScriptParensErrB,typeScriptParen,typeScriptBracket,typeScriptBlock fold

syn match	typeScriptBraces "[{}\[\]]"
syn match	typeScriptParens "[()]"
syn match	typeScriptOpSymbols "=\{1,3}\|!==\|!=\|<\|>\|>=\|<=\|++\|+=\|--\|-="
syn match typeScriptEndColons "[;,]"
syn match typeScriptLogicSymbols "\(&&\)\|\(||\)"

" typeScriptFold Function {{{

function! TypeScriptFold()
setl foldlevelstart=1
syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

setl foldtext=FoldText()
endfunction

au FileType typeScript call TypeScriptFold()

" }}}

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_typeScript_syn_inits")
  if version < 508
    let did_typeScript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  "Typescript highlighting
  HiLink typeScriptParameters Operator
  HiLink typescriptSuperBlock Operator

  HiLink typeScriptEndColons Exception
  HiLink typeScriptOpSymbols Operator
  HiLink typeScriptLogicSymbols Boolean
  HiLink typeScriptBraces Function
  HiLink typeScriptParens Operator
  HiLink typeScriptComment Comment
  HiLink typeScriptLineComment Comment
  HiLink typeScriptRef Include
  HiLink typeScriptRefS String
  HiLink typeScriptRefD String
  HiLink typeScriptDocComment Comment
  HiLink typeScriptCommentTodo Todo
  HiLink typeScriptCvsTag Function
  HiLink typeScriptDocTags Special
  HiLink typeScriptDocSeeTag Function
  HiLink typeScriptDocParam Function
  HiLink typeScriptStringS String
  HiLink typeScriptStringD String
  HiLink typeScriptRegexpString String
  HiLink typeScriptGlobal Constant
  HiLink typeScriptCharacter Character
  HiLink typeScriptPrototype Type
  HiLink typeScriptConditional Conditional
  HiLink typeScriptBranch Conditional
  HiLink typeScriptIdentifier Identifier
  HiLink typeScriptRepeat Repeat
  HiLink typeScriptStatement Statement
  HiLink typeScriptFuncKeyword Type
  HiLink typeScriptMessage Keyword
  HiLink typeScriptDeprecated Exception
  HiLink typeScriptError Error
  HiLink typeScriptParensError Error
  HiLink typeScriptParensErrA Error
  HiLink typeScriptParensErrB Error
  HiLink typeScriptParensErrC Error
  HiLink typeScriptReserved Keyword
  HiLink typeScriptOperator Operator
  HiLink typeScriptType Type
  HiLink typeScriptNull Type
  HiLink typeScriptNumber Number
  HiLink typeScriptFloat Number
  HiLink typeScriptBoolean Boolean
  HiLink typeScriptLabel Label
  HiLink typeScriptSpecial Special
  HiLink typeScriptSource Special
  HiLink typeScriptGlobalObjects Special
  HiLink typeScriptExceptions Special

  HiLink typeScriptDomErrNo Constant
  HiLink typeScriptDomNodeConsts Constant
  HiLink typeScriptDomElemAttrs Label
  HiLink typeScriptDomElemFuncs PreProc

  HiLink typeScriptHtmlElemAttrs Label
  HiLink typeScriptHtmlElemFuncs PreProc

  HiLink typeScriptCssStyles Label
" Ajax Highlighting
HiLink typeScriptBrowserObjects Constant

HiLink typeScriptDOMObjects Constant
HiLink typeScriptDOMMethods Exception
HiLink typeScriptDOMProperties Type

HiLink typeScriptAjaxObjects htmlH1
HiLink typeScriptAjaxMethods Exception
HiLink typeScriptAjaxProperties Type

HiLink typeScriptFuncDef Title
    HiLink typeScriptFuncArg Special
    HiLink typeScriptFuncComma Operator

HiLink typeScriptHtmlEvents Special
HiLink typeScriptHtmlElemProperties Type

HiLink typeScriptEventListenerKeywords Keyword

HiLink typeScriptNumber Number
HiLink typeScriptPropietaryObjects Constant

  delcommand HiLink
endif

" Define the htmltypeScript for HTML syntax html.vim
"syntax clear htmltypeScript
"syntax clear typeScriptExpression
syntax cluster htmltypeScript contains=@typeScriptAll,typeScriptBracket,typeScriptParen,typeScriptBlock,typeScriptParenError
syntax cluster typeScriptExpression contains=@typeScriptAll,typeScriptBracket,typeScriptParen,typeScriptBlock,typeScriptParenError,@htmlPreproc

let b:current_syntax = "typeScript"
if main_syntax == 'typeScript'
  unlet main_syntax
endif

" vim: ts=4
