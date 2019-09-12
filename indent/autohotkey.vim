if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'autohotkey') == -1

" Vim indent file
" Language:   AutoHotkey
" Maintainer: Hirotoshi Namikawa <hnamikaw1@gmail.com>
" URL:        http://github.com/hnamikaw/vim-autohotkey
" License:    Same as Vim.

if exists('b:did_indent')
    finish
endif

setlocal autoindent
setlocal indentexpr=GetAutoHotkeyIndent()
setlocal indentkeys=!^F,o,O,0{,0},=if,=else,=return
setlocal expandtab

let b:undo_indent = 'setlocal '.join([
            \   'autoindent<',
            \   'indentexpr<',
            \   'indentkeys<',
            \   'expandtab<',
            \ ])

let s:TRUE = !0
let s:FALSE = 0

" Check BEGIN BLOCK
" TRUE:
" {
" { ; with comment
" if {
" if { ; with comment
"
" FALSE:
" ; if { comment
" sleep 1000 ; {
function! IsBeginBlockByStr(str)
    return a:str =~? '^[^;]*{\s*\(;.*\)\?$' ? s:TRUE : s:FALSE
endfunction

" Check END BLOCK
" TRUE:
" }
" } ; with comment
" } else {
" } else { ; with comment
"
" FALSE:
" ; } else {
function! IsEndBlockByStr(str)
    return a:str =~? '^\s*}.*\(;.*\)\?$' ? s:TRUE : s:FALSE
endfunction

" Check DOUBLE CORON
" TRUE:
" LAlt up::
" LAlt up:: ; with comment
"
" FALSE:
" ; LAlt up::
" sleep 1000 ; ::
function! IsDoubleCoronByStr(str)
    return a:str =~? '^[^;]*::\s*\(;.*\)\?$' ? s:TRUE : s:FALSE
endfunction

" Check RETURN
" TRUE:
" return
" return 1
" return ; with comment
"
" FALSE:
" ; return
function! IsReturnByStr(str)
    return a:str =~? '^\s*return.*\(;.*\)\?$' ? s:TRUE : s:FALSE
endfunction

" Check IF STATEMENT(without BLOCK)
" TRUE:
" if
" if ; with comment
" else
" else ; with comment
"
" FALSE:
" if {
" else {
function! IsIfStatementByStr(str)
    return a:str =~? '^\s*\(if\|else\)[^{]*\(;.*\)\?$' ? s:TRUE : s:FALSE
endfunction

" Check inside of BLOCK.
" TRUE:
" if {
"     hogehoge
"     fugafuga <--- line_num
" }
"
" FALSE:
" foobar <--- line_num
function! IsInsideOfBlockByNum(line_num)
    let block_indent_level = 0

    for scan_line_num in range(1, a:line_num)
        if IsBeginBlockByStr(getline(scan_line_num)) == s:TRUE
            let block_indent_level += 1
        endif

        if IsEndBlockByStr(getline(scan_line_num)) == s:TRUE
            let block_indent_level -= 1
        endif
    endfor

    return block_indent_level >= 1 ? s:TRUE : s:FALSE
endfunction

function! AddIndentByInd(indent)
    return a:indent + &l:shiftwidth
endfunction

function! UnIndentByInd(indent)
    return a:indent - &l:shiftwidth
endfunction

function! GetAutoHotkeyIndent()
    let  l0_num = v:lnum
    let  l1_num = v:lnum - 1
    let pl1_num = prevnonblank(l1_num)
    let pl2_num = prevnonblank(pl1_num - 1)

    let  l0_str = getline(l0_num)
    let pl1_str = getline(pl1_num)
    let pl2_str = getline(pl2_num)
    let pl1_ind = indent(pl1_num)
    let pl2_ind = indent(pl2_num)

    " Case: Next line of IF STATEMENT(without BLOCK)
    " if bar = 1
    "     callFunc1() <--- AddIndent
    "
    " if bar = 1
    " { <--- No! AddIndent
    if IsIfStatementByStr(pl1_str) == s:TRUE && IsBeginBlockByStr(l0_str) == s:FALSE
        return AddIndentByInd(pl1_ind)
    endif

    " Case: End of IF STATEMENT(without BLOCK)
    " if bar = 1
    "     callFunc1()
    " if bar = 2 <--- UnIndent
    "
    " Case: End of IF STATEMENT(without BLOCK) and END BLOCK(of outer block)
    " if foo
    " {
    "     if bar = 3
    "         callFunc3()
    " } <--- UnIndent (2level)
    if IsIfStatementByStr(pl2_str) == s:TRUE && IsBeginBlockByStr(pl1_str) == s:FALSE
        if IsEndBlockByStr(l0_str) == s:FALSE
            return UnIndentByInd(pl1_ind)
        else
            return UnIndentByInd(pl2_ind)
        endif
    endif

    " Case: Next line of BEGIN BLOCK
    " Swap(ByRef Left, ByRef Right)
    " {
    "     temp := Left <--- AddIndent
    "     Left := Right
    "     Right := temp
    " }
    if IsBeginBlockByStr(pl1_str) == s:TRUE
        return AddIndentByInd(pl1_ind)
    endif

    " Case: END BLOCK
    " Swap(ByRef Left, ByRef Right)
    " {
    "     temp := Left
    "     Left := Right
    "     Right := temp
    " } <--- UnIndent
    if IsEndBlockByStr(l0_str) == s:TRUE
        return UnIndentByInd(pl1_ind)
    endif

    " Case: Next line of DOUBLE CORON
    " #n::
    "     Run Notepad <--- AddIndent
    " return
    if IsDoubleCoronByStr(pl1_str) == s:TRUE
        return AddIndentByInd(pl1_ind)
    endif

    " Case: RETURN
    " Note: It is not nothing if in the BLOCK.
    " #n::
    "     Run Notepad
    " return <--- UnIndent
    " ~~~
    " if foo
    " {
    "     callFunc1()
    "     return <--- No! UnIndent
    " }
    if IsReturnByStr(l0_str) == s:TRUE && IsInsideOfBlockByNum(l0_num) == s:FALSE
        return UnIndentByInd(pl1_ind)
    endif

    " Case: Top line.
    if pl1_num == 0
        return 0
    endif

    " Case: It does not match anything.
    return pl1_ind
endfunction

let b:did_indent = 1

endif
