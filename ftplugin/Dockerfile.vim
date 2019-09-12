if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1

" Define comment string
setlocal commentstring=#\ %s

" Enable automatic comment insertion
setlocal formatoptions+=cro

function! DockerfileReplaceInstruction(original, replacement)
    let syn = synIDtrans(synID(line("."), col(".") - 1, 0))
    if syn != hlID("Comment") && syn != hlID("Constant") && strlen(getline(".")) == 0
        let word = a:replacement
    else
        let word = a:original
    endif
    let g:UnduBuffer = a:original
    return word
endfunction

inoreabbr <silent> <buffer> from <C-R>=DockerfileReplaceInstruction("from", "FROM")<CR>
inoreabbr <silent> <buffer> maintainer <C-R>=DockerfileReplaceInstruction("maintainer", "MAINTAINER")<CR>
inoreabbr <silent> <buffer> run <C-R>=DockerfileReplaceInstruction("run", "RUN")<CR>
inoreabbr <silent> <buffer> cmd <C-R>=DockerfileReplaceInstruction("cmd", "CMD")<CR>
inoreabbr <silent> <buffer> label <C-R>=DockerfileReplaceInstruction("label", "LABEL")<CR>
inoreabbr <silent> <buffer> expose <C-R>=DockerfileReplaceInstruction("expose", "EXPOSE")<CR>
inoreabbr <silent> <buffer> env <C-R>=DockerfileReplaceInstruction("env", "ENV")<CR>
inoreabbr <silent> <buffer> add <C-R>=DockerfileReplaceInstruction("add", "ADD")<CR>
inoreabbr <silent> <buffer> copy <C-R>=DockerfileReplaceInstruction("copy", "COPY")<CR>
inoreabbr <silent> <buffer> entrypoint <C-R>=DockerfileReplaceInstruction("entrypoint", "ENTRYPOINT")<CR>
inoreabbr <silent> <buffer> volume <C-R>=DockerfileReplaceInstruction("volume", "VOLUME")<CR>
inoreabbr <silent> <buffer> user <C-R>=DockerfileReplaceInstruction("user", "USER")<CR>
inoreabbr <silent> <buffer> workdir <C-R>=DockerfileReplaceInstruction("workdir", "WORKDIR")<CR>
inoreabbr <silent> <buffer> arg <C-R>=DockerfileReplaceInstruction("arg", "ARG")<CR>
inoreabbr <silent> <buffer> onbuild <C-R>=DockerfileReplaceInstruction("onbuild", "ONBUILD")<CR>
inoreabbr <silent> <buffer> stopsignal <C-R>=DockerfileReplaceInstruction("stopsignal", "STOPSIGNAL")<CR>

endif
