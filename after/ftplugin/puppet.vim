if has_key(g:polyglot_is_disabled, 'puppet')
  finish
endif

if !exists('g:puppet_align_hashes')
    let g:puppet_align_hashes = 1
endif

if g:puppet_align_hashes
    inoremap <buffer> <silent> => =><Esc>:call puppet#align#AlignHashrockets()<CR>$a
endif
