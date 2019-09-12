if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elm') == -1

let s:errors = []

function! s:elmOracle(...) abort
	let l:project = finddir('elm-stuff/..', '.;')
	if len(l:project) == 0
		echoerr '`elm-stuff` not found! run `elm-package install` for autocomplete.'
		return []
	endif

	let l:filename = expand('%:p')

	if a:0 == 0
		let l:oldiskeyword = &iskeyword
		" Some non obvious values used in 'iskeyword':
		"    @     = all alpha
		"    48-57 = numbers 0 to 9
		"    @-@   = character @
		"    124   = |
		setlocal iskeyword=@,48-57,@-@,_,-,~,!,#,$,%,&,*,+,=,<,>,/,?,.,\\,124,^
		let l:word = expand('<cword>')
		let &iskeyword = l:oldiskeyword
	else
		let l:word = a:1
	endif

	let l:infos = elm#Oracle(l:filename, l:word)
	if v:shell_error != 0
		call elm#util#EchoError("elm-oracle failed:\n\n", l:infos)
		return []
	endif

	let l:d = split(l:infos, '\n')
	if len(l:d) > 0
		return elm#util#DecodeJSON(l:d[0])
	endif

	return []
endf

" Vim command to format Elm files with elm-format
function! elm#Format() abort
	" check for elm-format
	if elm#util#CheckBin('elm-format', 'https://github.com/avh4/elm-format') ==# ''
		return
	endif

	" save cursor position, folds and many other things
    let l:curw = {}
    try
      mkview!
    catch
      let l:curw = winsaveview()
    endtry

    " save our undo file to be restored after we are done.
    let l:tmpundofile = tempname()
    exe 'wundo! ' . l:tmpundofile

	" write current unsaved buffer to a temporary file
	let l:tmpname = tempname() . '.elm'
	call writefile(getline(1, '$'), l:tmpname)

	" call elm-format on the temporary file
	let l:out = system('elm-format ' . l:tmpname . ' --output ' . l:tmpname)

	" if there is no error
	if v:shell_error == 0
		try | silent undojoin | catch | endtry

		" replace current file with temp file, then reload buffer
		let l:old_fileformat = &fileformat
		call rename(l:tmpname, expand('%'))
		silent edit!
		let &fileformat = l:old_fileformat
		let &syntax = &syntax
	elseif g:elm_format_fail_silently == 0
		call elm#util#EchoLater('EchoError', 'elm-format:', l:out)
	endif

    " save our undo history
    silent! exe 'rundo ' . l:tmpundofile
    call delete(l:tmpundofile)

	" restore our cursor/windows positions, folds, etc..
    if empty(l:curw)
      silent! loadview
    else
      call winrestview(l:curw)
    endif
endf

" Query elm-oracle and echo the type and docs for the word under the cursor.
function! elm#ShowDocs() abort
	" check for the elm-oracle binary
	if elm#util#CheckBin('elm-oracle', 'https://github.com/elmcast/elm-oracle') ==# ''
		return
	endif

	let l:response = s:elmOracle()

	if len(l:response) > 0
		let l:info = l:response[0]
		redraws! | echohl Identifier | echon l:info.fullName | echohl None | echon ' : ' | echohl Function | echon l:info.signature | echohl None | echon "\n\n" . l:info.comment
	else
		call elm#util#Echo('elm-oracle:', '...no match found')
	endif
endf

" Query elm-oracle and open the docs for the word under the cursor.
function! elm#BrowseDocs() abort
	" check for the elm-oracle binary
	if elm#util#CheckBin('elm-oracle', 'https://github.com/elmcast/elm-oracle') ==# ''
		return
	endif

	let l:response = s:elmOracle()

	if len(l:response) > 0
		let l:info = l:response[0]
		call elm#util#OpenBrowser(l:info.href)
	else
		call elm#util#Echo('elm-oracle:', '...no match found')
	endif
endf


function! elm#Syntastic(input) abort
	let l:fixes = []

	let l:bin = 'elm-make'
	let l:format = '--report=json'
	let l:input = shellescape(a:input)
	let l:output = '--output=' . shellescape(syntastic#util#DevNull())
	let l:command = l:bin . ' ' . l:format  . ' ' . l:input . ' ' . l:output
	let l:reports = s:ExecuteInRoot(l:command)

	for l:report in split(l:reports, '\n')
		if l:report[0] ==# '['
            for l:error in elm#util#DecodeJSON(l:report)
                if g:elm_syntastic_show_warnings == 0 && l:error.type ==? 'warning'
                else
                    if a:input == l:error.file
                        call add(s:errors, l:error)
                        call add(l:fixes, {'filename': l:error.file,
                                    \'valid': 1,
                                    \'bufnr': bufnr('%'),
                                    \'type': (l:error.type ==? 'error') ? 'E' : 'W',
                                    \'lnum': l:error.region.start.line,
                                    \'col': l:error.region.start.column,
                                    \'text': l:error.overview})
                    endif
                endif
            endfor
        endif
	endfor

	return l:fixes
endf

function! elm#Build(input, output, show_warnings) abort
	let s:errors = []
	let l:fixes = []
	let l:rawlines = []

	let l:bin = 'elm-make'
	let l:format = '--report=json'
	let l:input = shellescape(a:input)
	let l:output = '--output=' . shellescape(a:output)
	let l:command = l:bin . ' ' . l:format  . ' ' . l:input . ' ' . l:output
	let l:reports = s:ExecuteInRoot(l:command)

	for l:report in split(l:reports, '\n')
		if l:report[0] ==# '['
			for l:error in elm#util#DecodeJSON(l:report)
				if a:show_warnings == 0 && l:error.type ==? 'warning'
				else
					call add(s:errors, l:error)
					call add(l:fixes, {'filename': l:error.file,
								\'valid': 1,
								\'type': (l:error.type ==? 'error') ? 'E' : 'W',
								\'lnum': l:error.region.start.line,
								\'col': l:error.region.start.column,
								\'text': l:error.overview})
				endif
			endfor
		else
			call add(l:rawlines, l:report)
		endif
	endfor

	let l:details = join(l:rawlines, "\n")
	let l:lines = split(l:details, "\n")
	if !empty(l:lines)
		let l:overview = l:lines[0]
	else
		let l:overview = ''
	endif

	if l:details ==# '' || l:details =~? '^Successfully.*'
	else
		call add(s:errors, {'overview': l:details, 'details': l:details})
		call add(l:fixes, {'filename': expand('%', 1),
					\'valid': 1,
					\'type': 'E',
					\'lnum': 0,
					\'col': 0,
					\'text': l:overview})
	endif

	return l:fixes
endf

" Make the given file, or the current file if none is given.
function! elm#Make(...) abort
	if elm#util#CheckBin('elm-make', 'http://elm-lang.org/install') ==# ''
		return
	endif

	call elm#util#Echo('elm-make:', 'building...')

	let l:input = (a:0 == 0) ? expand('%:p') : a:1
	let l:fixes = elm#Build(l:input, g:elm_make_output_file, g:elm_make_show_warnings)

	if len(l:fixes) > 0
		call elm#util#EchoWarning('', 'found ' . len(l:fixes) . ' errors')

		call setqflist(l:fixes, 'r')
		cwindow

		if get(g:, 'elm_jump_to_error', 1)
			ll 1
		endif
	else
		call elm#util#EchoSuccess('', 'Sucessfully compiled')

		call setqflist([])
		cwindow
	endif
endf

" Show the detail of the current error in the quickfix window.
function! elm#ErrorDetail() abort
	if !empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") ==? "quickfix"'))
		exec ':copen'
		let l:linenr = line('.')
		exec ':wincmd p'
		if len(s:errors) > 0
			let l:detail = s:errors[l:linenr-1].details
			if l:detail ==# ''
				let l:detail = s:errors[l:linenr-1].overview
			endif
			echo l:detail
		endif
	endif
endf

" Open the elm repl in a subprocess.
function! elm#Repl() abort
	" check for the elm-repl binary
	if elm#util#CheckBin('elm-repl', 'http://elm-lang.org/install') ==# ''
		return
	endif

	if has('nvim')
		term('elm-repl')
	else
		!elm-repl
	endif
endf

function! elm#Oracle(filepath, word) abort
	let l:bin = 'elm-oracle'
	let l:filepath = shellescape(a:filepath)
	let l:word = shellescape(a:word)
	let l:command = l:bin . ' ' . l:filepath . ' ' . l:word
	return s:ExecuteInRoot(l:command)
endfunction

let s:fullComplete = ''

" Complete the current token using elm-oracle
function! elm#Complete(findstart, base) abort
" a:base is unused, but the callback function for completion expects 2 arguments
	if a:findstart
		let l:line = getline('.')

		let l:idx = col('.') - 1
		let l:start = 0
		while l:idx > 0 && l:line[l:idx - 1] =~# '[a-zA-Z0-9_\.]'
			if l:line[l:idx - 1] ==# '.' && l:start == 0
				let l:start = l:idx
			endif
			let l:idx -= 1
		endwhile

		if l:start == 0
			let l:start = l:idx
		endif

		let s:fullComplete = l:line[l:idx : col('.')-2]

		return l:start
	else
		" check for the elm-oracle binary
		if elm#util#CheckBin('elm-oracle', 'https://github.com/elmcast/elm-oracle') ==# ''
			return []
		endif

		let l:res = []
		let l:response = s:elmOracle(s:fullComplete)

		let l:detailed = get(g:, 'elm_detailed_complete', 0)

		for l:r in l:response
			let l:menu = ''
			if l:detailed
				let l:menu = ': ' . l:r.signature
			endif
			call add(l:res, {'word': l:r.name, 'menu': l:menu})
		endfor

		return l:res
	endif
endf

" If the current buffer contains a consoleRunner, run elm-test with it.
" Otherwise run elm-test in the root of your project which deafults to
" running 'elm-test tests/TestRunner'.
function! elm#Test() abort
	if elm#util#CheckBin('elm-test', 'https://github.com/rtfeldman/node-elm-test') ==# ''
		return
	endif

	if match(getline(1, '$'), 'consoleRunner') < 0
		let l:out = s:ExecuteInRoot('elm-test')
		call elm#util#EchoSuccess('elm-test', l:out)
	else
		let l:filepath = shellescape(expand('%:p'))
		let l:out = s:ExecuteInRoot('elm-test ' . l:filepath)
		call elm#util#EchoSuccess('elm-test', l:out)
	endif
endf

" Returns the closest parent with an elm-package.json file.
function! elm#FindRootDirectory() abort
	let l:elm_root = getbufvar('%', 'elmRoot')
	if empty(l:elm_root)
		let l:current_file = expand('%:p')
		let l:dir_current_file = fnameescape(fnamemodify(l:current_file, ':h'))
		let l:old_match = findfile('elm-package.json', l:dir_current_file . ';')
		let l:new_match = findfile('elm.json', l:dir_current_file . ';')
		if !empty(l:new_match)
			let l:elm_root = fnamemodify(l:new_match, ':p:h')
		elseif !empty(l:old_match)
			let l:elm_root = fnamemodify(l:old_match, ':p:h')
		else
			let l:elm_root = ''
		endif

		if !empty(l:elm_root)
			call setbufvar('%', 'elmRoot', l:elm_root)
		endif
	endif
	return l:elm_root
endfunction

" Executes a command in the project directory.
function! s:ExecuteInRoot(cmd) abort
	let l:cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
	let l:current_dir = getcwd()
	let l:root_dir = elm#FindRootDirectory()

	try
		execute l:cd . fnameescape(l:root_dir)
		let l:out = system(a:cmd)
	finally
		execute l:cd . fnameescape(l:current_dir)
	endtry

	return l:out
endfunction

endif
