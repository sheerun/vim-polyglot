if polyglot#init#is_disabled(expand('<sfile>:p'), 'requirements', 'autoload/coc/source/requirements.vim')
  finish
endif

""
" https://github.com/neoclide/coc.nvim/wiki/Create-custom-source
function! coc#source#requirements#init() abort
    return {
                \ 'shortcut': 'pip',
                \ 'priority': 9,
                \ 'filetypes': ['requirements'],
                \ }
endfunction

""
" https://github.com/neoclide/coc.nvim/wiki/Create-custom-source
"
" Completion pip option and PYPI package names.
" Note: completion PYPI package names need install pip-cache from PYPI,
" and run `pip-cache update` first to generate cache.
function! coc#source#requirements#complete(opt, cb) abort
    call a:cb(g:requirements#items)
endfunction
" vim: et sw=4 ts=4 sts=4:
