if polyglot#init#is_disabled(expand('<sfile>:p'), 'org', 'autoload/org.vim')
  finish
endif

" Helper functions for org.vim
"
" Maintainer:   Alex Vear <alex@vear.uk>
" License:      Vim (see `:help license`)
" Location:     autoload/org.vim
" Website:      https://github.com/axvr/org.vim
" Last Change:  2020-01-04

" Fallback chain for options. Buffer local --> Global --> default.
function org#option(name, default) abort
    return get(b:, a:name, get(g:, a:name, a:default))
endfunction

" Emacs-like fold text.
function org#fold_text() abort
    return getline(v:foldstart) . '...'
endfunction

" Check fold depth of a line.
function org#fold_expr()
    let l:depth = match(getline(v:lnum), '\(^\*\+\)\@<=\( .*$\)\@=')
    if l:depth > 0 && synIDattr(synID(v:lnum, 1, 1), 'name') =~# '\m^o\(rg\|utline\)Heading'
        return ">" . l:depth
    endif
    return "="
endfunction
