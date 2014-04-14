inoremap <buffer> <silent> > ><Esc>:call <SID>puppetalign()<CR>A
function! s:puppetalign()
    let p = '^\s*\w+\s*[=+]>.*$'
    let lineContainsHashrocket = getline('.') =~# '^\s*\w+\s*[=+]>'
    let hashrocketOnPrevLine = getline(line('.') - 1) =~# p
    let hashrocketOnNextLine = getline(line('.') + 1) =~# p
    if exists(':Tabularize') " && lineContainsHashrocket && (hashrocketOnPrevLine || hashrocketOnNextLine)
        Tabularize /=>/l1
        normal! 0
    endif
endfunction
