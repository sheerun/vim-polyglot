let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'indent/caddyfile.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'caddyfile') == -1

if exists('b:did_indent')
	finish
endif
let b:did_indent = 1

setlocal nolisp
setlocal autoindent
setlocal indentexpr=GetCaddyfileIndent(v:lnum)
setlocal indentkeys+=<:>,0=},0=)

if exists('*shiftwidth')
	function! s:sw()
		return shiftwidth()
	endfunc
else
	function! s:sw()
		return &sw
	endfunc
endif

function! GetCaddyfileIndent(lnum)
	let prevlnum = prevnonblank(a:lnum-1)
	if prevlnum == 0
		return 0
	endif

	let thisl = substitute(getline(a:lnum), '#.*$', '', '')
	let prevl = substitute(getline(prevlnum), '#.*$', '', '')

	let ind = indent(prevlnum)

	if prevl =~ '{\s*$'
		let ind += s:sw()
	endif

	if thisl =~ '^\s*}\s*$'
		let ind -= s:sw()
	endif

	return ind
endfunction

endif
