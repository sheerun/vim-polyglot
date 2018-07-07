if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rust') == -1
  
function! cargo#Load() 
    " Utility call to get this script loaded, for debugging
endfunction

function! cargo#cmd(args)
    execute "! cargo" a:args
endfunction

function! s:nearest_cargo(...) abort
    " If the second argument is not specified, the first argument determines
    " whether we will start from the current directory or the directory of the
    " current buffer, otherwise, we start with the provided path on the 
    " second argument.

    let l:is_getcwd = get(a:, 1, 0)
    if l:is_getcwd 
        let l:starting_path = get(a:, 2, getcwd())
    else
        let l:starting_path = get(a:, 2, expand('%:p:h'))
    endif

    return findfile('Cargo.toml', l:starting_path . ';')
endfunction

function! cargo#nearestCargo(is_getcwd) abort
    return s:nearest_cargo(a:is_getcwd)
endfunction

function! cargo#nearestWorkspaceCargo(is_getcwd) abort
    let l:nearest = s:nearest_cargo(a:is_getcwd)
    while l:nearest !=# ''
        for l:line in readfile(l:nearest, '', 0x100)
            if l:line =~# '\V[workspace]'
                return l:nearest
            endif
        endfor
        let l:next = fnamemodify(l:nearest, ':p:h:h')
        let l:nearest = s:nearest_cargo(0, l:next)
    endwhile
    return ''
endfunction

function! cargo#nearestRootCargo(is_getcwd) abort
    " Try to find a workspace Cargo.toml, and if not found, take the nearest
    " regular Cargo.toml
    let l:workspace_cargo = cargo#nearestWorkspaceCargo(a:is_getcwd)
    if l:workspace_cargo !=# ''
        return l:workspace_cargo
    endif
    return s:nearest_cargo(a:is_getcwd)
endfunction


function! cargo#build(args)
    call cargo#cmd("build " . a:args)
endfunction

function! cargo#clean(args)
    call cargo#cmd("clean " . a:args)
endfunction

function! cargo#doc(args)
    call cargo#cmd("doc " . a:args)
endfunction

function! cargo#new(args)
    call cargo#cmd("new " . a:args)
    cd `=a:args`
endfunction

function! cargo#init(args)
    call cargo#cmd("init " . a:args)
endfunction

function! cargo#run(args)
    call cargo#cmd("run " . a:args)
endfunction

function! cargo#test(args)
    call cargo#cmd("test " . a:args)
endfunction

function! cargo#bench(args)
    call cargo#cmd("bench " . a:args)
endfunction

" vim: set et sw=4 sts=4 ts=8:

endif
