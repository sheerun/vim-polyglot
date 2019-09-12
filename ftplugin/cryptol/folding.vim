if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cryptol') == -1

" Copyright © 2013 Edward O'Callaghan. All Rights Reserved.

"setlocal foldmethod=indent
"setlocal foldignore=

setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum)

" Helper function: To tackle non-blank lines,
" wish to know their indentation level
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

" Helper function: .
function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction

function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

endif
