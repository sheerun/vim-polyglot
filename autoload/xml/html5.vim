if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'html5') == -1

" Vim completion for HTML5 data file
" Language:	    HTML (version 5.1 Draft 2016 Jan 13)
" Maintainer:   Kao, Wei-Ko(othree) ( othree AT gmail DOT com )
" Last Change:  2016 Jan 20


" Lang Tag: {{{
" Ref: http://www.iana.org/assignments/language-subtag-registry
" Version: 2010/09/07
" Description: only get two-letter language tag
let lang_tag = [
    \ 'aa', 'ab', 'ae', 'af', 'ak', 'am', 'an', 'ar', 'as', 'av', 'ay', 'az', 'ba', 'be', 'bg', 'bh', 'bi', 'bm',
    \ 'bn', 'bo', 'br', 'bs', 'ca', 'ce', 'ch', 'co', 'cr', 'cs', 'cu', 'cv', 'cy', 'da', 'de', 'dv', 'dz', 'ee',
    \ 'el', 'en', 'eo', 'es', 'et', 'eu', 'fa', 'ff', 'fi', 'fj', 'fo', 'fr', 'fy', 'ga', 'gd', 'gl', 'gn', 'gu',
    \ 'gv', 'ha', 'he', 'hi', 'ho', 'hr', 'ht', 'hu', 'hy', 'hz', 'ia', 'id', 'ie', 'ig', 'ii', 'ik', 'in', 'io',
    \ 'is', 'it', 'iu', 'iw', 'ja', 'ji', 'jv', 'jw', 'ka', 'kg', 'ki', 'kj', 'kk', 'kl', 'km', 'kn', 'ko', 'kr',
    \ 'ks', 'ku', 'kv', 'kw', 'ky', 'la', 'lb', 'lg', 'li', 'ln', 'lo', 'lt', 'lu', 'lv', 'mg', 'mh', 'mi', 'mk',
    \ 'ml', 'mn', 'mo', 'mr', 'ms', 'mt', 'my', 'na', 'nb', 'nd', 'ne', 'ng', 'nl', 'nn', 'no', 'nr', 'nv', 'ny',
    \ 'oc', 'oj', 'om', 'or', 'os', 'pa', 'pi', 'pl', 'ps', 'pt', 'qu', 'rm', 'rn', 'ro', 'ru', 'rw', 'sa', 'sc',
    \ 'sd', 'se', 'sg', 'sh', 'si', 'sk', 'sl', 'sm', 'sn', 'so', 'sq', 'sr', 'ss', 'st', 'su', 'sv', 'sw', 'ta',
    \ 'te', 'tg', 'th', 'ti', 'tk', 'tl', 'tn', 'to', 'tr', 'ts', 'tt', 'tw', 'ty', 'ug', 'uk', 'ur', 'uz', 've',
    \ 'vi', 'vo', 'wa', 'wo', 'xh', 'yi', 'yo', 'za', 'zh', 'zu', 'zh-CN', 'zh-TW']
" }}}

" Charset: {{{
" Ref: http://www.iana.org/assignments/character-sets 
" Version: 2010/09/07
let charset = [
    \ 'ANSI_X3.4-1968', 'ISO_8859-1:1987', 'ISO_8859-2:1987', 'ISO_8859-3:1988', 'ISO_8859-4:1988', 'ISO_8859-5:1988', 
    \ 'ISO_8859-6:1987', 'ISO_8859-7:1987', 'ISO_8859-8:1988', 'ISO_8859-9:1989', 'ISO-8859-10', 'ISO_6937-2-add', 'JIS_X0201', 
    \ 'JIS_Encoding', 'Shift_JIS', 'Extended_UNIX_Code_Packed_Format_for_Japanese', 'Extended_UNIX_Code_Fixed_Width_for_Japanese',
    \ 'BS_4730', 'SEN_850200_C', 'IT', 'ES', 'DIN_66003', 'NS_4551-1', 'NF_Z_62-010', 'ISO-10646-UTF-1', 'ISO_646.basic:1983', 
    \ 'INVARIANT', 'ISO_646.irv:1983', 'NATS-SEFI', 'NATS-SEFI-ADD', 'NATS-DANO', 'NATS-DANO-ADD', 'SEN_850200_B', 'KS_C_5601-1987',
    \ 'ISO-2022-KR', 'EUC-KR', 'ISO-2022-JP', 'ISO-2022-JP-2', 'JIS_C6220-1969-jp', 'JIS_C6220-1969-ro', 'PT', 'greek7-old', 
    \ 'latin-greek', 'NF_Z_62-010_(1973)', 'Latin-greek-1', 'ISO_5427', 'JIS_C6226-1978', 'BS_viewdata', 'INIS', 'INIS-8', 
    \ 'INIS-cyrillic', 'ISO_5427:1981', 'ISO_5428:1980', 'GB_1988-80', 'GB_2312-80', 'NS_4551-2', 'videotex-suppl', 'PT2', 
    \ 'ES2', 'MSZ_7795.3', 'JIS_C6226-1983', 'greek7', 'ASMO_449', 'iso-ir-90', 'JIS_C6229-1984-a', 'JIS_C6229-1984-b', 
    \ 'JIS_C6229-1984-b-add', 'JIS_C6229-1984-hand', 'JIS_C6229-1984-hand-add', 'JIS_C6229-1984-kana', 'ISO_2033-1983', 
    \ 'ANSI_X3.110-1983', 'T.61-7bit', 'T.61-8bit', 'ECMA-cyrillic', 'CSA_Z243.4-1985-1', 'CSA_Z243.4-1985-2', 'CSA_Z243.4-1985-gr', 
    \ 'ISO_8859-6-E', 'ISO_8859-6-I', 'T.101-G2', 'ISO_8859-8-E', 'ISO_8859-8-I', 'CSN_369103', 'JUS_I.B1.002', 'IEC_P27-1', 
    \ 'JUS_I.B1.003-serb', 'JUS_I.B1.003-mac', 'greek-ccitt', 'NC_NC00-10:81', 'ISO_6937-2-25', 'GOST_19768-74', 'ISO_8859-supp', 
    \ 'ISO_10367-box', 'latin-lap', 'JIS_X0212-1990', 'DS_2089', 'us-dk', 'dk-us', 'KSC5636', 'UNICODE-1-1-UTF-7', 'ISO-2022-CN', 
    \ 'ISO-2022-CN-EXT', 'UTF-8', 'ISO-8859-13', 'ISO-8859-14', 'ISO-8859-15', 'ISO-8859-16', 'GBK', 'GB18030', 'OSD_EBCDIC_DF04_15', 
    \ 'OSD_EBCDIC_DF03_IRV', 'OSD_EBCDIC_DF04_1', 'ISO-11548-1', 'KZ-1048', 'ISO-10646-UCS-2', 'ISO-10646-UCS-4', 'ISO-10646-UCS-Basic',
    \ 'ISO-10646-Unicode-Latin1', 'ISO-10646-J-1', 'ISO-Unicode-IBM-1261', 'ISO-Unicode-IBM-1268', 'ISO-Unicode-IBM-1276', 
    \ 'ISO-Unicode-IBM-1264', 'ISO-Unicode-IBM-1265', 'UNICODE-1-1', 'SCSU', 'UTF-7', 'UTF-16BE', 'UTF-16LE', 'UTF-16', 'CESU-8', 
    \ 'UTF-32', 'UTF-32BE', 'UTF-32LE', 'BOCU-1', 'ISO-8859-1-Windows-3.0-Latin-1', 'ISO-8859-1-Windows-3.1-Latin-1', 
    \ 'ISO-8859-2-Windows-Latin-2', 'ISO-8859-9-Windows-Latin-5', 'hp-roman8', 'Adobe-Standard-Encoding', 'Ventura-US', 
    \ 'Ventura-International', 'DEC-MCS', 'IBM850', 'PC8-Danish-Norwegian', 'IBM862', 'PC8-Turkish', 'IBM-Symbols', 'IBM-Thai', 
    \ 'HP-Legal', 'HP-Pi-font', 'HP-Math8', 'Adobe-Symbol-Encoding', 'HP-DeskTop', 'Ventura-Math', 'Microsoft-Publishing', 
    \ 'Windows-31J', 'GB2312', 'Big5', 'macintosh', 'IBM037', 'IBM038', 'IBM273', 'IBM274', 'IBM275', 'IBM277', 'IBM278', 
    \ 'IBM280', 'IBM281', 'IBM284', 'IBM285', 'IBM290', 'IBM297', 'IBM420', 'IBM423', 'IBM424', 'IBM437', 'IBM500', 'IBM851', 
    \ 'IBM852', 'IBM855', 'IBM857', 'IBM860', 'IBM861', 'IBM863', 'IBM864', 'IBM865', 'IBM868', 'IBM869', 'IBM870', 'IBM871', 
    \ 'IBM880', 'IBM891', 'IBM903', 'IBM904', 'IBM905', 'IBM918', 'IBM1026', 'EBCDIC-AT-DE', 'EBCDIC-AT-DE-A', 'EBCDIC-CA-FR', 
    \ 'EBCDIC-DK-NO', 'EBCDIC-DK-NO-A', 'EBCDIC-FI-SE', 'EBCDIC-FI-SE-A', 'EBCDIC-FR', 'EBCDIC-IT', 'EBCDIC-PT', 'EBCDIC-ES', 
    \ 'EBCDIC-ES-A', 'EBCDIC-ES-S', 'EBCDIC-UK', 'EBCDIC-US', 'UNKNOWN-8BIT', 'MNEMONIC', 'MNEM', 'VISCII', 'VIQR', 'KOI8-R', 
    \ 'HZ-GB-2312', 'IBM866', 'IBM775', 'KOI8-U', 'IBM00858', 'IBM00924', 'IBM01140', 'IBM01141', 'IBM01142', 'IBM01143', 
    \ 'IBM01144', 'IBM01145', 'IBM01146', 'IBM01147', 'IBM01148', 'IBM01149', 'Big5-HKSCS', 'IBM1047', 'PTCP154', 'Amiga-1251', 
    \ 'KOI7-switched', 'BRF', 'TSCII', 'windows-1250', 'windows-1251', 'windows-1252', 'windows-1253', 'windows-1254', 'windows-1255', 
    \ 'windows-1256', 'windows-1257', 'windows-1258', 'TIS-620', ]
" }}}

let autofill_tokens = ['on', 'off', 'name', 'honorific-prefix', 'given-name', 'additional-name', 'family-name', 'honorific-suffix', 'nickname', 'organization-title', 'username', 'new-password', 'current-password', 'organization', 'street-address', 'address-line1', 'address-line2', 'address-line3', 'address-level4', 'address-level3', 'address-level2', 'address-level1', 'country', 'country-name', 'postal-code', 'cc-name', 'cc-given-name', 'cc-additional-name', 'cc-family-name', 'cc-number', 'cc-exp', 'cc-exp-month', 'cc-exp-year', 'cc-csc', 'cc-type', 'transaction-currency', 'transaction-amount', 'language', 'bday', 'bday-day', 'bday-month', 'bday-year', 'sex', 'url', 'photo', 'tel', 'tel-country-code', 'tel-national', 'tel-area-code', 'tel-local', 'tel-local-prefix', 'tel-local-suffix', 'tel-extension', 'email', 'impp']

" Attributes_and_Settings: {{{
let core_attributes = {'accesskey': [], 'class': [], 'contenteditable': ['true', 'false', ''], 'contextmenu': [], 'dir': ['ltr', 'rtl'], 'draggable': ['true', 'false'], 'hidden': ['hidden', ''], 'id': [], 'is': [], 'lang': lang_tag, 'spellcheck': ['true', 'false', ''], 'style': [], 'tabindex': [], 'title': []}
let xml_attributes = {'xml:lang': lang_tag, 'xml:space': ['preserve'], 'xml:base': [], 'xmlns': ['http://www.w3.org/1999/xhtml', 'http://www.w3.org/1998/Math/MathML', 'http://www.w3.org/2000/svg', 'http://www.w3.org/1999/xlink']}

let body_attributes = {}
let global_attributes = extend(core_attributes, xml_attributes)
if !exists('g:html5_event_handler_attributes_complete')
    let g:html5_event_handler_attributes_complete = 1
endif

" http://dev.w3.org/html5/spec/Overview.html#attributes-1
let attributes_value = {
    \ 'accept': ['MIME', ''],
    \ 'accept-charset': ['Charset', ''],
    \ 'accesskey': ['Character', ''],
    \ 'action': ['URL', ''],
    \ 'allowfullscreen': ['Bool', ''],
    \ 'allowpaymentrequest': ['Bool', ''],
    \ 'allowpresentation': ['Bool', ''],
    \ 'allowusermedia': ['Bool', ''],
    \ 'alt': ['Text', ''],
    \ 'async': ['Bool', ''],
    \ 'autocomplete': ['*Token', ''],
    \ 'autofocus': ['Bool', ''],
    \ 'autoplay': ['Bool', ''],
    \ 'border': ['1', ''],
    \ 'challenge': ['Text', ''],
    \ 'charset': ['Charset', ''],
    \ 'checked': ['Bool', ''],
    \ 'cite': ['URL', ''],
    \ 'class': ['*Token', ''],
    \ 'cols': ['Int', ''],
    \ 'colspan': ['Int', ''],
    \ 'content': ['Text', ''],
    \ 'contenteditable': ['true/false', ''],
    \ 'contextmenu': ['ID', ''],
    \ 'controls': ['Bool', ''],
    \ 'coords': ['*Int', ''],
    \ 'data': ['URL', ''],
    \ 'datetime': ['Datetime', ''],
    \ 'defer': ['Bool', ''],
    \ 'dir': ['ltr/rtl', ''],
    \ 'disabled': ['Bool', ''],
    \ 'draggable': ['true/false', ''],
    \ 'enctype': ['Token', ''],
    \ 'extends': ['Text', ''],
    \ 'for': ['ID', ''],
    \ 'form': ['ID', ''],
    \ 'formaction': ['URL', ''],
    \ 'formenctype': ['Token', ''],
    \ 'formmethod': ['HTTP Method', ''],
    \ 'formnovalidate': ['Bool', ''],
    \ 'formtarget': ['Name', ''],
    \ 'headers': ['*ID', ''],
    \ 'height': ['Int', ''],
    \ 'hidden': ['Bool', ''],
    \ 'high': ['Number', ''],
    \ 'href': ['URL', ''],
    \ 'hreflang': ['Lang Tag', ''],
    \ 'http-equiv': ['Text', ''],
    \ 'icon': ['URL', ''],
    \ 'id': ['Text', ''],
    \ 'ismap': ['Bool', ''],
    \ 'keytype': ['Text', ''],
    \ 'label': ['Text', ''],
    \ 'lang': ['Lang Tag', ''],
    \ 'list': ['ID', ''],
    \ 'loop': ['Bool', ''],
    \ 'low': ['Number', ''],
    \ 'manifest': ['URL', ''],
    \ 'max': ['Number', ''],
    \ 'maxlength': ['Int', ''],
    \ 'media': ['Text', ''],
    \ 'method': ['HTTP Method', ''],
    \ 'min': ['Number', ''],
    \ 'multiple': ['Bool', ''],
    \ 'name': ['Text', ''],
    \ 'novalidate': ['Bool', ''],
    \ 'open': ['Bool', ''],
    \ 'optimum': ['Number', ''],
    \ 'pattern': ['Pattern', ''],
    \ 'placeholder': ['Text', ''],
    \ 'playsinline': ['Bool', ''],
    \ 'poster': ['URL', ''],
    \ 'preload': ['Token', ''],
    \ 'pubdate': ['Bool', ''],
    \ 'radiogroup': ['Text', ''],
    \ 'readonly': ['Bool', ''],
    \ 'rel': ['*Token', ''],
    \ 'required': ['Bool', ''],
    \ 'reversed': ['Bool', ''],
    \ 'rows': ['Int', ''],
    \ 'rowspan': ['Int', ''],
    \ 'sandbox': ['*Token', ''],
    \ 'spellcheck': ['true/false', ''],
    \ 'scope': ['Token', ''],
    \ 'scoped': ['Bool', ''],
    \ 'seamless': ['Bool', ''],
    \ 'select': ['Text', ''],
    \ 'selected': ['Bool', ''],
    \ 'shape': ['Token', ''],
    \ 'size': ['Int', ''],
    \ 'sizes': ['*Token', ''],
    \ 'span': ['Int', ''],
    \ 'src': ['Int', ''],
    \ 'srcdoc': ['Document', ''],
    \ 'start': ['Int', ''],
    \ 'step': ['Int', ''],
    \ 'style': ['Style', ''],
    \ 'summary': ['Text', ''],
    \ 'tabindex': ['Int', ''],
    \ 'target': ['Name', ''],
    \ 'title': ['Text', ''],
    \ 'type': ['Token', ''],
    \ 'usemap': ['Name', ''],
    \ 'value': ['Text', ''],
    \ 'width': ['Int', ''],
    \ 'wrap': ['soft/hard', ''],
    \ 'xml:lang': ['Lang tag', ''],
    \ 'xml:base': ['*URI', ''],
    \ 'xml:space': ['preserve', ''],
    \ 'xmlns': ['URI', ''],
    \ 'version': ['HTML+RDFa 1.1', ''],
    \ 'role': ['*Token', '']
\ }

if g:html5_event_handler_attributes_complete == 1
    let event_handler_attributes = {'onabort': [], 'onblur': [], 'oncanplay': [], 'oncanplaythrough': [], 'onchange': [], 'onclick': [], 'oncontextmenu': [], 'ondblclick': [], 'ondrag': [], 'ondragend': [], 'ondragenter': [], 'ondragleave': [], 'ondragover': [], 'ondragstart': [], 'ondrop': [], 'ondurationchange': [], 'onemptied': [], 'onended': [], 'onerror': [], 'onfocus': [], 'onformchange': [], 'onforminput': [], 'oninput': [], 'oninvalid': [], 'onkeydown': [], 'onkeypress': [], 'onkeyup': [], 'onload': [], 'onloadeddata': [], 'onloadedmetadata': [], 'onloadstart': [], 'onmousedown': [], 'onmousemove': [], 'onmouseout': [], 'onmouseover': [], 'onmouseup': [], 'onmousewheel': [], 'onpause': [], 'onplay': [], 'onplaying': [], 'onprogress': [], 'onratechange': [], 'onreadystatechange': [], 'onscroll': [], 'onseeked': [], 'onseeking': [], 'onselect': [], 'onshow': [], 'onstalled': [], 'onsubmit': [], 'onsuspend': [], 'ontimeupdate': [], 'onvolumechange': [], 'onwaiting': [], 'onselectstart': [], 'onselectchange': []}
    let global_attributes = extend(global_attributes, event_handler_attributes)
    
    let body_attributes = {'onafterprint': [], 'onbeforeprint': [], 'onbeforeunload': [], 'onblur': [], 'onerror': [], 'onfocus': [], 'onhashchange': [], 'onload': [], 'onmessage': [], 'onoffline': [], 'ononline': [], 'onpopstate': [], 'onredo': [], 'onresize': [], 'onstorage': [], 'onundo': [], 'onunload': []}

    let event_attributes_value = {
        \ 'onabort': ['Script', ''],
        \ 'onafterprint': ['Script', ''],
        \ 'onbeforeprint': ['Script', ''],
        \ 'onbeforeunload': ['Script', ''],
        \ 'onblur': ['Script', ''],
        \ 'oncanplay': ['Script', ''],
        \ 'oncanplaythrough': ['Script', ''],
        \ 'onchange': ['Script', ''],
        \ 'onclick': ['Script', ''],
        \ 'oncontextmenu': ['Script', ''],
        \ 'ondblclick': ['Script', ''],
        \ 'ondrag': ['Script', ''],
        \ 'ondragend': ['Script', ''],
        \ 'ondragenter': ['Script', ''],
        \ 'ondragleave': ['Script', ''],
        \ 'ondragover': ['Script', ''],
        \ 'ondragstart': ['Script', ''],
        \ 'onselectstart': ['Script', ''],
        \ 'onselectchange': ['Script', ''],
        \ 'ondrop': ['Script', ''],
        \ 'ondurationchange': ['Script', ''],
        \ 'onemptied': ['Script', ''],
        \ 'onended': ['Script', ''],
        \ 'onerror': ['Script', ''],
        \ 'onfocus': ['Script', ''],
        \ 'onformchange': ['Script', ''],
        \ 'onforminput': ['Script', ''],
        \ 'onhashchange': ['Script', ''],
        \ 'oninput': ['Script', ''],
        \ 'oninvalid': ['Script', ''],
        \ 'onkeydown': ['Script', ''],
        \ 'onkeypress': ['Script', ''],
        \ 'onkeyup': ['Script', ''],
        \ 'onload': ['Script', ''],
        \ 'onloadeddata': ['Script', ''],
        \ 'onloadedmetadata': ['Script', ''],
        \ 'onloadstart': ['Script', ''],
        \ 'onmessage': ['Script', ''],
        \ 'onmousedown': ['Script', ''],
        \ 'onmousemove': ['Script', ''],
        \ 'onmouseout': ['Script', ''],
        \ 'onmouseover': ['Script', ''],
        \ 'onmouseup': ['Script', ''],
        \ 'onmousewheel': ['Script', ''],
        \ 'onoffline': ['Script', ''],
        \ 'ononline': ['Script', ''],
        \ 'onpagehide': ['Script', ''],
        \ 'onpageshow': ['Script', ''],
        \ 'onpause': ['Script', ''],
        \ 'onplay': ['Script', ''],
        \ 'onplaying': ['Script', ''],
        \ 'onpopstate': ['Script', ''],
        \ 'onprogress': ['Script', ''],
        \ 'onratechange': ['Script', ''],
        \ 'onreadystatechange': ['Script', ''],
        \ 'onredo': ['Script', ''],
        \ 'onresize': ['Script', ''],
        \ 'onscroll': ['Script', ''],
        \ 'onseeked': ['Script', ''],
        \ 'onseeking': ['Script', ''],
        \ 'onselect': ['Script', ''],
        \ 'onshow': ['Script', ''],
        \ 'onstalled': ['Script', ''],
        \ 'onstorage': ['Script', ''],
        \ 'onsubmit': ['Script', ''],
        \ 'onsuspend': ['Script', ''],
        \ 'ontimeupdate': ['Script', ''],
        \ 'onundo': ['Script', ''],
        \ 'onunload': ['Script', ''],
        \ 'onvolumechange': ['Script', ''],
        \ 'onwaiting': ['Script', '']
    \ }

    let attributes_value = extend(attributes_value, event_attributes_value)
endif
if !exists('g:html5_rdfa_attributes_complete')
    let g:html5_rdfa_attributes_complete = 1
endif
if g:html5_rdfa_attributes_complete == 1
    " http://www.w3.org/TR/rdfa-syntax/#s_metaAttributes
    " http://www.w3.org/TR/rdfa-core/#s_syntax
    let relrev = ['chapter', 'contents', 'copyright', 'first', 'glossary', 'help', 'icon', 'index', 'last', 'license', 'meta', 'next', 'p3pv1', 'prev', 'role', 'section', 'stylesheet', 'subsection', 'start', 'top', 'up']
    let rdfa_attributes = {'about': [], 'content': [], 'datatype': [], 'prefix': [], 'profile': [], 'property': [], 'resource': [], 'rel': relrev, 'rev': relrev, 'typeof': [], 'vocab': []}
    let global_attributes = extend(global_attributes, rdfa_attributes)

    let rdfa_attributes_value = {
        \ 'about': ['SafeCURIEorCURIEorURI', ''],
        \ 'content': ['CDATA String', ''],
        \ 'datatype': ['CURIE', ''],
        \ 'prefix': ['*Prefix', ''],
        \ 'profile': ['String', ''],
        \ 'property': ['*TERMorCURIEorAbsURIs', ''],
        \ 'resource': ['URIorSafeCURIE', ''],
        \ 'rel': ['*TERMorCURIEorAbsURIs', ''],
        \ 'rev': ['*TERMorCURIEorAbsURIs', ''],
        \ 'typeof': ['*TERMorCURIEorAbsURIs', ''],
        \ 'vocab': ['URI', '']
    \ }
    let attributes_value = extend(attributes_value, rdfa_attributes_value)
endif
if !exists('g:html5_microdata_attributes_complete')
    let g:html5_microdata_attributes_complete = 1
endif
if g:html5_microdata_attributes_complete == 1
    let microdata_attributes = {'itemid': [], 'itemscope': ['itemscope', ''], 'itemtype': [], 'itemprop': [], 'itemref': []}
    let global_attributes = extend(global_attributes, microdata_attributes)

    let microdata_attributes_value = {
        \ 'itemid': ['URI', ''],
        \ 'itemscope': ['Bool', ''],
        \ 'itemtype': ['URI', ''],
        \ 'itemprop': ['String', ''],
        \ 'itemref': ['*ID', '']
    \ }
    let attributes_value = extend(attributes_value, microdata_attributes_value)
endif
" }}}

" WAI_ARIA: {{{
" Ref: http://www.w3.org/TR/wai-aria/
" Version: Draft 15 December 2009
if !exists('g:html5_aria_attributes_complete')
    let g:html5_aria_attributes_complete = 1
endif
if g:html5_aria_attributes_complete == 1
    " Ref: https://www.w3.org/TR/wai-aria-1.1/#role_definitions
    " Version: W3C Candidate Recommendation 27 October 2016
    let widget_role = ['alert', 'alertdialog', 'button', 'checkbox', 'combobox', 'dialog', 'gridcell', 'link', 'log', 'marquee', 'menuitem', 'menuitemcheckbox', 'menuitemradio', 'option', 'progressbar', 'radio', 'radiogroup', 'scrollbar', 'searchbox', 'slider', 'spinbutton', 'status', 'switch', 'tab', 'tabpanel', 'textbox', 'timer', 'tooltip', 'treeitem', 'combobox', 'grid', 'listbox', 'menu', 'menubar', 'radiogroup', 'tablist', 'tree', 'treegrid']
    let document_structure = ['article', 'cell', 'columnheader', 'definition', 'directory', 'document', 'feed', 'figure', 'group', 'heading', 'img', 'list', 'listitem', 'math', 'none', 'note', 'presentation', 'region', 'row', 'rowheader', 'separator', 'table', 'term']
    let landmark_role = ['application', 'banner', 'complementary', 'contentinfo', 'form', 'main', 'navigation', 'search']
    let dpub_role = ['dpub-abstract', 'dpub-afterword', 'dpub-appendix', 'dpub-biblioentry', 'dpub-bibliography', 'dpub-biblioref', 'dpub-chapter', 'dpub-cover', 'dpub-epilogue', 'dpub-footnote', 'dpub-footnotes', 'dpub-foreword', 'dpub-glossary', 'dpub-glossdef', 'dpub-glossref', 'dpub-glossterm', 'dpub-index', 'dpub-locator', 'dpub-noteref', 'dpub-notice', 'dpub-pagebreak', 'dpub-pagelist', 'dpub-part', 'dpub-preface', 'dpub-prologue', 'dpub-pullquote', 'dpub-qna', 'dpub-subtitle', 'dpub-tip', 'dpub-title', 'dpub-toc']
    let role = extend(widget_role, document_structure)
    let role = extend(role, landmark_role)
    let role = extend(role, dpub_role)
    let global_attributes = extend(global_attributes, {'role': role})
endif
" }}}

" Ref: http://dev.w3.org/html5/markup/
" Version: Draft 05 April 2011
let phrasing_elements = ['a', 'em', 'strong', 'small', 'mark', 'abbr', 'dfn', 'i', 'b', 'u', 'code', 'var', 'samp', 'kbd', 'sup', 'sub', 'q', 'cite', 'span', 'bdo', 'bdi', 'br', 'wbr', 'ins', 'del', 'img', 'picture', 'embed', 'object', 'iframe', 'map', 'area', 'script', 'noscript', 'ruby', 'video', 'audio', 'input', 'textarea', 'select', 'button', 'label', 'output', 'datalist', 'keygen', 'progress', 'command', 'canvas', 'time', 'meter', 'data', 'content', 'shadow']

let metadata_elements = ['link', 'style', 'meta', 'script', 'noscript', 'command']

let flow_elements = phrasing_elements + ['p', 'hr', 'pre', 'ul', 'ol', 'dl', 'div', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'hgroup', 'address', 'blockquote', 'ins', 'del', 'element', 'object', 'main', 'map', 'noscript', 'section', 'nav', 'article', 'aside', 'header', 'footer', 'video', 'audio', 'figure', 'table', 'template', 'form', 'fieldset', 'menu', 'canvas', 'details']

" https://html.spec.whatwg.org/#linkTypes
let linktypes = ['alternate', 'author', 'bookmark', 'dns-prefetch', 'external', 'help', 'icon', 'license', 'next', 'nofollow', 'noreferrer', 'noopener', 'pingback', 'preconnect', 'prefetch', 'preload', 'prerender', 'prev', 'search', 'stylesheet', 'tag']
" https://w3c.github.io/manifest/
let linkreltypes = linktypes
let linkreltypes = linkreltypes + ['manifest']
" http://googlewebmastercentral.blogspot.com/2009/02/specify-your-canonical.html
" http://www.ysearchblog.com/2009/02/12/fighting-duplication-adding-more-arrows-to-your-quiver/
" http://blogs.bing.com/webmaster/2009/02/12/partnering-to-help-solve-duplicate-content-issues
let linkreltypes = linkreltypes + ['canonical']
" http://w3c.github.io/webcomponents/spec/imports/
let linkreltypes = linkreltypes + ['import']
" https://www.w3.org/TR/webmention/#sender-discovers-receiver-webmention-endpoint
let linkreltypes = linkreltypes + ['webmention']
" http://www.opensearch.org/Specifications/OpenSearch/1.1#Autodiscovery_in_HTML.2FXHTML
let linkreltypes = linkreltypes + ['search']
" http://microformats.org/wiki/rel-sitemap
let linkreltypes = linkreltypes + ['sitemap']
" https://www.ampproject.org/docs/get_started/create/prepare_for_discovery
let linkreltypes = linkreltypes + ['amphtml']
" https://developer.apple.com/library/content/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html
let linkreltypes = linkreltypes + ['apple-touch-icon', 'apple-touch-icon-precomposed', 'apple-touch-startup-image']
" https://developer.chrome.com/webstore/inline_installation
let linkreltypes = linkreltypes + ['chrome-webstore-item']
" http://pubsubhubbub.github.io/PubSubHubbub/pubsubhubbub-core-0.4.html#rfc.section.4
let linkreltypes = linkreltypes + ['hub']
" https://golem.ph.utexas.edu/~distler/blog/archives/000320.html
let linkreltypes = linkreltypes + ['pgpkey']

" a and button are special elements for interactive, some element can't be its descendent
let abutton_dec = 'details\\|embed\\|iframe\\|keygen\\|label\\|menu\\|select\\|textarea'

let crossorigin = ['anonymous', 'use-credentials']

let referrerpolicy = ['no-referrer', 'no-referrer-when-downgrade', 'same-origin', 'origin', 'strict-origin', 'origin-when-cross-origin', 'strict-origin-when-cross-origin', 'unsafe-url']


let g:xmldata_html5 = {
\ 'vimxmlentities': ['AElig', 'Aacute', 'Acirc', 'Agrave', 'Alpha', 'Aring', 'Atilde', 'Auml', 'Beta', 'Ccedil', 'Chi', 'Dagger', 'Delta', 'ETH', 'Eacute', 'Ecirc', 'Egrave', 'Epsilon', 'Eta', 'Euml', 'Gamma', 'Iacute', 'Icirc', 'Igrave', 'Iota', 'Iuml', 'Kappa', 'Lambda', 'Mu', 'Ntilde', 'Nu', 'OElig', 'Oacute', 'Ocirc', 'Ograve', 'Omega', 'Omicron', 'Oslash', 'Otilde', 'Ouml', 'Phi', 'Pi', 'Prime', 'Psi', 'Rho', 'Scaron', 'Sigma', 'THORN', 'Tau', 'Theta', 'Uacute', 'Ucirc', 'Ugrave', 'Upsilon', 'Uuml', 'Xi', 'Yacute', 'Yuml', 'Zeta', 'aacute', 'acirc', 'acute', 'aelig', 'agrave', 'alefsym', 'alpha', 'amp', 'and', 'ang', 'apos', 'aring', 'asymp', 'atilde', 'auml', 'bdquo', 'beta', 'brvbar', 'bull', 'cap', 'ccedil', 'cedil', 'cent', 'chi', 'circ', 'clubs', 'cong', 'copy', 'crarr', 'cup', 'curren', 'dArr', 'dagger', 'darr', 'deg', 'delta', 'diams', 'divide', 'eacute', 'ecirc', 'egrave', 'empty', 'emsp', 'ensp', 'epsilon', 'equiv', 'eta', 'eth', 'euml', 'euro', 'exist', 'fnof', 'forall', 'frac12', 'frac14', 'frac34', 'frasl', 'gamma', 'ge', 'gt', 'hArr', 'harr', 'hearts', 'hellip', 'iacute', 'icirc', 'iexcl', 'igrave', 'image', 'infin', 'int', 'iota', 'iquest', 'isin', 'iuml', 'kappa', 'lArr', 'lambda', 'lang', 'laquo', 'larr', 'lceil', 'ldquo', 'le', 'lfloor', 'lowast', 'loz', 'lrm', 'lsaquo', 'lsquo', 'lt', 'macr', 'mdash', 'micro', 'middot', 'minus', 'mu', 'nabla', 'nbsp', 'ndash', 'ne', 'ni', 'not', 'notin', 'nsub', 'ntilde', 'nu', 'oacute', 'ocirc', 'oelig', 'ograve', 'oline', 'omega', 'omicron', 'oplus', 'or', 'ordf', 'ordm', 'oslash', 'otilde', 'otimes', 'ouml', 'para', 'part', 'permil', 'perp', 'phi', 'pi', 'piv', 'plusmn', 'pound', 'prime', 'prod', 'prop', 'psi', 'quot', 'rArr', 'radic', 'rang', 'raquo', 'rarr', 'rceil', 'rdquo', 'real', 'reg', 'rfloor', 'rho', 'rlm', 'rsaquo', 'rsquo', 'sbquo', 'scaron', 'sdot', 'sect', 'shy', 'sigma', 'sigmaf', 'sim', 'spades', 'sub', 'sube', 'sum', 'sup', 'sup1', 'sup2', 'sup3', 'supe', 'szlig', 'tau', 'there4', 'theta', 'thetasym', 'thinsp', 'thorn', 'tilde', 'times', 'trade', 'uArr', 'uacute', 'uarr', 'ucirc', 'ugrave', 'uml', 'upsih', 'upsilon', 'uuml', 'weierp', 'xi', 'yacute', 'yen', 'yuml', 'zeta', 'zwj', 'zwnj'],
\ 'vimxmlroot': ['html', 'head', 'body'] + flow_elements, 
\ 'a': [
    \ filter(copy(flow_elements), "!(v:val =~ '". abutton_dec ."')"),
    \ extend(copy(global_attributes), {'name': [], 'href': [], 'target': [], 'rel': linktypes, 'hreflang': lang_tag, 'media': [], 'type': [], 'referrerpolicy': ['no-referrer', 'no-referrer-when-downgrade', 'origin', 'origin-when-cross-origin', 'unsafe-url']}) 
\ ],
\ 'abbr': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'address': [
    \ filter(copy(flow_elements), "!(v:val =~ 'address\\|nav\\|article\\|header\\|footer\\|section\\|aside\\|h1\\|h2\\|h3\\|h4\\|h5\\|h6')"),
    \ global_attributes
\ ],
\ 'area': [
    \ [],
    \ extend(copy(global_attributes), {'alt': [], 'href': [], 'target': [], 'rel': linktypes, 'media': [], 'hreflang': lang_tag, 'type': [], 'shape': ['rect', 'circle', 'poly', 'default'], 'coords': [], 'referrerpolicy': referrerpolicy})
\ ],
\ 'article': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'aside': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'audio': [
    \ flow_elements + ['source', 'track'],
    \ extend(copy(global_attributes), {'autoplay': ['autoplay', ''], 'preload': ['none', 'metadata', 'auto', ''], 'controls': ['controls', ''], 'loop': ['loop', ''], 'src': []})
\ ],
\ 'b': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'base': [
    \ [],
    \ extend(copy(global_attributes), {'href': [], 'target': []})
\ ],
\ 'bdo': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'bdi': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'blockquote': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'cite': []})
\ ],
\ 'body': [
    \ flow_elements,
    \ extend(copy(global_attributes), body_attributes)
\ ],
\ 'br': [
    \ [],
    \ global_attributes
\ ],
\ 'button': [
    \ filter(copy(phrasing_elements), "!(v:val =~ '". abutton_dec ."')"),
    \ extend(copy(global_attributes), {'type': ['submit', 'reset', 'button'], 'name': [], 'disabled': ['disabled', ''], 'form': [], 'value': [], 'formaction': [], 'autofocus': ['autofocus', ''], 'formenctype': ['application/x-www-form-urlencoded', 'multipart/form-data', 'text/plain'], 'formmethod': ['get', 'post', 'put', 'delete'], 'formtarget': [], 'formnovalidate': ['formnovalidate', '']})
\ ],
\ 'canvas': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'height': [], 'width': []})
\ ],
\ 'caption': [
    \ filter(copy(flow_elements), "!(v:val =~ 'table')"),
    \ global_attributes
\ ],
\ 'cite': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'code': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'col': [
    \ [],
    \ extend(copy(global_attributes), {'span': []})
\ ],
\ 'colgroup': [
    \ [],
    \ extend(copy(global_attributes), {'span': []})
\ ],
\ 'content': [
    \ [],
    \ extend(copy(global_attributes), {'select': []})
\ ],
\ 'command': [
    \ ['col'],
    \ extend(copy(global_attributes), {'type': ['command', 'radio', 'checkbox'], 'radiogroup': [], 'checked': ['checked', ''], 'label': [], 'icon': [], 'disabled': ['disabled', '']})
\ ],
\ 'datalist': [
    \ phrasing_elements + ['option'],
    \ global_attributes
\ ],
\ 'dd': [
    \ flow_elements,
    \ global_attributes
\ ],
\ 'del': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'cite': [], 'datetime': []})
\ ],
\ 'details': [
    \ flow_elements + ['summary'],
    \ extend(copy(global_attributes), {'open': ['open', '']})
\ ],
\ 'dfn': [
    \ filter(copy(phrasing_elements), "!(v:val =~ 'dfn')"),
    \ global_attributes
\ ],
\ 'dialog': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'open': []})
\ ],
\ 'div': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'dl': [
    \ ['dt', 'dd'],
    \ global_attributes
\ ],
\ 'dt': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'em': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'embed': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'type': [], 'height': [], 'width': []})
\ ],
\ 'fieldset': [
    \ flow_elements + ['legend'],
    \ extend(copy(global_attributes), {'name': [], 'disabled': ['disabled', ''], 'form': []})
\ ],
\ 'figcaption': [
    \ flow_elements,
    \ global_attributes
\ ],
\ 'figure': [
    \ flow_elements + ['figcaption'],
    \ global_attributes
\ ],
\ 'footer': [
    \ filter(copy(flow_elements), "!(v:val =~ 'address\\|header\\|footer')"),
    \ global_attributes
\ ],
\ 'form': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'name': [], 'action': [], 'enctype': ['application/x-www-form-urlencoded', 'multipart/form-data', 'text/plain'], 'method': ['get', 'post', 'put', 'delete'], 'target': [], 'novalidate': ['novalidate', ''], 'accept-charset': charset, 'autocomplete': autofill_tokens})
\ ],
\ 'h1': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h2': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h3': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h4': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h5': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h6': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'head': [
    \ metadata_elements + ['title', 'base'],
    \ global_attributes
\ ],
\ 'header': [
    \ filter(copy(flow_elements), "!(v:val =~ 'address\\|header\\|footer')"),
    \ global_attributes
\ ],
\ 'hgroup': [
    \ ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'],
    \ global_attributes
\ ],
\ 'hr': [
    \ [],
    \ global_attributes
\ ],
\ 'html': [
    \ ['head', 'body'],
    \ extend(copy(global_attributes), {'manifest': [], 'version': ['HTML+RDFa 1.1']})
\ ],
\ 'i': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'iframe': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'srcdoc': [], 'name': [], 'width': [], 'height': [], 'sandbox': ['allow-same-origin', 'allow-forms', 'allow-scripts'], 'seamless': ['seamless', ''], 'referrerpolicy': referrerpolicy, 'allowfullscreen': [], 'allowpaymentrequest': [], 'allowpresentation': [], 'allowusermedia': []})
\ ],
\ 'img': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'alt': [], 'height': [], 'width': [], 'decoding': ['async', 'sync', 'auto'], 'usemap': [], 'ismap': ['ismap', ''], 'referrerpolicy': referrerpolicy, 'crossorigin': ['anonymous', 'use-credentials']})
\ ],
\ 'input': [
    \ [],
    \ extend(copy(global_attributes), {'type': ['text', 'password', 'checkbox', 'radio', 'button', 'submit', 'reset', 'file', 'hidden', 'image', 'datetime-local', 'date', 'month', 'time', 'week', 'number', 'range', 'email', 'url', 'search', 'tel', 'color'], 'name': [], 'disabled': ['disabled', ''], 'form': [], 'maxlength': [], 'readonly': ['readonly', ''], 'size': [], 'value': [], 'autocomplete': autofill_tokens, 'autofocus': ['autofocus', ''], 'list': [], 'pattern': [], 'required': ['required', ''], 'placeholder': [], 'checked': ['checked'], 'accept': [], 'multiple': ['multiple', ''], 'alt': [], 'src': [], 'height': [], 'width': [], 'min': [], 'max': [], 'step': [], 'formenctype': ['application/x-www-form-urlencoded', 'multipart/form-data', 'text/plain'], 'formmethod': ['get', 'post', 'put', 'delete'], 'formtarget': [], 'formnovalidate': ['formnovalidate', '']})
\ ],
\ 'ins': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'cite': [], 'datetime': []})
\ ],
\ 'kbd': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'keygen': [
    \ [],
    \ extend(copy(global_attributes), {'challenge': [], 'keytype': ['rsa'], 'autofocus': ['autofocus', ''], 'name': [], 'disabled': ['disabled', ''], 'form': []})
\ ],
\ 'label': [
    \ filter(copy(phrasing_elements), "!(v:val =~ 'label')"),
    \ extend(copy(global_attributes), {'for': [], 'form': []})
\ ],
\ 'legend': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'li': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'value': []})
\ ],
\ 'link': [
    \ [],
    \ extend(copy(global_attributes), {'href': [], 'rel': linkreltypes, 'hreflang': lang_tag, 'media': [], 'type': [], 'sizes': ['any'], 'referrerpolicy': referrerpolicy, 'crossorigin': crossorigin, 'preload': ['preload', ''], 'prefetch': ['prefetch', ''], 'as': ['report', 'document', 'document', 'object', 'embed', 'audio', 'font', 'image', 'audioworklet', 'paintworklet', 'script', 'serviceworker', 'sharedworker', 'worker', 'style', 'track', 'video', 'image', 'manifest', 'xslt', 'fetch', '']})
\ ],
\ 'main': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'map': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'name': []})
\ ],
\ 'mark': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'menu': [
    \ flow_elements + ['menuitem'],
    \ extend(copy(global_attributes), {'type': ['toolbar', 'context'], 'label': []})
\ ],
\ 'menuitem': [
    \ flow_elements + ['li'],
    \ extend(copy(global_attributes), {'type': ['toolbar', 'context'], 'label': [], 'icon': [], 'disabled': [], 'checked': [], 'radiogroup': [], 'default': [], 'command': []})
\ ],
\ 'meta': [
    \ [],
    \ extend(copy(global_attributes), {'name': ['application-name', 'author', 'description', 'generator', 'referrer', 'creator', 'googlebot', 'publisher', 'robots', 'slurp', 'viewport', 'theme-color'], 'http-equiv': ['refresh', 'default-style', 'content-type'], 'content': [], 'charset': charset})
\ ],
\ 'meter': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'value': [], 'min': [], 'low': [], 'high': [], 'max': [], 'optimum': []})
\ ],
\ 'nav': [
    \ flow_elements,
    \ global_attributes
\ ],
\ 'noscript': [
    \ flow_elements + ['link', 'meta', 'style'],
    \ global_attributes
\ ],
\ 'object': [
    \ flow_elements + ['param'],
    \ extend(copy(global_attributes), {'data': [], 'type': [], 'height': [], 'width': [], 'usemap': [], 'name': [], 'form': []})
\ ],
\ 'ol': [
    \ ['li'],
    \ extend(copy(global_attributes), {'start': [], 'reversed': ['reversed', '']})
\ ],
\ 'optgroup': [
    \ ['option'],
    \ extend(copy(global_attributes), {'label': [], 'disabled': ['disabled', '']})
\ ],
\ 'option': [
    \ [''],
    \ extend(copy(global_attributes), {'disabled': ['disabled', ''], 'selected': ['selected', ''], 'label': [], 'value': []})
\ ],
\ 'output': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'name': [], 'form': [], 'for': []})
\ ],
\ 'p': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'param': [
    \ [],
    \ extend(copy(global_attributes), {'name': [], 'value': []})
\ ],
\ 'picture': [
    \ flow_elements + ['source'],
    \ global_attributes
\ ],
\ 'pre': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'progress': [
    \ filter(copy(phrasing_elements), "!(v:val =~ 'progress')"),
    \ extend(copy(global_attributes), {'value': [], 'max': []})
\ ],
\ 'q': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'cite': []})
\ ],
\ 'rb': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'rp': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'rt': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'rtc': [
    \ phrasing_elements + ['rp', 'rt'],
    \ global_attributes
\ ],
\ 'ruby': [
    \ phrasing_elements + ['rb', 'rp', 'rt', 'rtc'],
    \ global_attributes
\ ],
\ 'samp': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'script': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'defer': ['defer', ''], 'async': ['async', ''], 'type': [], 'charset': charset, 'nonce': [], 'crossorigin': crossorigin})
\ ],
\ 'section': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'select': [
    \ ['optgroup', 'option'],
    \ extend(copy(global_attributes), {'name': [], 'disabled': ['disabled', ''], 'form': [], 'size': [], 'multiple': ['multiple', '']})
\ ],
\ 'shadow': [
    \ [],
    \ global_attributes
\ ],
\ 'small': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'source': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'type': [], 'media': [], 'srcset': [], 'sizes': []})
\ ],
\ 'span': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'strong': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'style': [
    \ [],
    \ extend(copy(global_attributes), {'type': [], 'media': [], 'scoped': ['scoped', ''], 'nonce': []})
\ ],
\ 'sub': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'summary': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'sup': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'table': [
    \ ['caption', 'col', 'colgroup', 'thead', 'tfoot', 'tbody', 'tr'],
    \ extend(copy(global_attributes), {'border': []})
\ ],
\ 'tbody': [
    \ ['tr'],
    \ global_attributes
\ ],
\ 'td': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'colspan': [], 'rowspan': [], 'headers': []})
\ ],
\ 'template': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'textarea': [
    \ [''],
    \ extend(copy(global_attributes), {'name': [], 'disabled': ['disabled', ''], 'form': [], 'readonly': ['readonly', ''], 'maxlength': [], 'autofocus': ['autofocus', ''], 'required': ['required', ''], 'placeholder': [], 'rows': [], 'wrap': ['hard', 'soft'], 'cols': []})
\ ],
\ 'tfoot': [
    \ ['tr'],
    \ global_attributes
\ ],
\ 'th': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'scope': ['row', 'col', 'rowgroup', 'colgroup'], 'colspan': [], 'rowspan': [], 'headers': []})
\ ],
\ 'thead': [
    \ ['tr'],
    \ global_attributes
\ ],
\ 'time': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'datetime': [], 'pubdate': ['pubdate', '']})
\ ],
\ 'data': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'value': []})
\ ],
\ 'title': [
    \ [''],
    \ global_attributes
\ ],
\ 'tr': [
    \ ['th', 'td'],
    \ global_attributes
\ ],
\ 'track': [
    \ [],
    \ extend(copy(global_attributes), {'kind': ['subtitles', 'captions', 'descriptions', 'chapters', 'metadata'], 'src': [], 'charset': charset, 'srclang': lang_tag, 'label': []})
\ ],
\ 'u': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'ul': [
    \ ['li'],
    \ global_attributes
\ ],
\ 'var': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'video': [
    \ flow_elements + ['source', 'track'],
    \ extend(copy(global_attributes), {'autoplay': ['autoplay', ''], 'preload': ['none', 'metadata', 'auto', ''], 'controls': ['controls', ''], 'loop': ['loop', ''], 'playsinline': ['playsinline', ''], 'poster': [], 'height': [], 'width': [], 'src': [], 'crossorigin': crossorigin})
\ ],
\ 'wbr': [
    \ [],
    \ global_attributes
\ ],
\ 'vimxmlattrinfo' : attributes_value,
\ 'vimxmltaginfo': {
    \ 'area': ['/>', ''],
    \ 'base': ['/>', ''],
    \ 'br': ['/>', ''],
    \ 'col': ['/>', ''],
    \ 'command': ['/>', ''],
    \ 'embed': ['/>', ''],
    \ 'hr': ['/>', ''],
    \ 'img': ['/>', ''],
    \ 'input': ['/>', ''],
    \ 'keygen': ['/>', ''],
    \ 'link': ['/>', ''],
    \ 'meta': ['/>', ''],
    \ 'param': ['/>', ''],
    \ 'source': ['/>', ''],
    \ 'track': ['/>', ''],
    \ 'wbr': ['/>', ''],
\ },
\ }

endif
