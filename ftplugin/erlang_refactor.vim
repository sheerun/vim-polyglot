" Erlang refactor file
" Language:   Erlang
" Maintainer: Pawel 'kTT' Salata <rockplayer.pl@gmail.com>
" URL:        http://ktototaki.info

if exists("b:did_ftplugin_erlang")
    finish
endif

" Don't load any other
let b:did_ftplugin_erlang=1

if !exists('g:erlangRefactoring') || g:erlangRefactoring == 0
    finish
endif

if !exists('g:erlangWranglerPath')
    let g:erlangWranglerPath = '/usr/share/wrangler/'
endif

if glob(g:erlangWranglerPath) == ""
    call confirm("Wrong path to wrangler dir")
    finish
endif

autocmd VimLeavePre * call StopWranglerServer()

let s:erlangServerName = "wrangler_vim"

" Starting background erlang session with wrangler on
function! StartWranglerServer()
    let wranglerEbinDir = g:erlangWranglerPath . "/ebin"
    let command = "erl_call -s -sname " . s:erlangServerName . " -x 'erl -pa " . wranglerEbinDir . "'"
    call system(command)
    call s:send_rpc('application', 'start', '[wrangler_app]')
endfunction

" Stopping erlang session
function! StopWranglerServer()
    echo s:send_rpc('erlang', 'halt', '')
endfunction

" Sending rpc call to erlang session
function! s:send_rpc(module, fun, args)
    let command = "erl_call -sname " . s:erlangServerName . " -a '" . a:module . " " . a:fun . " " . a:args . "'"
    let result = system(command)
    if match(result, 'erl_call: failed to connect to node .*') != -1
        call StartWranglerServer()
        return system(command)
    endif
    return result
endfunction

function! ErlangUndo()
    echo s:send_rpc("wrangler_undo_server", "undo", "[]")
    :e!
endfunction

function! s:trim(text)
    return substitute(a:text, "^\\s\\+\\|\\s\\+$", "", "g")
endfunction

function! s:get_msg(result, tuple_start)
    let msg_begin = '{' . a:tuple_start . ','
    let matching_start =  match(a:result, msg_begin)
    if matching_start != -1
        return s:trim(matchstr(a:result, '[^}]*', matching_start + strlen(msg_begin)))
    endif
    return ""
endfunction

" Check if there is an error in result
function! s:check_for_error(result)
    let msg = s:get_msg(a:result, 'ok')
    if msg != ""
        return [0, msg]
    endif
    let msg = s:get_msg(a:result, 'warning')
    if msg != ""
        return [1, msg]
    endif
    let msg = s:get_msg(a:result, 'error')
    if msg != ""
        return [2, msg]
    endif
    return [-1, ""]
endfunction

" Sending apply changes to file
function! s:send_confirm()
    let choice = confirm("What do you want?", "&Preview\n&Confirm\nCa&ncel", 0)
    if choice == 1
        echo "TODO: Display preview :)"
    elseif choice == 2
        let module = 'wrangler_preview_server'
        let fun = 'commit'
        let args = '[]'
        return s:send_rpc(module, fun, args)
    else
        let module = 'wrangler_preview_server'
        let fun = 'abort'
        let args = '[]'
        return s:send_rpc(module, fun, args)
        echo "Canceled"
    endif
endfunction

" Manually send confirm, for testing purpose only
function! SendConfirm()
    echo s:send_confirm()
endfunction

" Format and send function extracton call
function! s:call_extract(start_line, start_col, end_line, end_col, name)
    let file = expand("%:p")
    let module = 'wrangler'
    let fun = 'fun_extraction'
    let args = '["' . file . '", {' . a:start_line . ', ' . a:start_col . '}, {' . a:end_line . ', ' . a:end_col . '}, "' . a:name . '", ' . &sw . ']'
    let result = s:send_rpc(module, fun, args)
    let [error_code, msg] = s:check_for_error(result)
    if error_code != 0
        call confirm(msg)
        return 0
    endif
    echo "This files will be changed: " . matchstr(msg, "[^]]*", 1)
    echo s:send_confirm()
    return 1
endfunction

function! ErlangExtractFunction(mode) range
    silent w!
    let name = inputdialog("New function name: ")
    if name != ""
        if a:mode == "v"
            let start_pos = getpos("'<")
            let start_line = start_pos[1]
            let start_col = start_pos[2]

            let end_pos = getpos("'>")
            let end_line = end_pos[1]
            let end_col = end_pos[2]
        elseif a:mode == "n"
            let pos = getpos(".")
            let start_line = pos[1]
            let start_col = pos[2]
            let end_line = pos[1]
            let end_col = pos[2]
        else
            echo "Mode not supported."
            return
        endif
        if s:call_extract(start_line, start_col, end_line, end_col, name)
            let temp = &autoread
            set autoread
            :e
            if temp == 0
                set noautoread
            endif
        endif
    else
        echo "Empty function name. Ignoring."
    endif
endfunction
nmap <A-r>e :call ErlangExtractFunction("n")<ENTER>
vmap <A-r>e :call ErlangExtractFunction("v")<ENTER>

function! s:call_rename(mode, line, col, name, search_path)
    let file = expand("%:p")
    let module = 'wrangler'
    let fun = 'rename_' . a:mode
    let args = '["' . file .'", '
    if a:mode != "mod"
         let args = args . a:line . ', ' . a:col . ', '
    endif
    let args = args . '"' . a:name . '", ["' . a:search_path . '"], ' . &sw . ']'
    let result = s:send_rpc(module, fun, args)
    let [error_code, msg] = s:check_for_error(result)
    if error_code != 0
        call confirm(msg)
        return 0
    endif
    echo "This files will be changed: " . matchstr(msg, "[^]]*", 1)
    echo s:send_confirm()
    return 1
endfunction

function! ErlangRename(mode)
    silent w!
    if a:mode == "mod"
        let name = inputdialog('Rename module to: ')
    else
        let name = inputdialog('Rename "' . expand("<cword>") . '" to: ')
    endif
    if name != ""
        let search_path = expand("%:p:h")
        "let search_path = inputdialog('Search path: ', expand("%:p:h"))
        let pos = getpos(".")
        let line = pos[1]
        let col = pos[2]
        let current_filename = expand("%")
        let current_filepath = expand("%:p")
        let new_filename = name . '.erl'
        if s:call_rename(a:mode, line, col, name, search_path)
            if a:mode == "mod"
                execute ':bd ' . current_filename
                execute ':e ' . new_filename
                silent execute '!mv ' . current_filepath . ' ' . current_filepath . '.bak'
                redraw!
            else
                let temp = &autoread
                set autoread
                :e
                if temp == 0
                    set noautoread
                endif
            endif
        endif
    else
        echo "Empty name. Ignoring."
    endif
endfunction

function! ErlangRenameFunction()
    call ErlangRename("fun")
endfunction
map <A-r>f :call ErlangRenameFunction()<ENTER>

function! ErlangRenameVariable()
    call ErlangRename("var")
endfunction
map <A-r>v :call ErlangRenameVariable()<ENTER>

function! ErlangRenameModule()
    call ErlangRename("mod")
endfunction
map <A-r>m :call ErlangRenameModule()<ENTER>

function! ErlangRenameProcess()
    call ErlangRename("process")
endfunction
map <A-r>p :call ErlangRenameProcess()<ENTER>

function! s:call_tuple_fun_args(start_line, start_col, end_line, end_col, search_path)
    let file = expand("%:p")
    let module = 'wrangler'
    let fun = 'tuple_funpar'
    let args = '["' . file . '", {' . a:start_line . ', ' . a:start_col . '}, {' . a:end_line . ', ' . a:end_col . '}, ["' . a:search_path . '"], ' . &sw . ']'
    let result = s:send_rpc(module, fun, args)
    if s:check_for_error(result)
        return 0
    endif
    call s:send_confirm()
    return 1
endfunction

function! ErlangTupleFunArgs(mode)
    silent w!
    let search_path = expand("%:p:h")
    "let search_path = inputdialog('Search path: ', expand("%:p:h"))
    if a:mode == "v"
        let start_pos = getpos("'<")
        let start_line = start_pos[1]
        let start_col = start_pos[2]

        let end_pos = getpos("'>")
        let end_line = end_pos[1]
        let end_col = end_pos[2]
        if s:call_tuple_fun_args(start_line, start_col, end_line, end_col, search_path)
            let temp = &autoread
            set autoread
            :e
            if temp == 0
                set noautoread
            endif
        endif
    elseif a:mode == "n"
        let pos = getpos(".")
        let line = pos[1]
        let col = pos[2]
        if s:call_tuple_fun_args(line, col, line, col, search_path)
            let temp = &autoread
            set autoread
            :e
            if temp == 0
                set noautoread
            endif
        endif
    else
        echo "Mode not supported."
    endif
endfunction
nmap <A-r>t :call ErlangTupleFunArgs("n")<ENTER>
vmap <A-r>t :call ErlangTupleFunArgs("v")<ENTER>

" vim: set foldmethod=marker:
