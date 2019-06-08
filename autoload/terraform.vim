if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'terraform') != -1
  finish
endif

" Adapted from vim-hclfmt:
" https://github.com/fatih/vim-hclfmt/blob/master/autoload/fmt.vim
function! terraform#fmt()
  if !filereadable(expand('%:p'))
    return
  endif
  let l:curw = winsaveview()
  let l:tmpfile = tempname() . '.tf'
  call writefile(getline(1, '$'), l:tmpfile)
  let output = system('terraform fmt -write ' . l:tmpfile)
  if v:shell_error == 0
    try | silent undojoin | catch | endtry
    call rename(l:tmpfile, resolve(expand('%')))
    silent edit!
    let &syntax = &syntax
  else
    echo output
    call delete(l:tmpfile)
  endif
  call winrestview(l:curw)
endfunction
