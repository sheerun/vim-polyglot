if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xls') == -1

" Vim syntax file
" Language:	XSLT 1.0
" with HTML, CSS, JavaScript, PerlScript, VBScript and MSXSL extention
"
" Last Change:	24 May 2002
" Filenames:	*.xslt, *.xsl
" Maintainar:	Atsushi Moriki <four@olive.freemail.ne.jp>
"
" Version: 		0.3.11
"
" Summary:		Syntax Highlight for XSLT (with HTML and Others)
" Description:  Syntax Highlight for XSLT with HTML keywords. 
"
"				containing keywords
"					HTML
"					CSS (use css.vim)
"					JavaScript (use js.vim)
"					VBScript (use vb.vim)
"					PerlScript (use perl.vim)
"
" Instration:
" 				other keyword highlighting
"					:let b:xsl_include_html = 1			> HTML
"					:let b:xsl_include_css = 1			> CSS
"					:let b:xsl_include_javascript = 1	> JavaScript
"					:let b:xsl_include_perl = 1			> PerlScript
"					:let b:xsl_include_vbs = 1			> VBScript
"
"
"include keyword setting :
"	let b:xsl_include_html = 1			" HTML
"	let b:xsl_include_css = 1			" CSS
"	let b:xsl_include_javascript = 1	" JavaScript
"	let b:xsl_include_perl = 1			" PerlScript
"	let b:xsl_include_vbs = 1			" VBScript


if exists("b:current_syntax")
  finish
endif

if exists('b:Xsl_SyntaxFold_by') == ''
	let b:Xsl_SyntaxFold_by=''
endif

"let s:xml_cpo_save = &cpo
"let main_syntax = 'xsl'
"set cpo&vim

syn case match

" ERROR
syn match xmlErr	 +[^ 	]+ contained

" XML
syn cluster	xmlSyntax contains=xmlTagStart
syn match	xmlTagStart +<\([!?]\)\@!/\=\(xsl\>\)\@!+
		\ nextgroup=xml_schemaElementNameSpace,xmlElementName
		\ containedin=@xmlCss
syn match	xmlTagStart +</\=\(xsl\>\)\@=+
		\ nextgroup=xml_xslElementNameSpace
		\ containedin=@xmlCss
" Element Name
syn match xmlElementName +[^!?/[:blank:]>=0-9,][^!?/[:blank:]>=,]*\>+
		\ contained
		\ nextgroup=xmlTagEnd,xmlAttNameStyle,xmlAttName
		\ skipwhite skipempty
		\ contains=xml_htmlTagName


" Attribute Name
syn match	xmlAttName +[^!?><=[:blank:]0-9][^!?><=[:blank:]]*+ contained nextgroup=xmlAttEqual skipwhite skipempty contains=xml_htmlAttName,xmlAttNameNs

syn match	xmlAttName +[^!?><=[:blank:]0-9][^!?><=[:blank:]]*+ contained nextgroup=xmlAttEqual skipwhite skipempty contains=xml_htmlAttName,xmlAttNameNs

syn match	xmlAttNameNs +[^!?><=[:blank:]0-9][^!?><=:[:blank:]]*:+ contained nextgroup=xmlAttName

syn match	xmlAttNameNs +\<\(xml\):+ contained nextgroup=xml_reserveAttName_inXmlElement contains=xmlAttNameNsHl_xmlReserve
syn match	xml_reserveAttName_inXmlElement +[^><=[:blank:]]\++ contained nextgroup=xmlAttEqual contains=xmlAttNameHl skipwhite skipempty

syn match	xmlAttNameNsHl_xmlReserve +\<xml\>+ contained

hi link xmlAttNameNsHl_xmlReserve Type

syn match	xmlAttNameNs +\<\(xsl\|msxsl\|saxon\|xt\):+ contained nextgroup=xml_xslAttName_inXmlElement contains=xmlAttNameNsHl_xsl
syn match	xmlAttNameNsHl_xsl +\<\(xsl\|msxsl\|saxon\|xt\)\>+ contained
hi link xmlAttNameNsHl_xsl Exception

syn match	xml_xslAttName_inXmlElement +[^><=[:blank:]]\++ contained nextgroup=xmlAttEqual contains=xml_xslAttNameHl skipwhite skipempty

syn match	xmlAttName +xmlns:[^!?><=[:blank:]0-9][^!?><=:[:blank:]]*+ contained nextgroup=xmlAttEqual skipwhite skipempty contains=xmlns_xsl
syn match	xmlns_xsl +xmlns:xsl+ contained

syn keyword	xmlAttNameHl attribute lang link space


syn match	xmlAttNameStyle +style+ contained nextgroup=xmlAttEqualStyle skipwhite skipempty contains=xml_htmlAttName

" '='
syn match	xmlAttEqual +=+ contained nextgroup=xmlAttValue skipwhite skipempty
" Attribute Value
syn region	xmlAttValue
		\ matchgroup=xmlAttValueQuotS start=+\z(["']\)+rs=e
		\ matchgroup=xmlAttValueQuotE end=+\z1+re=s
		\ nextgroup=xmlTagEnd,xmlAttNameStyle,xmlAttName
		\ contained skipwhite skipempty keepend
		\ contains=xmlAttValueErr,stringContXpath,xmlAttValueKeyword,xmlAttValueKeyword_id,xmlAttValueKeyword_class



" XSL
syn match	xml_xslElementNameSpace +\(xsl\|msxsl\|saxon\|xt\):+he=e-1
		\ contained nextgroup=xml_xslElementName
syn match	xml_xslElementName +[a-z0-9-]\++
		\ contained
		\ nextgroup=xmlTagEnd,xml_xslAttName,xml_xslAttNameXPath
		\ contains=xml_xslElementLocalName
		\ skipwhite skipempty

syn match	xml_xslAttName +[^><=[:blank:]]\++ contained nextgroup=xml_xslAttEqual contains=xml_xslAttNameHl skipwhite skipempty
syn match	xml_xslAttEqual +=+ contained nextgroup=xml_xslAttValue skipwhite skipempty

syn match	xml_xslAttNameXPath +\(count\|select\|test\|match\)+ contained nextgroup=xml_xslAttEqualXPath contains=xml_xslAttNameHl skipwhite skipempty
syn match	xml_xslAttEqualXPath +=+ contained nextgroup=xml_xslAttValueXPath skipwhite skipempty

syn region	xml_xslAttValue
	    \ matchgroup=xmlAttValueQuotS start=+\z(["']\)+rs=e
	    \ matchgroup=xmlAttValueQuotE end=+\z1+re=s
	    \ contained
	    \ nextgroup=xmlTagEnd,xml_xslAttName,xml_xslAttNameXPath skipwhite skipempty keepend
	    \ contains=xmlAttValueErr,stringContXpath,xml_xslAttValueKeyword

syn region	xml_xslAttValueXPath
	    \ matchgroup=xmlAttValueQuotS start=+\z(["']\)+rs=e
	    \ matchgroup=xmlAttValueQuotE end=+\z1+re=s
	    \ contained
	    \ nextgroup=xmlTagEnd,xml_xslAttName,xml_xslAttNameXPath
	    \ skipwhite skipempty keepend
	    \ contains=@xpaths


" TAG END
syn match	xmlTagEnd +/\=>+ contained


"XSL TAG "{{{
syn match	xml_xslElementLocalName contained +\(:\)\@<=\(apply-imports\|apply-templates\|attribute-set\|attribute\)+
syn match	xml_xslElementLocalName contained +\(:\)\@<=\(call-template\|choose\|comment\|copy-of\|copy\|decimal-format\|element\)\>+
syn match	xml_xslElementLocalName contained +\(:\)\@<=\(fall-back\|for-each\|if\|-\@<!import\|include\|key\)\>+
syn match	xml_xslElementLocalName contained +\(:\)\@<=\(message\|namespace\(-alias\)\=\|number\|otherwise\|output\)\>+
syn match	xml_xslElementLocalName contained +\(:\)\@<=\(-\@<!param\|preserve-space\|processing\(-instruction\)\=\|sort\|strip-space\)\>+
syn match	xml_xslElementLocalName contained "\(:\)\@<=\(stylesheet\|-\@<!template\|text\|transform\|value-of\|variable\)\>"
syn match	xml_xslElementLocalName contained "\(:\)\@<=\(when\|with-param\)\>"

" MSXSL Extention
syn match	xml_xslElementLocalName contained "\(:\)\@<=\(script\)\>"

"}}}

" XSL Attribute "{{{
syn match	xml_xslAttNameHl contained +\<\(case-\(order\>\)\=\|count\>\|data-\(type\>\)\=\|disable-\(output-\(escaping\>\)\=\)\=\|decimal-\(separator\>\)\=\|digit\>\)+
syn match	xml_xslAttNameHl contained +\<\(elements\|encoding\|from\|format\|grouping-\(separator\|size\)\|href\)\>+
syn match	xml_xslAttNameHl contained +\<\(id\|indent\|infinity\|lang\|letter-value\|level\|match\|method\|mode\|minus-sign\)\>+
syn match	xml_xslAttNameHl contained +\<\(namespace\|name\|NaN\|order\)\>+
syn match	xml_xslAttNameHl contained +\<\(omit\(-xml\(-declaration\)\=\)\=\|pattern-separator\|percent\|per-mille\|priority\)\>+
syn match	xml_xslAttNameHl contained +\<\(select\|stylesheet-prefix\|test\|terminate\|use-attribute-set\|use\|version\|zero-digit\)\>+
syn match	xml_xslAttNameHl contained +\<\(extension-element-prefixes\|exclude-result-prefixes\)\>+
syn match	xml_xslAttNameHl contained +\<cdata-\(section-\(elements\>\)\=\)\=+
syn match	xml_xslAttNameHl contained +\(standalone\>\|doctype-\(public\>\|system\>\)\=\|media-\(type\>\)\=\)+

" MSXSL Extension
syn match	xml_xslAttNameHl contained +\<language\>+
syn match	xml_xslAttNameHl contained +implements-prefix+
" XML Name Space
syn match	xml_xslAttNameHl contained +\<\(xmlns:\)+
syn match	xml_xslAttNameHl contained +\<\(xmlns:\(xsl\|msxsl\|saxon\|xt\)\)\>+

 "}}}

" XPath "{{{
syn cluster	xpaths contains=xmlAttValueErr,xpathFilter,xpathBracket,xpathString,xpathFunction,xpathOperand,xpathAxis,xpathVariable,xpathNumber
"
syn region	stringContXpath matchgroup=stringContXpathBracket start=+{+ end=+}+ contained contains=@xpaths

syn region	xpathFilter transparent matchgroup=xpathFilterBracket start=+\[+ end=+\]+ contained contains=@xpaths

syn region	xpathBracket transparent matchgroup=xpathBracketBracket start=+(+ end=+)+ contained contains=@xpaths

syn region	xpathString start=+\z(["']\)+ end=+\z1+ keepend contained contains=xmlAttValueErr,@xmlRef

syn match	xpathVariable +\$[^!"#$%&'()=~^|\\{}\[\]`@\:;+*?/<>,.[:blank:]]\++ contained
syn match	xpathNumber +\([^!"#$%&'()=~^|\\{}\[\]`@\:;+*?/<>,.[:blank:]]-\)\@<!\<[0-9]\+\>+ contained
hi def link xpathNumber Number
 "}}}
" XPath Function "{{{
syn region	xpathFunction matchgroup=xpathFunctionName transparent contains=@xpaths contained end=+)+
	    \ start=+\(contains\|format-number\|substring-before\|substring-after\|substring\|local-name\|namespace-uri\|normalize-space\|starts-with\|string-length\|string\)(+
syn region	xpathFunction matchgroup=xpathFunctionName transparent contains=@xpaths contained end=+)+
	    \ start=+\(element-available\|function-available\|generate-id\|system-property\|unparsed-entity-uri\|processing-instruction\|comment\|node\|text\)(+
syn region	xpathFunction matchgroup=xpathFunctionName transparent contains=@xpaths contained end=+)+
	    \ start=+\(count\|document\|key\|id\|last\|name\|position\|concat\|translate\|boolean\|false\|lang\|not\|true\|ceiling\|floor\|number\|round\|sum\|current\)(+

" "}}}
" XPath Axis "{{{
syn match	xpathAxis transparent +[a-z-]\+::+ contains=xpathAxisName contained
syn match	xpathAxisName +\<\(ancestor\(-or-self\)\=\|attribute\|child\|descendant\(-or-self\)\=\)+ contained
syn match	xpathAxisName +\<\(following\(-sibling\)\=\|namespace\|parent\|preceding\(-sibling\)\=\|self\)+ contained

 "}}}
" XPath Operand "{{{
syn match	xpathOperand contained +\([/]\)\@<!\<\(div\|or\|and\|mod\)\>\([/]\)\@!+
syn match	xpathOperand contained +\([^ !='"<>\[($&]\@<!-[^ !='"<>\[($&]\@!\|[+=>]\|&lt;\|>=\|&lt;=\|!=\||\)+
syn match	xpathOperand contained +\(\s*[^/|\]\["@]\)\@<=\(\([^"':/\[\]]\)\@=\s*\*\)\([/\[]\)\@!+
"}}}

" Attribute Value Highlight "{{{
syn match	xmlAttValueKeyword +\(\<xmlns:xsl="\)\@<=http://www\.w3\.org\(/1999\(/XSL\(/Transform\)\=\)\=\)\=\>+ contained
syn match	xml_xslAttValueKeyword +\(\<xmlns:xsl="\)\@<=http://www\.w3\.org\(/1999\(/XSL\(/Transform\)\=\)\=\)\=\>+ contained
syn match	xml_xslAttValueKeyword +["']\@<=\(yes\|no\|true\|false\)\>+ contained
syn match	xml_xslAttValueKeyword +\(\<order\s*=\s*["']\)\@<=\(ascending\|descending\)\>+ contained
syn match	xml_xslAttValueKeyword +\(\<method\s*=\s*["']\)\@<=\(xml\|html\|text\)\>+ contained
syn match	xml_xslAttValueKeyword +\(\<encoding\s*=\s*["']\)\@<=\(UTF-\(8\|16\|32\)\|Shift_JIS\|iso-2022-jp\|EUC-JP\)\>+ contained
syn match	xml_xslAttValueKeyword +\(\<language\s*=\s*["']\)\@<=\(\(Java\|Perl\|VB\)Script\)\>+ contained

hi xmlAttValueKeyword gui=bold
hi xml_xslAttValueKeyword gui=bold

syn match	xmlAttValueKeyword_class +\(\<class="\)\@<=[^"]*\>+ contained contains=stringContXpath
syn match	xmlAttValueKeyword_id +\(\<id="\)\@<=[^"]*\>+ contained contains=stringContXpath

hi def link xmlAttValueKeyword_class Define
hi def link xmlAttValueKeyword_id Define
 "}}}

" XML ProcessingInstructon "{{{
syn region	xmlProcessing
			\ matchgroup=xmlProcessingMark start=+<?+
			\ end=+\(?>\|<\@=\)+
			\ contains=xmlProcessingElement keepend
syn match	xmlProcessingElementOver	+[^ ]\++ nextgroup=xmlProcessingAttName contained
syn match	xmlProcessingElement		+\(xml-stylesheet\|xml\)+ nextgroup=xmlProcessingAtt contained
syn match	xmlProcessingAtt			+\(\s\|\n\)\+[a-zA-Z]\w*\s*=+ contained contains=xmlProcessingAttName nextgroup=xmlProcessingAttValue
syn match	xmlProcessingAttName		+\(encoding\|href\|version\|type\)\s*=+he=e-1 contained nextgroup=xmlProcessingAttValue
syn match	xmlProcessingAttriValue		+\("[^"]*"\|'[^']*'\)+ contained nextgroup=xmlProcessingAtt
 "}}}

" XML "{{{
syn region	xmlRef start=+&+ end=+;+ keepend containedin=ALL oneline contains=xmlRefDef,xmlRefString,xmlRefNumber
syn match	xmlRefNumber +\(#x[0-9a-fA-F]\{,4}\|#\d\+\)+ contained
syn match	xmlRefString +[a-zA-Z]\++ contained
syn match	xmlRefDef +\<\(amp\|quot\|apos\|lt\|gt\)\>+ contained
 "}}}



" xml comment "{{{
syn region	xmlComment matchgroup=xmlComment start=+<!--+ end=+-->+
	    \ contains=xmlTodo,xmlCommentNotice,xmlCommentErr
	    \ fold extend keepend
syn match	xmlCommentErr +\(--\(>\)\@!\)+ contained
syn match	xmlTodo +\<TODO\>+ contained
syn match	xmlCommentNotice +\(\s\)\@<=:[^:-]*:+ contained
syn region	xmlCdata matchgroup=xmlCdataMark start=+<!\[CDATA\[+ end=+]]>+ keepend fold containedin=@xmlCss
syn region	xmlStyle_cdata matchgroup=xmlCdataMark start=+<!\[CDATA\[+ end=+]]>+ keepend fold contained contains=@xmlCss
syn region	xmlStyle_cdata matchgroup=xmlCdataMark start=+<!\[CDATA\[+ end=+]]>+ keepend fold contained contains=@xmlCss
 "}}}


if exists('b:xsl_include_html')
	" HTML Tag Name {{{
	" -- tag name
	syn match xml_htmlTagName contained +\<\(xmp\)\>+
	syn match xml_htmlTagName contained +\<\(var\)\>+
	syn match xml_htmlTagName contained +\<\(ul\|u\)\>+
	syn match xml_htmlTagName contained +\<\(tt\|tr\|title\|thead\|th\|tfoot\|textarea\|td\|tbody\|table\)\>+
	syn match xml_htmlTagName contained +\<\(sup\|sub\|style\|strong\|strike\|span\|spacer\|small\|select\|script\|samp\|s\)\>+
	syn match xml_htmlTagName contained +\<\(q\)\>+
	syn match xml_htmlTagName contained +\<\(pre\|param\|p\)\>+
	syn match xml_htmlTagName contained +\<\(option\|optgroup\|ol\|object\)\>+
	syn match xml_htmlTagName contained +\<\(noscript\|nolayer\|noframes\|nobr\)\>+
	syn match xml_htmlTagName contained +\<\(meta\|menu\|marquee\|map\)\>+
	syn match xml_htmlTagName contained +\<\(link\|li\|legend\|layer\|label\)\>+
	syn match xml_htmlTagName contained +\<\(kbd\)\>+
	syn match xml_htmlTagName contained +\<\(isindex\|ins\|input\|img\|ilayer\|iframe\|i\)\>+
	syn match xml_htmlTagName contained +\<\(html\|hr\|head\|h[1-6]\)\>+
	syn match xml_htmlTagName contained +\<\(frameset\|frame\|form\|font\|fieldset\)\>+
	syn match xml_htmlTagName contained +\<\(em\)\>+
	syn match xml_htmlTagName contained +\<\(dt\|dl\|div\|dir\|dfn\|del\|dd\)\>+
	syn match xml_htmlTagName contained +\<\(colgroup\|col\|code\|cite\|center\|caption\)\>+
	syn match xml_htmlTagName contained +\<\(button\|br\|body\|blockquote\|blink\|big\|bdo\|basefont\|base\|b\)\>+
	syn match xml_htmlTagName contained +\<\(area\|applet\|address\|acronym\|abbr\|a\)\>+

	" -- att name
	syn match	xml_htmlAttName contained +\<\(wrap\|width\)\>+
	syn match	xml_htmlAttName contained +\<\(vspace\|vlink\|visibility\|version\|valuetype\|value\|valign\)\>+
	syn match	xml_htmlAttName contained +\<\(usemap\|url\)\>+
	syn match	xml_htmlAttName contained +\<\(type\|topmargin\|top\|text\|target\|tabindex\|title\)\>+
	syn match	xml_htmlAttName contained +\<\(summary\|style\|start\|standby\|src\|span\|size\|shape\|selected\|scrolling\|scope\|scheme\)\>+
	syn match	xml_htmlAttName contained +\<\(rules\|rowspan\|rows\|rightmargin\|rev\|rel\|readonly\)\>+
	syn match	xml_htmlAttName contained +\<\(prompt\|profile\|pagey\|pagex\)\>+
	syn match	xml_htmlAttName contained +\<\(object\)\>+
	syn match	xml_htmlAttName contained +\<\(nowrap\|noshade\|noresize\|nohref\|name\)\>+
	syn match	xml_htmlAttName contained +\<\(multiple\|method\|maxlength\|marginwidth\|marginheight\)\>+
	syn match	xml_htmlAttName contained +\<\(lowsrc\|longdesc\|link\|leftmargin\|left\|language\|lang\|label\)\>+
	syn match	xml_htmlAttName contained +\<\(ismap\|id\|id\)\>+
	syn match	xml_htmlAttName contained +\<\(hspace\|hreflang\|height\|headers\)\>+
	syn match	xml_htmlAttName contained +\<\(gutter\)\>+
	syn match	xml_htmlAttName contained +\<\(frameborder\|frame\|for\|face\)\>+
	syn match	xml_htmlAttName contained +\<\(enctype\)\>+
	syn match	xml_htmlAttName contained +\<\(disabled\|dir\|defer\|declare\|datetime\|data\)\>+
	syn match	xml_htmlAttName contained +\<\(coords\|content\|compact\|colspan\|cols\|color\|codetype\|codebase\|code\)\>+
	syn match	xml_htmlAttName contained +\<\(clip\|clear\|classid\|class\|cite\|checked\|charset\|charoff\|char\)\>+
	syn match	xml_htmlAttName contained +\<\(cellspacing\|cellpadding\)\>+
	syn match	xml_htmlAttName contained +\<\(bottommargin\|bordercolor\|border\|bgcolor\|below\|background\)\>+
	syn match	xml_htmlAttName contained +\<\(axis\|archive\|alt\|alink\|align\|action\|accesskey\|accept\|above\|abbr\)\>+

	syn match	xml_htmlAttName contained "\<accept-charset\>"
	syn match	xml_htmlAttName contained "\<z-index\>"
	syn match	xml_htmlAttName contained "\<http-equiv\>"
	" }}}
endif

" CSS "{{{
" include css.vim
if exists('b:xsl_include_css')
	syn include	@xmlCss syntax/css.vim
	unlet b:current_syntax
	"syn cluster	innerCss contains=cssDefinition
	syn cluster	innerCss contains=cssComment,cssLength,cssColor,cssURL,cssImportant,cssError,cssString
	"syn cluster	innerCss contains=css.*Attr,css.*Properties,cssComment,cssLength,cssColor,cssURL,cssImportant,cssError,cssString

	" inner html <style> - </style>
	syn region	cssStyle start=+<style+ keepend end=+</style>+ contains=@xmlSyntax,xmlComment,xmlStyle_cdata,@xmlCss

	" CSS in "style" Attribute Value
	" '='
	syn match	xmlAttEqualStyle +=\_\s*+ contained nextgroup=xmlAttValueStyle skipwhite

	" style value REGION
	syn region	xmlAttValueStyle start=+\z("\)+ keepend end=+\z1\_\s*+
			\ contains=xmlAttInnerCss
			\ nextgroup=xmlTagEnd,xmlAttNameStyle,xmlAttName
			\ skipwhite contained

	" value
	syn match	xmlAttInnerCss +[^"]*+ms=s,me=e-1 contained contains=xmlAttValueErr,stringContXpath,@innerCss
endif
"}}}

" Script {{{
" JavaScript
if exists('b:xsl_include_javascript')
	syn include	@xmlJavaScript syntax/javascript.vim
	unlet b:current_syntax
	syn region	javaScript start=+<\z(\(msxsl:\)\=script\)+
			\ keepend
			\ end=+</\z1\s*>+
			\ contains=@xmlSyntax,xmlComment,javaScript_cdata,@xmlJavaScript
endif

" PerlScript
if exists('b:xsl_include_perl')
	syn include	@xmlPerlScript syntax/perl.vim
	if exists('b:current_syntax')
		unlet b:current_syntax
	endif
	syn region	javaScript
		    \ start=+<\z(\(msxsl:\)\=script\)\_[^>]*language="PerlScript"+
		    \ keepend
		    \ end=+</\z1\s*>+
		    \ contains=@xmlSyntax,xmlComment,perlScript_cdata,@xmlPerlScript
endif


" VBScript
if exists('b:xsl_include_vbs')
	syn include	@xmlVBScript $VIMRUNTIME/syntax/vb.vim
	unlet b:current_syntax
	syn region	javaScript start=+<\z(\(msxsl:\)\=script\)\_[^>]*language="VBScript"+
		    \ keepend
		    \ end=+</\z1\s*>+
		    \ contains=@xmlSyntax,xmlComment,VBScript_cdata,@xmlVBScript
endif

" }}}

syn match	xmlAttValueErr +\(<\|&\([^&'"><]\+;\)\@!\)+ contained

" FOLD "{{{
"
if &foldmethod == "syntax" && &foldenable == 1

    " let b:Xsl_SyntaxFold_by = { "xsl" | "full" | "off" }

	" only <xsl:xxxx .. >
    if exists('b:Xsl_SyntaxFold_by') && b:Xsl_SyntaxFold_by == 'xsl'

		syn region	xmlFold
				\ start=+<\z(\(msxsl\|xsl\):\(stylesheet\>\)\@![^ /!?><"']\+\)\(\_[^><=]\+=\(\_["]\_[^"]*"\|\_[']\_[^']*'\)\)*\_\s*>+
				\ skip=+<!--\_.\{-}-->+
				\ end=+</\z1\s*>+
				\ fold keepend transparent extend
				\ contains=xmlFold,xmlTagStart,cssStyle,javaScript,xmlComment,xmlCdata

	" all Tag
    elseif exists('b:Xsl_SyntaxFold_by') && b:Xsl_SyntaxFold_by == 'full'

		syn region	xmlFold
				\ start=+\(^\)\@!<\z([^ /!?<>"']\+\)+
				\ end=+</\z1\_\s\{-}>+
				\ skip=+<!--\_.\{-}-->+
				\ matchgroup=xmlEndTag end=+/>+
				\ contains=xmlComment,xmlFold,xmlTagStart,cssStyle,javaScript,xmlCdata
				\ fold keepend transparent extend

	"
	elseif exists('b:Xsl_SyntaxFold_by') && b:Xsl_SyntaxFold_by == 'off'

		syn clear xmlFold

	else

		syn region   xmlFold
				\ start=+\(^\)\@!<\z([^ /!?<>"']\+\)+
				\ end=+</\z1\_\s\{-}>+
				\ skip=+<!--\_.\{-}-->+
				\ end=+/>+
				\ contains=xmlComment,xmlFold,xmlTagStart,cssStyle,javaScript,xmlCdata
				\ fold keepend transparent extend

    endif

endif
"}}}

" DTD "{{{
" include dtd.vim
syn region	xmlDocType matchgroup=xmlDocTypeDecl
	\ start="<!DOCTYPE"he=s+2,rs=s+2 end=">"
	\ fold
	\ contains=xmlDocTypeKeyword,xmlInlineDTD,xmlString
syn keyword	xmlDocTypeKeyword contained DOCTYPE PUBLIC SYSTEM
syn region	xmlInlineDTD contained matchgroup=xmlDocTypeDecl start="\[" end="]" contains=@xmlDTD
syn include	@xmlDTD syntax/dtd.vim
unlet b:current_syntax
 "}}}

" SYNC
syn sync match xmlSyncDT grouphere  xmlDocType +\_.\(<!DOCTYPE\)\@=+

if &foldmethod == "syntax" && &foldenable == 1 && b:Xsl_SyntaxFold_by != 'off'
    syn sync match xmlSync grouphere   xmlFold  +\_.\(<[^ /!?<>"']\+\)\@=+
    syn sync match xmlSync groupthere  xmlFold  +</[^ /!?<>"']\+>+
endif

syn sync minlines=100


hi def link xmlTagStart					Special
hi def link xmlElementName				type

hi def link xml_xslElementNameSpace		Special

hi def link xmlTagEnd					Special

hi def link xmlElementName				Structure
hi def link xml_xslElementLocalName		Statement

hi def link xmlAttName					Special
hi def link xmlAttNameHl				Type

hi def link xml_xslAttNameXPath			Type

hi def link xmlRef						Type
hi def link xmlRefString				PreProc
hi def link xmlRefNumber				PreProc
hi def link xmlRefDef					Statement

hi def link xmlProcessing				MoreMsg
hi def link xmlProcessingMark			Identifier
hi def link xmlProcessingElement		Type
hi def link xmlProcessingElementOver	MoreMsg
hi def link xmlProcessingAttName		Identifier
hi def link xmlProcessingAttValue		type

hi def link xmlTodo						Todo
hi def link xmlCommentNotice			PreProc

hi def link xmlString					Normal
hi def link xmlComment					Comment
hi def link xmlCommentErr				Error
hi def link xmlErr						Error
hi def link xmlAttValueErr				Error

hi def link xmlCdataMark				String
hi def link xmlCdata					Normal

hi def link xmlDocTypeDecl				Function
hi def link xmlDocTypeKeyword			Statement
hi def link xmlInlineDTD				Function

"HTML
hi def link xml_htmlTagName				Function
hi def link xml_htmlAttName				Identifier
hi def link xmlAttNameStyle				Define

"XSL
hi def link xml_xslAttNameHl			Exception
hi def link xmlns_xsl					xml_xslAttNameHl
hi def link xpathVariable				Identifier
hi def link xpathFunctionName			Function
hi def link xpathFilterBracket			Identifier
hi def link xpathBracketBracket			Statement
hi def link xpathString					Normal
hi def link xpathOperand				preproc
hi def link xpathAxisName				Special

hi def link xml_xslAttValue				Normal
hi def link xml_xslAttValuexpath		String

hi def link stringContXpathBracket		Statement
hi def link stringContXpath				string

"=
hi def link xmlAttEqual					Type
hi def link xml_xslAttEqual				Type
hi def link xml_xslAttEqualXPath		Type
hi def link xml_schemaAttEqual			Type
hi def link xmlAttEqualStyle			Type


let b:current_syntax = "xsl"

"let &cpo = s:xml_cpo_save
"unlet s:xml_cpo_save

" vim: ts=4:sw=4

endif
