if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'org') == -1
  
" Delete the next line to avoid the special indention of items
if !exists("g:org_indent")
  let g:org_indent = 0
endif

setlocal foldtext=GetOrgFoldtext()
setlocal fillchars-=fold:-
setlocal fillchars+=fold:\ 
setlocal foldexpr=GetOrgFolding()
setlocal foldmethod=expr
setlocal indentexpr=GetOrgIndent()
setlocal nolisp
setlocal nosmartindent
setlocal autoindent

if has('python3')
	let s:py_env = 'python3 << EOF'
else
	let s:py_env = 'python << EOF'
endif

function! GetOrgIndent()
	if g:org_indent == 0
		return -1
	endif

exe s:py_env
from orgmode._vim import indent_orgmode
indent_orgmode()
EOF

	if exists('b:indent_level')
		let l:tmp = b:indent_level
		unlet b:indent_level
		return l:tmp
	else
		return -1
	endif
endfunction

function! GetOrgFolding()
	let l:mode = mode()
	if l:mode == 'i'
		" the cache size is limited to 3, because vim queries the current and
		" both surrounding lines when the user is typing in insert mode. The
		" cache is shared between GetOrgFolding and GetOrgFoldtext
		if ! exists('b:org_folding_cache')
			let b:org_folding_cache = {}
		endif

		if has_key(b:org_folding_cache, v:lnum)
			if match(b:org_folding_cache[v:lnum], '^>') == 0 &&
						\ match(getline(v:lnum), '^\*\+\s') != 0
				" when the user pastes text or presses enter, it happens that
				" the cache starts to confuse vim's folding abilities
				" these entries can safely be removed
				unlet b:org_folding_cache[v:lnum]

				" the fold text cache is probably also damaged, delete it as
				" well
				unlet! b:org_foldtext_cache
			else
				return b:org_folding_cache[v:lnum]
			endif
		endif

		exe s:py_env
from orgmode._vim import fold_orgmode
fold_orgmode(allow_dirty=True)
EOF
	else

		exe s:py_env
from orgmode._vim import fold_orgmode
fold_orgmode()
EOF
	endif

	if exists('b:fold_expr')
		let l:tmp = b:fold_expr
		unlet b:fold_expr
		if l:mode == 'i'
			if ! has_key(b:org_folding_cache, v:lnum)
				if len(b:org_folding_cache) > 3
					let b:org_folding_cache = {}
				endif
				let b:org_folding_cache[v:lnum] = l:tmp
			endif
		endif
		return l:tmp
	else
		return -1
	endif
endfunction

function! SetOrgFoldtext(text)
	let b:foldtext = a:text
endfunction

function! GetOrgFoldtext()
	let l:mode = mode()
	if l:mode == 'i'
		" add a separate cache for fold text
		if ! exists('b:org_foldtext_cache') ||
					\ ! has_key(b:org_foldtext_cache, 'timestamp') ||
					\ b:org_foldtext_cache['timestamp'] > (localtime() + 10)
			let b:org_foldtext_cache = {'timestamp': localtime()}
		endif

		if has_key(b:org_foldtext_cache, v:foldstart)
			return b:org_foldtext_cache[v:foldstart]
		endif
		exe s:py_env
from orgmode._vim import fold_text
fold_text(allow_dirty=True)
EOF
	else
		unlet! b:org_foldtext_cache
		exec s:py_env
from orgmode._vim import fold_text
fold_text()
EOF
	endif

	if exists('b:foldtext')
		let l:tmp = b:foldtext
		unlet b:foldtext
		if l:mode == 'i'
			let b:org_foldtext_cache[v:foldstart] = l:tmp
		endif
		return l:tmp
	endif
endfunction

endif
