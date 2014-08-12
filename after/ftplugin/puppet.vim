if !exists('g:puppet_align_hashes')
    let g:puppet_align_hashes = 1
endif

if g:puppet_align_hashes && exists(':Tabularize')
    inoremap <buffer> <silent> > ><Esc>:call <SID>puppetalign()<CR>a
    function! s:puppetalign()
        let p = '^\s*\w+\s*[=+]>.*$'
        let column = strlen(substitute(getline('.')[0:col('.')],'\([^=]\|=[^>]\)','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*=>\s*\zs.*'))
        Tabularize /=>/l1
        normal! 0
        echo repeat('\([^=]\|=[^>]\)*=>',column).'\s\{-\}'.repeat('.',position)
        call search(repeat('\([^=]\|=[^>]\)*=>',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endfunction
endif
