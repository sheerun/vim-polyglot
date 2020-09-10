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
