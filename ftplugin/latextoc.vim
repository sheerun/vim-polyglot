" {{{1 Settings
setlocal buftype=nofile
setlocal bufhidden=wipe
setlocal nobuflisted
setlocal noswapfile
setlocal nowrap
setlocal nospell
setlocal cursorline
setlocal nonumber
setlocal nolist
setlocal tabstop=8
setlocal cole=0
setlocal cocu=nvic
if g:LatexBox_fold_toc
    setlocal foldmethod=expr
    setlocal foldexpr=TOCFoldLevel(v:lnum)
    setlocal foldtext=TOCFoldText()
endif
" }}}1

" {{{1 Functions
" {{{2 TOCClose
function! s:TOCClose()
    if g:LatexBox_split_resize
        silent exe "set columns-=" . g:LatexBox_split_width
    endif
    bwipeout
endfunction

" {{{2 TOCToggleNumbers
function! s:TOCToggleNumbers()
    if b:toc_numbers
        setlocal conceallevel=3
        let b:toc_numbers = 0
    else
        setlocal conceallevel=0
        let b:toc_numbers = 1
    endif
endfunction

" {{{2 EscapeTitle
function! s:EscapeTitle(titlestr)
    let titlestr = substitute(a:titlestr, '\\[a-zA-Z@]*\>\s*{\?', '.*', 'g')
    let titlestr = substitute(titlestr, '}', '', 'g')
    let titlestr = substitute(titlestr, '\%(\.\*\s*\)\{2,}', '.*', 'g')
    return titlestr
endfunction

" {{{2 TOCActivate
function! s:TOCActivate(close)
    let n = getpos('.')[1] - 1

    if n >= len(b:toc)
        return
    endif

    let entry = b:toc[n]

    let titlestr = s:EscapeTitle(entry['text'])

    " Search for duplicates
    "
    let i=0
    let entry_hash = entry['level'].titlestr
    let duplicates = 0
    while i<n
        let i_entry = b:toc[n]
        let i_hash = b:toc[i]['level'].s:EscapeTitle(b:toc[i]['text'])
        if i_hash == entry_hash
            let duplicates += 1
        endif
        let i += 1
    endwhile
    let toc_bnr = bufnr('%')
    let toc_wnr = winnr()

    execute b:calling_win . 'wincmd w'

    let root = fnamemodify(entry['file'], ':h') . '/'
    let files = [entry['file']]
    for line in filter(readfile(entry['file']), 'v:val =~ ''\\input{''')
        let file = matchstr(line, '{\zs.\{-}\ze\(\.tex\)\?}') . '.tex'
        if file[0] != '/'
            let file = root . file
        endif
        call add(files, file)
    endfor

    " Find section in buffer (or inputted files)
    if entry['level'] == 'label'
        let re = '\(\\label\_\s*{\|label\s*=\s*\)' . titlestr . '\>'
    else
        let re = '\\' . entry['level'] . '\_\s*{' . titlestr . '}'
    endif
    call s:TOCFindMatch(re, duplicates, files)

    if a:close
        if g:LatexBox_split_resize
            silent exe "set columns-=" . g:LatexBox_split_width
        endif
        execute 'bwipeout ' . toc_bnr
    else
        execute toc_wnr . 'wincmd w'
    endif
endfunction

" {{{2 TOCFindMatch
function! s:TOCFindMatch(strsearch,duplicates,files)
    if len(a:files) == 0
        echoerr "Could not find: " . a:strsearch
        return
    endif

    call s:TOCOpenBuf(a:files[0])
    let dups = a:duplicates

    " Skip duplicates
    while dups > 0
        if search(a:strsearch, 'w')
            let dups -= 1
        else
            break
        endif
    endwhile

    if search(a:strsearch, 'w')
        normal! zv
        return
    endif

    call s:TOCFindMatch(a:strsearch,dups,a:files[1:])
endfunction

" {{{2 TOCFoldLevel
function! TOCFoldLevel(lnum)
    let line  = getline(a:lnum)
    let match_s1 = line =~# '^\w\+\s'
    let match_s2 = line =~# '^\w\+\.\w\+\s'
    let match_s3 = line =~# '^\w\+\.\w\+\.\w\+\s'

    if g:LatexBox_fold_toc_levels >= 3
        if match_s3
            return ">3"
        endif
    endif

    if g:LatexBox_fold_toc_levels >= 2
        if match_s2
            return ">2"
        endif
    endif

    if match_s1
        return ">1"
    endif

    " Don't fold options
    if line =~# '^\s*$'
        return 0
    endif

    " Return previous fold level
    return "="
endfunction

" {{{2 TOCFoldText
function! TOCFoldText()
    let parts = matchlist(getline(v:foldstart), '^\(.*\)\t\(.*\)$')
    return printf('%-8s%-72s', parts[1], parts[2])
endfunction

" {{{2 TOCOpenBuf
function! s:TOCOpenBuf(file)

    let bnr = bufnr(a:file)
    if bnr == -1
        execute 'badd ' . a:file
        let bnr = bufnr(a:file)
    endif
    execute 'buffer! ' . bnr
    normal! gg

endfunction

" }}}1

" {{{1 Mappings
nnoremap <buffer> <silent> s :call <SID>TOCToggleNumbers()<CR>
nnoremap <buffer> <silent> q :call <SID>TOCClose()<CR>
nnoremap <buffer> <silent> <Esc> :call <SID>TOCClose()<CR>
nnoremap <buffer> <silent> <Space> :call <SID>TOCActivate(0)<CR>
nnoremap <buffer> <silent> <CR> :call <SID>TOCActivate(1)<CR>
nnoremap <buffer> <silent> <leftrelease> :call <SID>TOCActivate(0)<cr>
nnoremap <buffer> <silent> <2-leftmouse> :call <SID>TOCActivate(1)<cr>
nnoremap <buffer> <silent> G G4k
nnoremap <buffer> <silent> <Esc>OA k
nnoremap <buffer> <silent> <Esc>OB j
nnoremap <buffer> <silent> <Esc>OC l
nnoremap <buffer> <silent> <Esc>OD h
" }}}1

" vim:fdm=marker:ff=unix:et:ts=4:sw=4
