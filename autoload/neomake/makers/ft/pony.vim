if polyglot#init#is_disabled(expand('<sfile>:p'), 'pony', 'autoload/neomake/makers/ft/pony.vim')
  finish
endif

function! neomake#makers#ft#pony#EnabledMakers()
    return ['ponyc']
endfunction

function! neomake#makers#ft#pony#ponyc()
    " This is currently a hack.  Ponyc itself uses the project directory as
    " the target to build.  Using %:p:h like this fetches the parent
    " directory of the current file which might cause supurious errors on
    " package imports if the current file is nested under a sub-directory.
    return {
        \ 'args': ['--pass=expr', '%:p:h'],
        \ 'errorformat': '%f:%l:%c: %m'
        \ }
endfunction
