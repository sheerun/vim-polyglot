if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1

if !exists('g:puppet_align_hashes')
    let g:puppet_align_hashes = 1
endif

if g:puppet_align_hashes
    inoremap <buffer> <silent> => =><Esc>:call puppet#align#AlignHashrockets()<CR>$a
endif

endif
