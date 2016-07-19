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

" Doesn't include 'foreach' and 'forelse' because these already get matched by 'for'.
let s:directives_start = 'if\|else\|unless\|for\|while\|empty\|push\|section\|can\|hasSection\|verbatim'
let s:directives_end = 'else\|end\|empty\|show\|stop\|append\|overwrite'

if exists('g:blade_custom_directives_pairs')
    let s:directives_start .= '\|' . join(keys(g:blade_custom_directives_pairs), '\|')
    let s:directives_end .= '\|' . join(values(g:blade_custom_directives_pairs), '\|')
endif

setlocal autoindent
setlocal indentexpr=GetBladeIndent()
exe "setlocal indentkeys=o,O,<>>,!^F,0=}},0=!!},=@" . substitute(s:directives_end, '\\|', ',=@', 'g')

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
    if cline =~# '@\%(' . s:directives_end . '\)' ||
                \ cline =~# '\%(<?.*\)\@<!?>\|\%({{.*\)\@<!}}\|\%({!!.*\)\@<!!!}'
        let indent = indent - &sw
    elseif line =~# '<?\%(.*?>\)\@!\|@php\%(\s*(\)\@!'
        let indent = indent + &sw
    else
        if exists("*GetBladeIndentCustom")
            let hindent = GetBladeIndentCustom()
        " Don't use PHP indentation if line is a comment
        elseif line !~# '^\s*\%(#\|//\)\|\*/\s*$' && (
                    \ searchpair('@include\%(If\)\?\s*(', '', ')', 'bWr') ||
                    \ searchpair('{!!', '', '!!}', 'bWr') ||
                    \ searchpair('{{', '', '}}', 'bWr') ||
                    \ searchpair('<?', '', '?>', 'bWr') ||
                    \ searchpair('@php\%(\s*(\)\@!', '', '@endphp', 'bWr') )
            execute 'let hindent = ' . s:phpindent
        else
            execute 'let hindent = ' . s:htmlindent
        endif
        if hindent > -1
            let indent = hindent
        endif
    endif
    let increase = indent + &sw

    if line =~# '@\%(section\)\%(.*@end\)\@!' && line !~# '@\%(section\)\s*([^,]*)'
        return indent
    elseif line =~# '@\%(' . s:directives_start . '\)\%(.*@end\|.*@stop\)\@!' ||
                \ line =~# '{{\%(.*}}\)\@!' || line =~# '{!!\%(.*!!}\)\@!'
        return increase
    else
        return indent
    endif
endfunction

endif
