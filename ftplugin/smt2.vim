let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'ftplugin/smt2.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'smt2') == -1

setlocal iskeyword+=-,:,#,',$

" If no command for invoking a solver is specified in ~/.vimrc, test if either
" 'z3' or 'boolector' is accessible through $PATH (in that order)
if !exists("g:smt2_solver_command")
    if executable("z3")
        let g:smt2_solver_command = "z3"
    elseif executable("boolector")
        let g:smt2_solver_command = "boolector"
    endif
endif

" If no command line switch for printing the solver's version is specified in
" ~/.vimrc, use '--version'
if !exists("g:smt2_solver_version_switch")
    let g:smt2_solver_version_switch = "--version"
endif

" Mappings
nnoremap <silent> <buffer> <localleader>r :call smt2#RunSolver()<cr>
nnoremap <silent> <buffer> <localleader>R :call smt2#RunSolverAndShowResult()<cr>
nnoremap <silent> <buffer> <localleader>v :call smt2#PrintSolverVersion()<cr>

" Comment String
setlocal commentstring=;%s

endif
