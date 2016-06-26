if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'blade') == -1
  
" Vim indent file
" Language:     Blade (Laravel)
" Maintainer:   Jason Walton <jwalton512@gmail.com>

if exists("b:did_indent")
    finish
endif

runtime! indent/html.vim
let s:htmlindent = &indentexpr
unlet! b:did_indent

runtime! indent/php.vim
let s:phpindent = &indentexpr
unlet! b:did_indent

let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetBladeIndent()
setlocal indentkeys=o,O,*<Return>,<>>,!^F,=@else,=@end,=@empty,=@show,=@stop

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
    if cline =~# '@\%(else\|elseif\|empty\|end\|show\|stop\)' ||
                \ cline =~# '\%(<?.*\)\@<!?>\|\%({{.*\)\@<!}}\|\%({!!.*\)\@<!!!}'
        let indent = indent - &sw
    else
        if exists("*GetBladeIndentCustom")
            let hindent = GetBladeIndentCustom()
        elseif searchpair('@include\s*(', '', ')', 'bWr') ||
                    \ searchpair('{!!', '', '!!}', 'bWr') ||
                    \ searchpair('{{', '', '}}', 'bWr') ||
                    \ searchpair('<?', '', '?>', 'bWr')
            execute 'let hindent = ' . s:phpindent
        else
            execute 'let hindent = ' . s:htmlindent
        endif
        if hindent > -1
            let indent = hindent
        endif
    endif
    let increase = indent + &sw
    if indent = indent(lnum)
        let indent = cindent <= indent ? -1 : increase
    endif

    if line =~# '@\%(section\)\%(.*@end\)\@!' && line !~# '@\%(section\)\s*([^,]*)'
        return indent
    elseif line =~# '@\%(if\|elseif\|else\|unless\|foreach\|forelse\|for\|while\|empty\|push\|section\|can\|hasSection\)\%(.*@end\|.*@stop\)\@!' ||
                \ line =~# '{{\%(.*}}\)\@!' || line =~# '{!!\%(.*!!}\)\@!'
        return increase
    elseif line =~# '<?\%(.*?>\)\@!'
        return indent(lnum-1) == -1 ? increase : indent(lnum) + increase
    else
        return indent
    endif
endfunction

endif
