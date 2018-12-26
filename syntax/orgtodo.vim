if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'org') == -1
  
syn match org_todo_key /\[\zs[^]]*\ze\]/
hi def link org_todo_key Identifier

let s:todo_headings = ''
let s:i = 1
while s:i <= g:org_heading_highlight_levels
	if s:todo_headings == ''
		let s:todo_headings = 'containedin=org_heading' . s:i
	else
		let s:todo_headings = s:todo_headings . ',org_heading' . s:i
	endif
	let s:i += 1
endwhile
unlet! s:i

if !exists('g:loaded_orgtodo_syntax')
	let g:loaded_orgtodo_syntax = 1
	function! s:ReadTodoKeywords(keywords, todo_headings)
		let l:default_group = 'Todo'
		for l:i in a:keywords
			if type(l:i) == 3
				call s:ReadTodoKeywords(l:i, a:todo_headings)
				continue
			endif
			if l:i == '|'
				let l:default_group = 'Question'
				continue
			endif
			" strip access key
			let l:_i = substitute(l:i, "\(.*$", "", "")

			let l:group = l:default_group
			for l:j in g:org_todo_keyword_faces
				if l:j[0] == l:_i
					let l:group = 'orgtodo_todo_keyword_face_' . l:_i
					call OrgExtendHighlightingGroup(l:default_group, l:group, OrgInterpretFaces(l:j[1]))
					break
				endif
			endfor
			silent! exec 'syntax match orgtodo_todo_keyword_' . l:_i . ' /' . l:_i .'/ ' . a:todo_headings
			silent! exec 'hi def link orgtodo_todo_keyword_' . l:_i . ' ' . l:group
		endfor
	endfunction
endif

call s:ReadTodoKeywords(g:org_todo_keywords, s:todo_headings)
unlet! s:todo_headings

endif
