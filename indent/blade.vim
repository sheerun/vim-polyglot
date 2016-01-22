if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'blade') == -1
  
" Vim indent file
" Language:     Blade (Laravel)
" Maintainer:   Jason Walton <jwalton512@gmail.com>

if exists("b:did_indent")
    finish
endif
runtime! indent/html.vim
unlet! b:did_indent
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetBladeIndent()
setlocal indentkeys=o,O,*<Return>,<>>,!^F,=@else,=@end,=@empty

" Only define the function once.
if exists("*GetBladeIndent")
    finish
endif

function! GetBladeIndent()
    let lnum = prevnonblank(v:lnum-1)
    if lnum == 0
        return 0
    endif

    let line = substitute(substitute(getline(lnum), '\s\+$', '', ''), '^\s\+', '', '')
    let cline = substitute(substitute(getline(v:lnum), '\s\+$', '', ''), '^\s\+', '', '')
    let indent = indent(lnum)
    let cindent = indent(v:lnum)
    if cline =~# '@\%(else\|elseif\|empty\|end\)'
        let indent = cindent < indent ? cindent : indent - &sw
    elseif HtmlIndent() > -1
        let indent = HtmlIndent()
    endif
    let increase = indent + &sw
    if indent = indent(lnum)
        let indent = cindent <= indent ? -1 : increase
    endif

    if line =~# '@\%(if\|elseif\|else\|unless\|foreach\|forelse\|for\|while\)\%(.*\s*@end\)\@!'
        return increase
    else
        return indent
    endif
endfunction

endif
