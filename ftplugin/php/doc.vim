" PDV (phpDocumentor for Vim)
" ===========================
"
" Version: 1.1.3
" 
" Copyright 2005 by Tobias Schlitt <toby@php.net>
" Inspired by phpDoc script for Vim by Vidyut Luther (http://www.phpcult.com/).
"

" modified by kevin olson (acidjazz@gmail.com) - 03/19/2009
" - added folding support
"
" Provided under the GPL (http://www.gnu.org/copyleft/gpl.html).
"
" This script provides functions to generate phpDocumentor conform
" documentation blocks for your PHP code. The script currently
" documents:
" 
" - Classes
" - Methods/Functions
" - Attributes
"
" All of those supporting all PHP 4 and 5 syntax elements. 
"
" Beside that it allows you to define default values for phpDocumentor tags 
" like @version (I use $id$ here), @author, @license and so on. 
"
" For function/method parameters and attributes, the script tries to guess the 
" type as good as possible from PHP5 type hints or default values (array, bool, 
" int, string...).
"
" You can use this script by mapping the function PhpDoc() to any
" key combination. Hit this on the line where the element to document
" resides and the doc block will be created directly above that line.
" 
" Installation
" ============
" 
" For example include into your .vimrc:
" 
" source ~/.vim/php-doc.vim
" imap <C-o> :set paste<CR>:call PhpDoc()<CR>:set nopaste<CR>i
"
" This includes the script and maps the combination <ctrl>+o (only in
" insert mode) to the doc function. 
"
" Changelog
" =========
"
" Version 1.0.0
" -------------
"
"  * Created the initial version of this script while playing around with VIM
"  scripting the first time and trying to fix Vidyut's solution, which
"  resulted in a complete rewrite.
"
" Version 1.0.1
" -------------
"  * Fixed issues when using tabs instead of spaces.
"  * Fixed some parsing bugs when using a different coding style.
"  * Fixed bug with call-by-reference parameters. 
"  * ATTENTION: This version already has code for the next version 1.1.0,
"  which is propably not working!
"
" Version 1.1.0 (preview)
" -------------
"  * Added foldmarker generation.
" 

" Version 1.1.2 
" -------------
"  * Completed foldmarker commenting for functions
" 



if has ("user_commands")

" {{{ Globals

" After phpDoc standard
let g:pdv_cfg_CommentHead = "/**"
let g:pdv_cfg_Comment1 = " * "
let g:pdv_cfg_Commentn = " * "
let g:pdv_cfg_CommentTail = " */"
let g:pdv_cfg_CommentEnd = "/* }}} */"
let g:pdv_cfg_CommentSingle = "//"

" Default values
let g:pdv_cfg_Type = "mixed"
" let g:pdv_cfg_Package = "Framework"
let g:pdv_cfg_Package = "Webdav"
let g:pdv_cfg_Version = "//autogen//"
let g:pdv_cfg_Author = ""
let g:pdv_cfg_Copyright = "Copyright (c) 2010 All rights reserved."
let g:pdv_cfg_License = "PHP Version 3.0 {@link http://www.php.net/license/3_0.txt}"

let g:pdv_cfg_ReturnVal = "void"

" Whether to create @uses tags for implementation of interfaces and inheritance
let g:pdv_cfg_Uses = 1

" Options
" :set paste before documenting (1|0)? Recommended.
let g:pdv_cfg_paste = 1

" Whether for PHP5 code PHP4 tags should be set, like @access,... (1|0)?
let g:pdv_cfg_php4always = 1
 
" Whether to guess scopes after PEAR coding standards:
" $_foo/_bar() == <private|protected> (1|0)?
let g:pdv_cfg_php4guess = 1

" If you selected 1 for the last value, this scope identifier will be used for
" the identifiers having an _ in the first place.
let g:pdv_cfg_php4guessval = "protected"

"
" Regular expressions 
" 

let g:pdv_re_comment = ' *\*/ *'

" (private|protected|public)
let g:pdv_re_scope = '\(private\|protected\|public\)'
" (static)
let g:pdv_re_static = '\(static\)'
" (abstract)
let g:pdv_re_abstract = '\(abstract\)'
" (final)
let g:pdv_re_final = '\(final\)'

" [:space:]*(private|protected|public|static|abstract)*[:space:]+[:identifier:]+\([:params:]\)
let g:pdv_re_func = '^\s*\([a-zA-Z ]*\)function\s\+\([^ (]\+\)\s*(\s*\(.*\)\s*)\s*[{;]\?$'
let g:pdv_re_funcend = '^\s*}$'
" [:typehint:]*[:space:]*$[:identifier]\([:space:]*=[:space:]*[:value:]\)?
let g:pdv_re_param = ' *\([^ &]*\) *&\?\$\([A-Za-z_][A-Za-z0-9_]*\) *=\? *\(.*\)\?$'

" [:space:]*(private|protected|public\)[:space:]*$[:identifier:]+\([:space:]*=[:space:]*[:value:]+\)*;
let g:pdv_re_attribute = '^\s*\(\(private\|public\|protected\|var\|static\)\+\)\s*\$\([^ ;=]\+\)[ =]*\(.*\);\?$'

" [:spacce:]*(abstract|final|)[:space:]*(class|interface)+[:space:]+\(extends ([:identifier:])\)?[:space:]*\(implements ([:identifier:][, ]*)+\)?
let g:pdv_re_class = '^\s*\([a-zA-Z]*\)\s*\(interface\|class\)\s*\([^ ]\+\)\s*\(extends\)\?\s*\([a-zA-Z0-9]*\)\?\s*\(implements*\)\? *\([a-zA-Z0-9_ ,]*\)\?.*$'

let g:pdv_re_array = "^array *(.*"
let g:pdv_re_float = '^[0-9.]\+'
let g:pdv_re_int = '^[0-9]\+$'
let g:pdv_re_string = "['\"].*"
let g:pdv_re_bool = "[true false]"

let g:pdv_re_indent = '^\s*'

" Shortcuts for editing the text:
let g:pdv_cfg_BOL = "norm! o"
let g:pdv_cfg_EOL = ""

" }}}  

 " {{{ PhpDocSingle()
 " Document a single line of code ( does not check if doc block already exists )

func! PhpDocSingle()
    let l:endline = line(".") + 1
    call PhpDoc()
    exe "norm! " . l:endline . "G$"
endfunc

" }}}
 " {{{ PhpDocRange()
 " Documents a whole range of code lines ( does not add defualt doc block to
 " unknown types of lines ). Skips elements where a docblock is already
 " present.
func! PhpDocRange() range
    let l:line = a:firstline
    let l:endLine = a:lastline
	let l:elementName = ""
    while l:line <= l:endLine
        " TODO: Replace regex check for existing doc with check more lines
        " above...
        if (getline(l:line) =~ g:pdv_re_func || getline(l:line) =~ g:pdv_re_attribute || getline(l:line) =~ g:pdv_re_class) && getline(l:line - 1) !~ g:pdv_re_comment
			let l:docLines = 0
			" Ensure we are on the correct line to run PhpDoc()
            exe "norm! " . l:line . "G$"
			" No matter what, this returns the element name
            let l:elementName = PhpDoc()
            let l:endLine = l:endLine + (line(".") - l:line) + 1
            let l:line = line(".") + 1 
        endif
        let l:line = l:line + 1
    endwhile
endfunc

 " }}}
" {{{ PhpDocFold()

" func! PhpDocFold(name)
" 	let l:startline = line(".")
" 	let l:currentLine = l:startLine
" 	let l:commentHead = escape(g:pdv_cfg_CommentHead, "*.");
"     let l:txtBOL = g:pdv_cfg_BOL . matchstr(l:name, '^\s*')
" 	" Search above for comment start
" 	while (l:currentLine > 1)
" 		if (matchstr(l:commentHead, getline(l:currentLine)))
" 			break;
" 		endif
" 		let l:currentLine = l:currentLine + 1
" 	endwhile
" 	" Goto 1 line above and open a newline
"     exe "norm! " . (l:currentLine - 1) . "Go\<ESC>"
" 	" Write the fold comment
"     exe l:txtBOL . g:pdv_cfg_CommentSingle . " {"."{{ " . a:name . g:pdv_cfg_EOL
" 	" Add another newline below that
" 	exe "norm! o\<ESC>"
" 	" Search for our comment line
" 	let l:currentLine = line(".")
" 	while (l:currentLine <= line("$"))
" 		" HERE!!!!
" 	endwhile
" 	
" 
" endfunc


" }}}

" {{{ PhpDoc()

func! PhpDoc()
    " Needed for my .vimrc: Switch off all other enhancements while generating docs
    let l:paste = &g:paste
    let &g:paste = g:pdv_cfg_paste == 1 ? 1 : &g:paste
    
    let l:line = getline(".")
    let l:result = ""

    if l:line =~ g:pdv_re_func
        let l:result = PhpDocFunc()

    elseif l:line =~ g:pdv_re_funcend
		let l:result = PhpDocFuncEnd()

    elseif l:line =~ g:pdv_re_attribute
        let l:result = PhpDocVar()

    elseif l:line =~ g:pdv_re_class
        let l:result = PhpDocClass()

    else
        let l:result = PhpDocDefault()

    endif

"	if g:pdv_cfg_folds == 1
"		PhpDocFolds(l:result)
"	endif

    let &g:paste = l:paste

    return l:result
endfunc

" }}}

" {{{ PhpDocFuncEnd()
func! PhpDocFuncEnd()

	call append(line('.'), matchstr(getline('.'), '^\s*') . g:pdv_cfg_CommentEnd)
endfunc
" }}}
" {{{ PhpDocFuncEndAuto()
func! PhpDocFuncEndAuto()


	call search('{')
	call searchpair('{', '', '}')
	call append(line('.'), matchstr(getline('.'), '^\s*') . g:pdv_cfg_CommentEnd)

endfunc
" }}}

" {{{  PhpDocFunc()  

func! PhpDocFunc()
	" Line for the comment to begin
	let commentline = line (".") - 1

	let l:name = substitute (getline ("."), '^\(.*\)\/\/.*$', '\1', "")

    "exe g:pdv_cfg_BOL . "DEBUG:" . name. g:pdv_cfg_EOL

	" First some things to make it more easy for us:
	" tab -> space && space+ -> space
	" let l:name = substitute (l:name, '\t', ' ', "")
	" Orphan. We're now using \s everywhere...

	" Now we have to split DECL in three parts:
	" \[(skopemodifier\)]\(funcname\)\(parameters\)
    let l:indent = matchstr(l:name, g:pdv_re_indent)
	
	let l:modifier = substitute (l:name, g:pdv_re_func, '\1', "g")
	let l:funcname = substitute (l:name, g:pdv_re_func, '\2', "g")
	let l:parameters = substitute (l:name, g:pdv_re_func, '\3', "g") . ","
	let l:params = substitute (l:name, g:pdv_re_func, '\3', "g") 
	let l:sparams = substitute (l:params, '[$  ]', '', "g")
    let l:scope = PhpDocScope(l:modifier, l:funcname)
    let l:static = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_static) : ""
	let l:abstract = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_abstract) : ""
	let l:final = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_final) : ""
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . l:indent

		exec l:txtBOL . "/* " . l:scope ." ".  funcname . "(" . l:params . ") {{" . "{ */ " . g:pdv_cfg_EOL
	
    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
	" added folding
	exe l:txtBOL . g:pdv_cfg_Comment1 . funcname . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . g:pdv_cfg_EOL

	while (l:parameters != ",") && (l:parameters != "")
		" Save 1st parameter
		let _p = substitute (l:parameters, '\([^,]*\) *, *\(.*\)', '\1', "")
		" Remove this one from list
		let l:parameters = substitute (l:parameters, '\([^,]*\) *, *\(.*\)', '\2', "")
		" PHP5 type hint?
		let l:paramtype = substitute (_p, g:pdv_re_param, '\1', "")
		" Parameter name
		let l:paramname = substitute (_p, g:pdv_re_param, '\2', "")
		" Parameter default
		let l:paramdefault = substitute (_p, g:pdv_re_param, '\3', "")

        if l:paramtype == ""
            let l:paramtype = PhpDocType(l:paramdefault)
        endif
        
        if l:paramtype != ""
            let l:paramtype = " " . l:paramtype
        endif
		exe l:txtBOL . g:pdv_cfg_Commentn . "@param" . l:paramtype . " $" . l:paramname . " " . g:pdv_cfg_EOL
	endwhile

	if l:static != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@static" . g:pdv_cfg_EOL
    endif
	if l:abstract != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@abstract" . g:pdv_cfg_EOL
    endif
	if l:final != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@final" . g:pdv_cfg_EOL
    endif
    if l:scope != ""
    	exe l:txtBOL . g:pdv_cfg_Commentn . "@access " . l:scope . g:pdv_cfg_EOL
    endif
	exe l:txtBOL . g:pdv_cfg_Commentn . "@return " . g:pdv_cfg_ReturnVal . g:pdv_cfg_EOL

	" Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL

	return l:modifier ." ". l:funcname . PhpDocFuncEndAuto()
endfunc

" }}}  
 " {{{  PhpDocVar() 

func! PhpDocVar()
	" Line for the comment to begin
	let commentline = line (".") - 1

	let l:name = substitute (getline ("."), '^\(.*\)\/\/.*$', '\1', "")

	" Now we have to split DECL in three parts:
	" \[(skopemodifier\)]\(funcname\)\(parameters\)
	" let l:name = substitute (l:name, '\t', ' ', "")
	" Orphan. We're now using \s everywhere...

    let l:indent = matchstr(l:name, g:pdv_re_indent)

	let l:modifier = substitute (l:name, g:pdv_re_attribute, '\1', "g")
	let l:varname = substitute (l:name, g:pdv_re_attribute, '\3', "g")
	let l:default = substitute (l:name, g:pdv_re_attribute, '\4', "g")
    let l:scope = PhpDocScope(l:modifier, l:varname)

    let l:static = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_static) : ""

    let l:type = PhpDocType(l:default)
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . l:indent
	
    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Comment1 . l:varname . " " . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . g:pdv_cfg_EOL
    if l:static != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@static" . g:pdv_cfg_EOL
    endif
    exe l:txtBOL . g:pdv_cfg_Commentn . "@var " . l:type . g:pdv_cfg_EOL
    if l:scope != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@access " . l:scope . g:pdv_cfg_EOL
    endif
	
    " Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL
	return l:modifier ." ". l:varname
endfunc

" }}}
"  {{{  PhpDocClass()

func! PhpDocClass()
	" Line for the comment to begin
	let commentline = line (".") - 1

	let l:name = substitute (getline ("."), '^\(.*\)\/\/.*$', '\1', "")

    "exe g:pdv_cfg_BOL . "DEBUG:" . name. g:pdv_cfg_EOL

	" First some things to make it more easy for us:
	" tab -> space && space+ -> space
	" let l:name = substitute (l:name, '\t', ' ', "")
	" Orphan. We're now using \s everywhere...

	" Now we have to split DECL in three parts:
	" \[(skopemodifier\)]\(classname\)\(parameters\)
    let l:indent = matchstr(l:name, g:pdv_re_indent)
	
	let l:modifier = substitute (l:name, g:pdv_re_class, '\1', "g")
	let l:classname = substitute (l:name, g:pdv_re_class, '\3', "g")
	let l:extends = g:pdv_cfg_Uses == 1 ? substitute (l:name, g:pdv_re_class, '\5', "g") : ""
	let l:interfaces = g:pdv_cfg_Uses == 1 ? substitute (l:name, g:pdv_re_class, '\7', "g") . "," : ""

	let l:abstract = g:pdv_cfg_php4always == 1 ? matchstr(l:modifier, g:pdv_re_abstract) : ""
	let l:final = g:pdv_cfg_php4always == 1 ?  matchstr(l:modifier, g:pdv_re_final) : ""
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . l:indent
	
    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Comment1 . l:classname . " " . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . g:pdv_cfg_EOL
    if l:extends != "" && l:extends != "implements"
    	exe l:txtBOL . g:pdv_cfg_Commentn . "@uses " . l:extends . g:pdv_cfg_EOL
    endif

	while (l:interfaces != ",") && (l:interfaces != "")
		" Save 1st parameter
		let interface = substitute (l:interfaces, '\([^, ]*\) *, *\(.*\)', '\1', "")
		" Remove this one from list
		let l:interfaces = substitute (l:interfaces, '\([^, ]*\) *, *\(.*\)', '\2', "")
		exe l:txtBOL . g:pdv_cfg_Commentn . "@uses " . l:interface . g:pdv_cfg_EOL
	endwhile

	if l:abstract != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@abstract" . g:pdv_cfg_EOL
    endif
	if l:final != ""
        exe l:txtBOL . g:pdv_cfg_Commentn . "@final" . g:pdv_cfg_EOL
    endif
	exe l:txtBOL . g:pdv_cfg_Commentn . "@package " . g:pdv_cfg_Package . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@version " . g:pdv_cfg_Version . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@copyright " . g:pdv_cfg_Copyright . g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@author " . g:pdv_cfg_Author g:pdv_cfg_EOL
	exe l:txtBOL . g:pdv_cfg_Commentn . "@license " . g:pdv_cfg_License . g:pdv_cfg_EOL

	" Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL
	return l:modifier ." ". l:classname
endfunc

" }}} 
" {{{ PhpDocScope() 

func! PhpDocScope(modifiers, identifier)
" exe g:pdv_cfg_BOL . DEBUG: . a:modifiers . g:pdv_cfg_EOL
    let l:scope  = ""
    if  matchstr (a:modifiers, g:pdv_re_scope) != "" 
        if g:pdv_cfg_php4always == 1
            let l:scope = matchstr (a:modifiers, g:pdv_re_scope)
        else
            let l:scope = "x"
        endif
    endif
    if l:scope =~ "^\s*$" && g:pdv_cfg_php4guess
        if a:identifier[0] == "_"
            let l:scope = g:pdv_cfg_php4guessval
        else
            let l:scope = "public"
        endif
    endif
    return l:scope != "x" ? l:scope : ""
endfunc

" }}}
" {{{ PhpDocType()

func! PhpDocType(typeString)
    let l:type = ""
    if a:typeString =~ g:pdv_re_array 
        let l:type = "array"
    endif
    if a:typeString =~ g:pdv_re_float 
        let l:type = "float"
    endif
    if a:typeString =~ g:pdv_re_int 
        let l:type = "int"
    endif
    if a:typeString =~ g:pdv_re_string
        let l:type = "string"
    endif
    if a:typeString =~ g:pdv_re_bool
        let l:type = "bool"
    endif
	if l:type == ""
		let l:type = g:pdv_cfg_Type
	endif
    return l:type
endfunc
    
"  }}} 
" {{{  PhpDocDefault()

func! PhpDocDefault()
	" Line for the comment to begin
	let commentline = line (".") - 1
    
    let l:indent = matchstr(getline("."), '^\ *')
    
    exe "norm! " . commentline . "G$"
    
    " Local indent
    let l:txtBOL = g:pdv_cfg_BOL . indent

    exe l:txtBOL . g:pdv_cfg_CommentHead . g:pdv_cfg_EOL
    exe l:txtBOL . g:pdv_cfg_Commentn . " " . g:pdv_cfg_EOL
	
    " Close the comment block.
	exe l:txtBOL . g:pdv_cfg_CommentTail . g:pdv_cfg_EOL
endfunc

" }}}

endif " user_commands
