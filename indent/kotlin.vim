if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'kotlin') == -1

" Vim indent file
" Language: Kotlin
" Maintainer: Alexander Udalov
" Latest Revision: 26 May 2019

if exists('b:did_indent')
    finish
endif
let b:did_indent = 1

setlocal cinoptions& cinoptions+=j1,L0
setlocal indentexpr=GetKotlinIndent()
setlocal indentkeys=0},0),!^F,o,O,e,<CR>
setlocal autoindent " TODO ?

" TODO teach it to count bracket balance, etc.
function! GetKotlinIndent()
    if v:lnum == 0
        return 0
    endif

    let prev_num = prevnonblank(v:lnum - 1)
    let prev = getline(prev_num)
    let prev_indent = indent(prev_num)
    let cur = getline(v:lnum)

    if cur =~ '^\s*\*'
        return cindent(v:lnum)
    endif

    if prev =~ '^\s*\*/'
        let st = prev
        while st > 1
            if getline(st) =~ '^\s*/\*'
                break
            endif
            let st = st - 1
        endwhile
        return indent(st)
    endif

    let prev_open_paren = prev =~ '^.*(\s*$'
    let cur_close_paren = cur =~ '^\s*).*$'
    let prev_open_brace = prev =~ '^.*\({\|->\)\s*$'
    let cur_close_brace = cur =~ '^\s*}.*$'

    if prev_open_paren && !cur_close_paren || prev_open_brace && !cur_close_brace
        return prev_indent + &shiftwidth
    endif

    if cur_close_paren && !prev_open_paren || cur_close_brace && !prev_open_brace
        return prev_indent - &shiftwidth
    endif

    return prev_indent
endfunction

endif
