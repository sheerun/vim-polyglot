if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'crystal') == -1

let s:save_cpo = &cpo
set cpo&vim

let s:V = vital#crystal#new()
let s:P = s:V.import('Process')
let s:C = s:V.import('ColorEcho')

if exists('*json_decode')
    function! s:decode_json(text) abort
        return json_decode(a:text)
    endfunction
else
    let s:J = s:V.import('Web.JSON')
    function! s:decode_json(text) abort
        return s:J.decode(a:text)
    endfunction
endif

function! s:echo_error(msg, ...) abort
    echohl ErrorMsg
    if a:0 == 0
        echomsg a:msg
    else
        echomsg call('printf', [a:msg] + a:000)
    endif
    echohl None
endfunction

function! s:run_cmd(cmd) abort
    if !executable(g:crystal_compiler_command)
        throw "vim-crystal: Error: '" . g:crystal_compiler_command . "' command is not found."
    endif
    return s:P.system(a:cmd)
endfunction

function! s:find_root_by(search_dir, d) abort
    let found_dir = finddir(a:search_dir, a:d . ';')
    if found_dir ==# ''
        return ''
    endif

    " Note: ':h:h' for {root}/{search_dir}/ -> {root}/{search_dir} -> {root}
    return fnamemodify(found_dir, ':p:h:h')
endfunction

" Search the root directory containing a 'spec/' and a 'src/' directories.
"
" Searching for the 'spec/' directory is not enough: for example the crystal
" compiler has a 'cr_sources/src/spec/' directory that would otherwise give the root
" directory as 'cr_source/src/' instead of 'cr_sources/'.
function! s:find_root_by_spec_and_src(d) abort
    " Search for 'spec/'
    let root = s:find_root_by('spec', a:d)
    " Check that 'src/' is also there
    if root !=# '' && isdirectory(root . '/src')
        return root
    endif

    " Search for 'src/'
    let root = s:find_root_by('src', a:d)
    " Check that 'spec/' is also there
    if root !=# '' && isdirectory(root . '/spec')
        return root
    endif

    " Cannot find a directory containing both 'src/' and 'spec/'
    return ''
endfunction

function! crystal_lang#entrypoint_for(file_path) abort
    let parent_dir = fnamemodify(a:file_path, ':p:h')
    let root_dir = s:find_root_by_spec_and_src(parent_dir)
    if root_dir ==# ''
        " No spec directory found. No need to make temporary file
        return a:file_path
    endif

    let required_spec_path = get(b:, 'crystal_required_spec_path', get(g:, 'crystal_required_spec_path', ''))
    if required_spec_path !=# ''
      let require_spec_str = './' . required_spec_path
    else
      let require_spec_str = './spec/**'
    endif

    let temp_name = root_dir . '/__vim-crystal-temporary-entrypoint-' . fnamemodify(a:file_path, ':t')
    let contents = [
                \   'require "spec"',
                \   'require "' . require_spec_str . '"',
                \   printf('require "./%s"', fnamemodify(a:file_path, ':p')[strlen(root_dir)+1 : ])
                \ ]

    let result = writefile(contents, temp_name)
    if result == -1
        " Note: When writefile() failed
        return a:file_path
    endif

    return temp_name
endfunction

function! crystal_lang#tool(name, file, pos, option_str) abort
    let entrypoint = crystal_lang#entrypoint_for(a:file)
    let cmd = printf(
                \   '%s tool %s --no-color %s --cursor %s:%d:%d %s',
                \   g:crystal_compiler_command,
                \   a:name,
                \   a:option_str,
                \   a:file,
                \   a:pos[1],
                \   a:pos[2],
                \   entrypoint
                \ )

    try
        let output = s:run_cmd(cmd)
        return {'failed': s:P.get_last_status(), 'output': output}
    finally
        " Note:
        " If the entry point is temporary file, delete it finally.
        if a:file !=# entrypoint
            call delete(entrypoint)
        endif
    endtry
endfunction

" `pos` is assumed a returned value from getpos()
function! crystal_lang#impl(file, pos, option_str) abort
    return crystal_lang#tool('implementations', a:file, a:pos, a:option_str)
endfunction

function! s:jump_to_impl(impl) abort
    execute 'edit' a:impl.filename
    call cursor(a:impl.line, a:impl.column)
endfunction

function! crystal_lang#jump_to_definition(file, pos) abort
    echo 'analyzing definitions under cursor...'

    let cmd_result = crystal_lang#impl(a:file, a:pos, '--format json')
    if cmd_result.failed
        return s:echo_error(cmd_result.output)
    endif

    let impl = s:decode_json(cmd_result.output)
    if impl.status !=# 'ok'
        return s:echo_error(impl.message)
    endif

    if len(impl.implementations) == 1
        call s:jump_to_impl(impl.implementations[0])
        return
    endif

    let message = "Multiple definitions detected.  Choose a number\n\n"
    for idx in range(len(impl.implementations))
        let i = impl.implementations[idx]
        let message .= printf("[%d] %s:%d:%d\n", idx, i.filename, i.line, i.column)
    endfor
    let message .= "\n"
    let idx = str2nr(input(message, "\n> "))
    call s:jump_to_impl(impl.implementations[idx])
endfunction

function! crystal_lang#context(file, pos, option_str) abort
    return crystal_lang#tool('context', a:file, a:pos, a:option_str)
endfunction

function! crystal_lang#type_hierarchy(file, option_str) abort
    let cmd = printf(
                \   '%s tool hierarchy --no-color %s %s',
                \   g:crystal_compiler_command,
                \   a:option_str,
                \   a:file
                \ )

    return s:run_cmd(cmd)
endfunction

function! s:find_completion_start() abort
    let c = col('.')
    if c <= 1
        return -1
    endif

    let line = getline('.')[:c-2]
    return match(line, '\w\+$')
endfunction

function! crystal_lang#complete(findstart, base) abort
    if a:findstart
        return s:find_completion_start()
    endif

    let cmd_result = crystal_lang#context(expand('%'), getpos('.'), '--format json')
    if cmd_result.failed
        return
    endif

    let contexts = s:decode_json(cmd_result.output)
    if contexts.status !=# 'ok'
        return
    endif

    let candidates = []

    for c in contexts.contexts
        for [name, desc] in items(c)
            let candidates += [{
                        \   'word': name,
                        \   'menu': ': ' . desc . ' [var]',
                        \ }]
        endfor
    endfor

    return candidates
endfunction

function! crystal_lang#get_spec_switched_path(absolute_path) abort
    let base = fnamemodify(a:absolute_path, ':t:r')

    " TODO: Make cleverer
    if base =~# '_spec$'
        let parent = fnamemodify(substitute(a:absolute_path, '/spec/', '/src/', ''), ':h')
        return parent . '/' . matchstr(base, '.\+\ze_spec$') . '.cr'
    else
        let parent = fnamemodify(substitute(a:absolute_path, '/src/', '/spec/', ''), ':h')
        return parent . '/' . base . '_spec.cr'
    endif
endfunction

function! crystal_lang#switch_spec_file(...) abort
    let path = a:0 == 0 ? expand('%:p') : fnamemodify(a:1, ':p')
    if path !~# '.cr$'
        return s:echo_error('Not crystal source file: ' . path)
    endif

    execute 'edit!' crystal_lang#get_spec_switched_path(path)
endfunction

function! s:run_spec(root, path, ...) abort
    " Note:
    " `crystal spec` can't understand absolute path.
    let cmd = printf(
            \   '%s spec %s%s',
            \   g:crystal_compiler_command,
            \   a:path,
            \   a:0 == 0 ? '' : (':' . a:1)
            \ )

    let saved_cwd = getcwd()
    let cd = haslocaldir() ? 'lcd' : 'cd'
    try
        execute cd a:root
        call s:C.echo(s:run_cmd(cmd))
    finally
        execute cd saved_cwd
    endtry
endfunction

function! crystal_lang#run_all_spec(...) abort
    let path = a:0 == 0 ? expand('%:p:h') : a:1
    let root_path = s:find_root_by_spec_and_src(path)
    if root_path ==# ''
        return s:echo_error("'spec' directory is not found")
    endif
    call s:run_spec(root_path, 'spec')
endfunction

function! crystal_lang#run_current_spec(...) abort
    " /foo/bar/src/poyo.cr
    let path = a:0 == 0 ? expand('%:p') : fnamemodify(a:1, ':p')
    if path !~# '.cr$'
        return s:echo_error('Not crystal source file: ' . path)
    endif

    " /foo/bar/src
    let source_dir = fnamemodify(path, ':h')

    " /foo/bar
    let root_dir = s:find_root_by_spec_and_src(source_dir)
    if root_dir ==# ''
        return s:echo_error("Root directory with 'src/' and 'spec/' not found")
    endif

    " src
    let rel_path = source_dir[strlen(root_dir)+1 : ]

    if path =~# '_spec.cr$'
        call s:run_spec(root_dir, path[strlen(root_dir)+1 : ], line('.'))
    else
        let spec_path = substitute(rel_path, '^src', 'spec', '') . '/' . fnamemodify(path, ':t:r') . '_spec.cr'
        if !filereadable(root_dir . '/' . spec_path)
            return s:echo_error('Error: Could not find a spec source corresponding to ' . path)
        endif
        call s:run_spec(root_dir, spec_path)
    endif
endfunction

function! crystal_lang#format_string(code, ...) abort
    let cmd = printf(
            \   '%s tool format --no-color %s -',
            \   g:crystal_compiler_command,
            \   get(a:, 1, '')
            \ )
    let output = s:P.system(cmd, a:code)
    if s:P.get_last_status()
        throw 'vim-crystal: Error on formatting: ' . output
    endif
    return output
endfunction

" crystal_lang#format(option_str [, on_save])
function! crystal_lang#format(option_str, ...) abort
    if !executable(g:crystal_compiler_command)
        " Finish command silently
        return
    endif

    let on_save = a:0 > 0 ? a:1 : 0

    let before = join(getline(1, '$'), "\n")
    let formatted = crystal_lang#format_string(before, a:option_str)
    if !on_save
        let after = substitute(formatted, '\n$', '', '')
        if before ==# after
            return
        endif
    endif

    let view_save = winsaveview()
    let pos_save = getpos('.')
    let lines = split(formatted, '\n')
    silent! undojoin
    if line('$') > len(lines)
        execute len(lines) . ',$delete' '_'
    endif
    call setline(1, lines)
    call winrestview(view_save)
    call setpos('.', pos_save)
endfunction

function! crystal_lang#expand(file, pos, ...) abort
    return crystal_lang#tool('expand', a:file, a:pos, get(a:, 1, ''))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

endif
