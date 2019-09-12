if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1

" common functions for vifm command-line editing buffer filetype plugins
" Maintainer:  xaizek <xaizek@posteo.net>
" Last Change: August 18, 2013

" Prepare buffer
function! vifm#edit#Init()
    " Mappings for quick leaving the buffer (behavior similar to Command line
    " buffer in Vim)
    nnoremap <buffer> <cr> :copy 0 \| wq<cr>
    imap <buffer> <cr> <esc><cr>

    " Start buffer editing in insert mode
    startinsert
endfunction

endif
