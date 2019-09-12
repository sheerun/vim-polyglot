if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vala') == -1

" Vim indent file
" Language:         Vala
" Author:           Adrià Arrufat <adria.arrufat@protonmail.ch>
" Last Change:      2016 Dec 04

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal cindent
setlocal cinoptions=L0,(0,Ws,J1,j1
setlocal cinkeys=0{,0},!^F,o,O,0[,0]

" Some preliminary settings
setlocal nolisp		" Make sure lisp indenting doesn't supersede us
setlocal autoindent	" indentexpr isn't much help otherwise

setlocal indentexpr=GetValaIndent(v:lnum)

" Only define the function once.
if exists("*GetValaIndent")
  finish
endif

" Come here when loading the script the first time.

function GetValaIndent(lnum)

	" Hit the start of the file, use zero indent.
	if a:lnum == 0
		return 0
	endif

	" Starting assumption: cindent (called at the end) will do it right
	" normally. We just want to fix up a few cases.

	let line = getline(a:lnum)
	" Search backwards for the previous non-empty line.
	let prevlinenum = prevnonblank(a:lnum - 1)
	let prevline = getline(prevlinenum)
	while prevlinenum > 1 && prevline !~ '[^[:blank:]]'
		let prevlinenum = prevnonblank(prevlinenum - 1)
		let prevline = s:getline(prevlinenum)
	endwhile

	" If previous line contains a code attribute (e.g. [CCode (...)])
	" don't increase the indentation
	if prevline =~? '^\s*\[[A-Za-z]' && prevline =~? '\]$'
		return indent(prevlinenum)
	endif

	" cindent gets lambda body wrong, as it treats the comma as indicating an
	" unfinished statement (fix borrowed from rust.vim indent file):
	"
	" list.foreach ((entry) => {
	"		stdout.puts (entry);
	"		stdout.putc ('\n');
	"		if (entry == null) {
	" 		print ("empty entry\n");
	"		}
	" });
	"
	" and we want it to be:
	" list.foreach ((entry) => {
	"	stdout.puts (entry);
	"	stdout.putc ('\n');
	" 	if (entry == null) {
	" 		print ("empty entry\n");
	" 	}
	" });

	if prevline[len(prevline) - 1] == ","
				\ && line !~ '^\s*[\[\]{}]'
				\ && prevline !~ '([^()]\+,$'
				\ && line !~ '^\s*\S\+\s*=>'
		return indent(prevlinenum)
	endif

	" Fall back on cindent, which does it mostly right
	return cindent(a:lnum)
endfunction

endif
