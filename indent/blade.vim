if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'blade') == -1

" Vim indent file
" Language:     Blade (Laravel)
" Maintainer:   Jason Walton <jwalton512@gmail.com>

if exists('b:did_indent')
    finish
endif

runtime! indent/html.vim
let s:htmlindent = &indentexpr

unlet! b:did_indent
runtime! indent/php.vim
let s:phpindent = &indentexpr

let b:did_indent = 1

" Doesn't include 'foreach' and 'forelse' because these already get matched by 'for'.
let s:directives_start = 'if\|else\|unless\|for\|while\|empty\|push\|section\|can\|hasSection\|verbatim\|php\|' .
            \ 'component\|slot\|prepend\|auth\|guest'
let s:directives_end = 'else\|end\|empty\|show\|stop\|append\|overwrite'

if exists('g:blade_custom_directives_pairs')
    let s:directives_start .= '\|' . join(keys(g:blade_custom_directives_pairs), '\|')
    let s:directives_end .= '\|' . join(values(g:blade_custom_directives_pairs), '\|')
endif

setlocal autoindent
setlocal indentexpr=GetBladeIndent()
exe 'setlocal indentkeys=o,O,<>>,!^F,0=}},0=!!},=@' . substitute(s:directives_end, '\\|', ',=@', 'g')

" Only define the function once.
if exists('*GetBladeIndent')
    finish
endif

function! s:IsStartingDelimiter(lnum)
    let line = getline(a:lnum)
    return line =~# '\%(\w\|@\)\@<!@\%(' . s:directives_start . '\)\%(.*@end\|.*@stop\)\@!'
                \ || line =~# '{{\%(.*}}\)\@!'
                \ || line =~# '{!!\%(.*!!}\)\@!'
                \ || line =~# '<?\%(.*?>\)\@!'
endfunction

function! GetBladeIndent()
    let lnum = prevnonblank(v:lnum - 1)
    if lnum == 0
        return 0
    endif

    let line = getline(lnum)
    let cline = getline(v:lnum)
    let indent = indent(lnum)

    " 1. Check for special directives
    " @section and @slot are single-line if they have a second argument.
    " @php is a single-line directive if it is followed by parentheses.
    if (line =~# '@\%(section\|slot\)\%(.*@end\)\@!' && line !~# '@\%(section\|slot\)\s*([^,]*)')
                \ || line =~# '@php\s*('
        return indent
    endif

    " 2. When the current line is an ending delimiter: decrease indentation
    "    if the previous line wasn't a starting delimiter.
    if cline =~# '^\s*@\%(' . s:directives_end . '\)'
                \ || cline =~# '\%(<?.*\)\@<!?>'
                \ || cline =~# '\%({{.*\)\@<!}}'
                \ || cline =~# '\%({!!.*\)\@<!!!}'
        return s:IsStartingDelimiter(lnum) ? indent : indent - &sw
    endif

    " 3. Increase indentation if the line contains a starting delimiter.
    if s:IsStartingDelimiter(lnum)
        return indent + &sw
    endif

    " 4. External indent scripts (PHP and HTML)
    execute 'let indent = ' . s:htmlindent

    if exists('*GetBladeIndentCustom')
        let indent = GetBladeIndentCustom()
    elseif line !~# '^\s*\%(#\|//\)\|\*/\s*$' && (
                \ searchpair('@include\%(If\)\?\s*(', '', ')', 'bWr') ||
                \ searchpair('{!!', '', '!!}', 'bWr') ||
                \ searchpair('{{', '', '}}', 'bWr') ||
                \ searchpair('<?', '', '?>', 'bWr') ||
                \ searchpair('@php\s*(\@!', '', '@endphp', 'bWr') )
        " Only use PHP's indent if the region spans multiple lines
        if !s:IsStartingDelimiter(v:lnum)
            execute 'let indent = ' . s:phpindent
        endif
    endif

    return indent
endfunction

endif
