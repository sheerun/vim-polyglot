if polyglot#init#is_disabled(expand('<sfile>:p'), 'dhall', 'ftplugin/dhall.vim')
  finish
endif

if exists('b:dhall_ftplugin')
	finish
endif
let b:dhall_ftplugin = 1

setlocal commentstring=--\ %s

set smarttab

if exists('g:dhall_use_ctags')
    if g:dhall_use_ctags == 1
        autocmd BufWritePost *.dhall silent !ctags -R .
    endif
endif

function! StripTrailingWhitespace()
    let myline=line('.')
    let mycolumn = col('.')
    exec 'silent %s/  *$//'
    call cursor(myline, mycolumn)
endfunction

if exists('g:dhall_strip_whitespace')
    if g:dhall_strip_whitespace == 1
        au BufWritePre *.dhall silent! call StripTrailingWhitespace()
    endif
endif

function! DhallFormat()
    let cursor = getpos('.')
    exec 'normal! gg'
    exec 'silent !dhall format ' . expand('%')
    exec 'e'
    call setpos('.', cursor)
endfunction

if exists('g:dhall_format')
    if g:dhall_format == 1
        au BufWritePost *.dhall call DhallFormat()
    endif
endif

au BufNewFile,BufRead *.dhall setl shiftwidth=2
