if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1

" common functions for vifm plugin related to globals
" Maintainer:  xaizek <xaizek@posteo.net>
" Last Change: November 03, 2018

" Initializes global variables to defaults unless they are already set
function! vifm#globals#Init()
    if !exists('g:vifm_exec')
        let g:vifm_exec = 'vifm'
    endif

    if !exists('g:vifm_exec_args')
        let g:vifm_exec_args = ''
    endif

    if !exists('g:vifm_term')
        if has('win32')
            if filereadable('C:\Windows\system32\cmd.exe')
                let g:vifm_term = 'C:\Windows\system32\cmd.exe /C'
            else
                " If don't find use the integrate shell it work too
                let g:vifm_term = ''
            endif
        else
            let g:vifm_term = 'xterm -e'
        endif
    endif

    if !exists('g:vifm_embed_term')
        let g:vifm_embed_term = has('gui_running')
    endif
endfunction

endif
