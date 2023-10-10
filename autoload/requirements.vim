if polyglot#init#is_disabled(expand('<sfile>:p'), 'requirements', 'autoload/requirements.vim')
  finish
endif

""
" Refer https://github.com/vim/vim/blob/75e27d78f5370e7d2e0898326d9b080937e7b090/runtime/scripts.vim#L33-L71
"
" When a file's shebang is "pip install -r" or "pip-compile",
" set its filetype to |requirements|.
function! requirements#shebang() abort
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
