" Language:     Blade
" Author:       Barry Deeney <sitemaster16@gmail.com>
" Version:      0.1
" Description:  BLADE indent file based on HTML indentation...

" Check if this file has already been loaded
if exists("b:did_indent")
	finish
endif

" Include HTML
runtime! indent/html.vim
runtime! indent/php.vim
silent! unlet b:did_indent

" What function do we need to use to detect indentation?
setlocal indentexpr=BladeIndent()

" What keys would trigger indentation?
setlocal indentkeys=o,O,<Return>,<>>,{,},!^F,0{,0},0),:,!^F,o,O,e,*<Return>,=?>,=<?,=*/

" THE MAIN INDENT FUNCTION. Return the amount of indent for v:lnum.
func! BladeIndent()
	" What is the current line?
	let current_line = v:lnum

	" What is the current text?
	let current_text = tolower(getline(current_line))

	" What was the last non blank line?
	let previous_line = prevnonblank(current_line)

	" What was the last non blank text?
	let previous_text = tolower(getline(previous_line))

	" How large are indents??
	let indent_size = &sw

	" Check if we have a PHPIndent value...
	let indent = GetPhpIndent()

	" check if we have indent
	if indent == -1
		" Check if we have BLADE
		if current_text =~ '^\s*@' || previous_text =~ '^\s*@'
			" We need to add to the indent
			return indent_size * indent(previous_text)
		endif

		" Check if we have HTML
		if current_text =~ '^\s*<' || previous_text =~ '^\s*<'
			" We now give the honors to HtmlIndent()
			let indent = HtmlIndent()
		endif
	endif

	" Give the indent back!
	return indent
endfunc

" Make sure we store that flag!
let b:did_indent = 1
