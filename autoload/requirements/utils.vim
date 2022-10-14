if polyglot#init#is_disabled(expand('<sfile>:p'), 'requirements', 'autoload/requirements/utils.vim')
  finish
endif

""
" @section Configuration, config

function! s:Flag(name, default) abort
    let l:scope = get(split(a:name, ':'), 0, 'g:')
    let l:name = get(split(a:name, ':'), -1)
    let {l:scope}:{l:name} = get({l:scope}:, l:name, a:default)
endfunction

let g:requirements#utils#plugin = {'Flag': funcref('s:Flag')}
" vim: et sw=4 ts=4 sts=4:
