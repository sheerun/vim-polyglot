" Erlang compiler file
" Language:   Erlang
" Maintainer: Pawel 'kTT' Salata <rockplayer.pl@gmail.com>
" URL:        http://ktototaki.info

if exists("current_compiler")
    finish
endif
let current_compiler = "erlang"

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

if !exists('g:erlangCheckFile')
    let g:erlangCheckFile = "~/.vim/compiler/erlang_check_file.erl"
endif

if !exists('g:erlangHighlightErrors')
    let g:erlangHighlightErrors = 0
endif

let b:error_list = {}
let b:is_showing_msg = 0

function! HighlightErlangErrors()
    if match(getline(1), "#!.*escript") != -1
        setlocal makeprg=escript\ -s\ %
    else
        execute "setlocal makeprg=" . g:erlangCheckFile . "\\ \%"
    endif
    silent make!
    call s:clear_matches()
    for error in getqflist()
        let item = {}
        let item['lnum'] = error.lnum
        let item['msg'] = error.text
        let b:error_list[error.lnum] = item
        call matchadd('SpellBad', "\\%" . error.lnum . "l")
    endfor
    if len(getqflist())
        redraw!
    endif
    call s:show_msg()
    setlocal makeprg=erlc\ %
endfunction

function! s:show_msg()
    let pos = getpos(".")
    if has_key(b:error_list, pos[1])
        let item = get(b:error_list, pos[1])
        echo item.msg
        let b:is_showing_msg = 1
    else
        if exists("b:is_showing_msg") && b:is_showing_msg == 1
            echo
            let b:is_showing_msg = 0
        endif
    endif
endf

function! s:clear_matches()
    call clearmatches()
    let b:error_list = {}
    if exists("b:is_showing_msg") && b:is_showing_msg == 1
        echo
        let b:is_showing_msg = 0
    endif
endfunction

CompilerSet makeprg=erlc\ %
CompilerSet errorformat=%f:%l:\ %tarning:\ %m,%E%f:%l:\ %m

if g:erlangHighlightErrors
    autocmd BufLeave *.erl call s:clear_matches()
    autocmd BufEnter *.erl call s:clear_matches()
    autocmd BufWritePost *.erl call HighlightErlangErrors()
    autocmd CursorHold *.erl call s:show_msg()
    autocmd CursorMoved *.erl call s:show_msg()
endif
