" Vim indent file, taken from indent/java.vim
" Language:	    Typescript
" Maintainer:	None!  Wanna improve this?
" Last Change:	2015 Mar 07

if get(g:, 'typescript_indent_disable')
  finish
endif

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" Use javascript cindent options
setlocal cindent cinoptions& cinoptions+=j1,J1
setlocal indentkeys&

" Load typescript indent function
setlocal indentexpr=GetTypescriptIndent()

let b:undo_indent = "setl cin< cino< indentkeys< indentexpr<"

" Only define the function once
if exists("*GetTypescriptIndent")
    finish
endif

" Make sure we have vim capabilities
let s:keepcpo = &cpo
set cpo&vim

function! TypescriptPrevNonBlankOrComment(lnum)
    let pnum = prevnonblank(a:lnum)
    " skip any comments (either `//`, `/*` or `*`)
    while getline(pnum) =~ '^\s*\(\/\/\|\/\*\|\*\)'
        let pnum = prevnonblank(pnum-1)
    endwhile
    return pnum
endfunction

function GetTypescriptIndent()

    " default value: trust cindent
    let ind = cindent(v:lnum)

    if getline(v:lnum) =~ '^\s*[{}\*]'
        return ind
    endif

    " The last non-empty line
    let prev = TypescriptPrevNonBlankOrComment(v:lnum-1)

    " Check if the previous line consists of a single `<variable> : <type>;`
    " declaration (e.g. in interface definitions)
    if getline(prev) =~ '^\s*\w\+\s*:[^{]\+;\s*$'
        return indent(prev)
    endif

    " If a variable was declared and the semicolon omitted, do not indent
    " the next line
    if getline(prev) =~ '^\s*var\s\+\w\+'
        return indent(prev)
    endif

    " Try to find out whether the last `}` ended a `<variable> : {` block
    if getline(prev) =~ '};\s*$'
        " jump to matching `{` bracket
        call cursor(prev, 1)
        silent normal %

        " See if current line is type annotation without closing ';' but open
        " `{` bracket
        let lnum = line('.')
        if getline(lnum) =~ '^\s*\w\+\s*:[^;]\+{'
            let ind = indent(lnum)
        endif
    endif

    return ind

endfunction

" Restore compatibility mode
let &cpo = s:keepcpo
unlet s:keepcpo

" vim: et
