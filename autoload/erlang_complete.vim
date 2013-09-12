" Vim omni completion file
" Language:     Erlang
" Author:       Oscar Hellström <oscar@oscarh.net>
" Contributors: kTT (http://github.com/kTT)
"               Ricardo Catalinas Jiménez <jimenezrick@gmail.com>
"               Eduardo Lopez (http://github.com/tapichu)
"               Zhihui Jiao (http://github.com/onlychoice)
" License:      Vim license
" Version:      2012/11/26

if !exists('g:erlang_completion_cache')
	let g:erlang_completion_cache = 1
endif

" Completion program path
let s:erlang_complete_file = expand('<sfile>:p:h') . '/erlang_complete.erl'

" Modules cache used to speed up the completion
let s:modules_cache = {}

" File cache for persistence between Vim sessions
if filewritable(expand('<sfile>:p:h')) == 2
	let s:file_cache = expand('<sfile>:p:h') . '/vimerl_cache'
else
	let s:file_cache = '/tmp/vimerl_cache'
endif

" Patterns for completions
let s:erlang_local_func_beg    = '\(\<[0-9A-Za-z_-]*\|\s*\)$'
let s:erlang_external_func_beg = '\<[0-9A-Za-z_-]\+:[0-9A-Za-z_-]*$'
let s:erlang_blank_line        = '^\s*\(%.*\)\?$'

" Main function for completion
function erlang_complete#Complete(findstart, base)
	let lnum = line('.')
	let column = col('.')
	let line = strpart(getline('.'), 0, column - 1)

	" 1) Check if the char to the left of us are part of a function call
	"
	" Nothing interesting is written at the char just before the cursor
	" This means _anything_ could be started here
	" In this case, keyword completion should probably be used,
	" for now we'll only try and complete local functions.
	"
	" TODO: Examine if we can stare Identifiers end complete on them
	" Is this worth it? Is /completion/ of a "blank" wanted? Can we consider
	" `(' interesting and check if we are in a function call etc.?
	if line[column - 2] !~ '[0-9A-Za-z:_-]'
		if a:findstart
			return column
		else
			return s:ErlangFindLocalFunc(a:base)
		endif
	endif
	
	" 2) Function in external module
	if line =~ s:erlang_external_func_beg
		let delimiter = match(line, ':[0-9A-Za-z_-]*$') + 1
		if a:findstart
			return delimiter
		else
			let module = matchstr(line[:-2], '\<\k*\>$')
			return s:ErlangFindExternalFunc(module, a:base)
		endif
	endif

	" 3) Local function
	if line =~ s:erlang_local_func_beg
		let funcstart = match(line, ':\@<![0-9A-Za-z_-]*$')
		if a:findstart
			return funcstart
		else
			return s:ErlangFindLocalFunc(a:base)
		endif
	endif

	" 4) Unhandled situation
	if a:findstart
		return -1
	else
		return []
	endif
endfunction

" Find the next non-blank line
function s:ErlangFindNextNonBlank(lnum)
	let lnum = nextnonblank(a:lnum + 1)
	let line = getline(lnum)

	while line =~ s:erlang_blank_line && 0 != lnum
		let lnum = nextnonblank(lnum + 1)
		let line = getline(lnum)
	endwhile

	return lnum
endfunction

" Find external function names
function s:ErlangFindExternalFunc(module, base)
	" If the module is cached, load its functions
	if has_key(s:modules_cache, a:module)
		for field_cache in get(s:modules_cache, a:module)
			if match(field_cache.word, a:base) == 0
				call complete_add(field_cache)
			endif
		endfor

		return []
	endif

	let functions = system(s:erlang_complete_file . ' ' . a:module)
	for function_spec in split(functions, '\n')
		if match(function_spec, a:base) == 0
			let function_name = matchstr(function_spec, a:base . '\w*')
			let field = {'word': function_name . '(', 'abbr': function_spec,
				  \  'kind': 'f', 'dup': 1}
			call complete_add(field)

			" Populate the cache only when iterating over all the
			" module functions (i.e. no prefix for the completion)
			if g:erlang_completion_cache && a:base == ''
				if !has_key(s:modules_cache, a:module)
					let s:modules_cache[a:module] = [field]
				else
					let fields_cache = get(s:modules_cache, a:module)
					let s:modules_cache[a:module] = add(fields_cache, field)
				endif
			endif

			" The user entered some text, so stop the completion
			if complete_check()
				" The module couldn't be entirely cached
				if has_key(s:modules_cache, a:module)
					call remove(s:modules_cache, a:module)
				endif
				break
			endif
		endif
	endfor

	call s:ErlangWriteCache(a:module)

	return []
endfunction

" Find local function names
function s:ErlangFindLocalFunc(base)
	" Begin at line 1
	let lnum = s:ErlangFindNextNonBlank(1)

	if "" == a:base
		let base = '\w' " Used to match against word symbol
	else
		let base = a:base
	endif

	while 0 != lnum && !complete_check()
		let line = getline(lnum)
		let function_name = matchstr(line, '^' . base . '[0-9A-Za-z_-]\+(\@=')
		if function_name != ""
			call complete_add({'word': function_name, 'kind': 'f'})
		endif
		let lnum = s:ErlangFindNextNonBlank(lnum)
	endwhile

	return []
endfunction

function s:ErlangLoadCache()
	if filereadable(s:file_cache)
		for line in readfile(s:file_cache)
			let cache_entry = eval(line)
			" cache_entry is a dict with just one key with the
			" module name and the function list we are going to
			" add to the memory cache as the value of this key
			for mod_name in keys(cache_entry)
				let func_list = get(cache_entry, mod_name)
				let s:modules_cache[mod_name] = func_list
			endfor
		endfor
	endif
endfunction

function s:ErlangWriteCache(module)
	" Write all the module functions to the cache file
	if has_key(s:modules_cache, a:module)
		let func_list = get(s:modules_cache, a:module)
		if len(func_list) > 0
			let cache_entry = {a:module : func_list}
			execute 'redir >>' . s:file_cache
			silent echon cache_entry
			silent echon "\n"
			redir END
		endif
	endif
endfunction

function s:ErlangPurgeCache(...)
	for mod_name in a:000
		if has_key(s:modules_cache, mod_name)
			call remove(s:modules_cache, mod_name)
		endif
	endfor

	" Delete the old cache file
	call delete(s:file_cache)

	" Write a new one
	for mod_name in keys(s:modules_cache)
		call s:ErlangWriteCache(mod_name)
	endfor
endfunction

" Load the file cache when this script is autoloaded
call s:ErlangLoadCache()

" Command for removing modules from the cache
command -nargs=+ ErlangPurgeCache silent call s:ErlangPurgeCache(<f-args>)
