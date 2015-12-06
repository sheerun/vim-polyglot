if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elm') == -1
  
" Vim indent file
" Language:     Haskell
" Maintainer:   lilydjwg <lilydjwg@gmail.com>
" Version:	1.0
" References:	http://en.wikibooks.org/wiki/Haskell/Indentation
" 		http://book.realworldhaskell.org/read/
" See Also:	The Align plugin http://www.vim.org/scripts/script.php?script_id=294

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=HaskellIndent()
for i in split('0{,:,0#,e', ',')
    exec "setlocal indentkeys-=" . i
endfor
setlocal indentkeys+=0=else,0=in,0=where,0),0<bar>
setlocal tabstop=8
setlocal expandtab

if !exists('g:Haskell_no_mapping')
    inoremap <silent> <BS> <C-R>=<SID>HaskellDedent(1)<CR>
    inoremap <silent> <C-D> <C-R>=<SID>HaskellDedent(0)<CR>
endif

" Only define the functions once.
if exists("*HaskellIndent")
    finish
endif

let s:align_map = {
            \ 'in': '\<let\>',
            \ '\<else\>': '\<then\>',
            \ ',': '\v%(\s|\w|^)@<=[[{]%(\s|\w|"|$)@='
            \ }
let s:indent_self = ['=']
let s:indent_next = ['let', 'in', 'where', 'do', 'if']
let s:indent_if_final = ['=', 'do', '->', 'of', 'where']

function HaskellIndent()
    let lnum = v:lnum - 1

    " Hit the start of the file, use zero indent.
    if lnum == 0
        return 0
    endif

    let ind = indent(lnum)
    let prevline = getline(lnum)
    let curline = getline(v:lnum)
    let curwords = split(curline)
    if len(curwords) > 0
        if has_key(s:align_map, curwords[0])
            let word = s:align_map[curwords[0]]
            let m = -1
            let line = v:lnum
            while m == -1
                let line -= 1
                if line <= 0
                    return -1
                endif
                let m = match(getline(line), word)
            endwhile
            return m
        elseif index(s:indent_self, curwords[0]) != -1
            return ind + &sw
        elseif curwords[0] == '|'
            return match(prevline, '\v%(\s|\w|^)@<=[|=]%(\s|\w)@=')
        elseif index([')', '}'], curwords[0]) != -1
            return ind - &sw
        elseif curwords[0] == 'where'
            if prevline =~ '\v^\s+\|%(\s|\w)@='
                return ind - 1
            endif
        endif
    endif

    let prevwords = split(prevline)
    if len(prevwords) == 0
        return 0
    endif

    if prevwords[-1] == 'where' && prevwords[0] == 'module'
        return 0
    elseif index(s:indent_if_final, prevwords[-1]) != -1
        return ind + &sw
    elseif prevwords[-1] =~ '\v%(\s|\w|^)@<=[[{(]$'
        return ind + &sw
    else
        for word in reverse(prevwords)
            if index(s:indent_next, word) != -1
                return match(prevline, '\<'.word.'\>') + len(word) + 1
            endif
        endfor
    endif

    if len(curwords) > 0 && curwords[0] == 'where'
        return ind + &sw
    endif

    return ind
endfunction

function s:HaskellDedent(isbs)
    if a:isbs && strpart(getline('.'), 0, col('.')-1) !~ '^\s\+$'
        return "\<BS>"
    endif

    let curind = indent('.')
    let line = line('.') - 1
    while curind > 0 && line > 0
        let ind = indent(line)
        if ind >= curind
            let line -= 1
        else
            echomsg curind ind
            call setline('.', repeat(' ', ind) .
                        \ substitute(getline('.'), '^\s\+', '', ''))
            return ''
        endif
    endwhile
    return a:isbs ? "\<BS>" : ''
endfunction

endif
