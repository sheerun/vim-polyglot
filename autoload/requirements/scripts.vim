if polyglot#init#is_disabled(expand('<sfile>:p'), 'requirements', 'autoload/requirements/scripts.vim')
  finish
endif

""
" Refer $VIMRUNTIME/autoload/dist/script.vim in vim
" or $VIMRUNTIME/scripts.vim in neovim. When a file's shebang is like
" "pip install -r" or "pip-compile", set its filetype to |requirements|.
function! requirements#scripts#shabang() abort
    let s:line1 = getline(1)

    if s:line1 =~# "^#!"
        if s:line1 =~# '^#!\s*\S*\<env\s'
            let s:line1 = substitute(s:line1, '\S\+=\S\+', '', 'g')
            let s:line1 = substitute(s:line1, '\(-[iS]\|--ignore-environment\|--split-string\)', '', '')
            let s:line1 = substitute(s:line1, '\<env\s\+', '', '')
        endif
        if s:line1 =~# '^#!\s*\a:[/\\]'
            let s:name = substitute(s:line1, '^#!.*[/\\]\(\i\+\).*', '\1', '')
        elseif s:line1 =~# '^#!.*\<env\>'
            let s:name = substitute(s:line1, '^#!.*\<env\>\s\+\(\i\+\).*', '\1', '')
        elseif s:line1 =~# '^#!\s*[^/\\ ]*\>\([^/\\]\|$\)'
            let s:name = substitute(s:line1, '^#!\s*\([^/\\ ]*\>\).*', '\1', '')
        else
            let s:name = substitute(s:line1, '^#!\s*\S*[/\\]\(\i\+\).*', '\1', '')
        endif
        if s:name =~# '^pip'
            set ft=requirements
        endif
    endif
endfunction
" vim: et sw=4 ts=4 sts=4:
