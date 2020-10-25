if has_key(g:polyglot_is_disabled, 'fish')
  finish
endif

function! fish#Indent()
    let l:prevlnum = prevnonblank(v:lnum - 1)
    if l:prevlnum ==# 0
        return 0
    endif
    let l:prevline = getline(l:prevlnum)
    let l:line = getline(v:lnum)
    let l:shiftwidth = shiftwidth()
    let l:previndent = indent(l:prevlnum)
    let l:indent = l:previndent
    if l:prevline =~# '\v^\s*%(begin|if|else|while|for|function|switch|case)>'
        let l:indent += l:shiftwidth
    endif
    if l:line =~# '\v^\s*end>'
        let l:indent -= l:shiftwidth
        " If we're inside a case, dedent twice because it ends the switch.
        if l:prevline =~# '\v^\s*case>'
            " Previous line starts the case.
            let l:indent -= l:shiftwidth
        else
            " Scan back to a dedented line to find whether we're in a case.
            let l:i = l:prevlnum
            while l:i >= 1 && indent(l:i) >= l:previndent
                let l:i = prevnonblank(l:i - 1)
            endwhile
            if indent(l:i) < l:previndent && getline(l:i) =~# '\v^\s*case>'
                let l:indent -= l:shiftwidth
            endif
        endif
    elseif l:line =~# '\v^\s*else>'
        let l:indent -= l:shiftwidth
    elseif l:prevline !~# '\v^\s*switch>' && l:line =~# '\v^\s*case>'
        let l:indent -= l:shiftwidth
    endif
    if l:indent < 0
        return 0
    endif
    return l:indent
endfunction

function! fish#Format()
    if mode() =~# '\v^%(i|R)$'
        return 1
    else
        let l:command = v:lnum.','.(v:lnum+v:count-1).'!fish_indent'
        echo l:command
        execute l:command
    endif
endfunction

function! fish#Fold()
    let l:line = getline(v:lnum)
    if l:line =~# '\v^\s*%(begin|if|while|for|function|switch)>'
        return 'a1'
    elseif l:line =~# '\v^\s*end>'
        return 's1'
    else
        return '='
    end
endfunction

function! fish#Complete(findstart, base)
    if a:findstart
        return getline('.') =~# '\v^\s*$' ? -1 : 0
    else
        if empty(a:base)
            return []
        endif
        let l:results = []
        let l:completions =
                    \ system('fish -c "complete -C'.shellescape(a:base).'"')
        let l:cmd = substitute(a:base, '\v\S+$', '', '')
        for l:line in filter(split(l:completions, '\n'), 'len(v:val)')
            let l:tokens = split(l:line, '\t')
            call add(l:results, {'word': l:cmd.l:tokens[0],
                                \'abbr': l:tokens[0],
                                \'menu': get(l:tokens, 1, '')})
        endfor
        return l:results
    endif
endfunction

function! fish#errorformat()
    return '%Afish: %m,%-G%*\\ ^,%-Z%f (line %l):%s'
endfunction
