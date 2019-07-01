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

function! terraform#folds()
  let thisline = getline(v:lnum)
  if match(thisline, '^resource') >= 0
    return '>1'
  elseif match(thisline, '^provider') >= 0
    return '>1'
  elseif match(thisline, '^module') >= 0
    return '>1'
  elseif match(thisline, '^variable') >= 0
    return '>1'
  elseif match(thisline, '^output') >= 0
    return '>1'
  elseif match(thisline, '^data') >= 0
    return '>1'
  elseif match(thisline, '^terraform') >= 0
    return '>1'
  elseif match(thisline, '^locals') >= 0
    return '>1'
  else
    return '='
  endif
endfunction

function! terraform#foldText()
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction

function! terraform#align()
  let p = '^.*=[^>]*$'
  if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
    Tabularize/=/l1
    normal! 0
    call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

function! terraform#commands(A, L, P)
  return [
  \ 'apply',
  \ 'console',
  \ 'destroy',
  \ 'env',
  \ 'fmt',
  \ 'get',
  \ 'graph',
  \ 'import',
  \ 'init',
  \ 'output',
  \ 'plan',
  \ 'providers',
  \ 'push',
  \ 'refresh',
  \ 'show',
  \ 'taint',
  \ 'untaint',
  \ 'validate',
  \ 'version',
  \ 'workspace',
  \ '0.12checklist',
  \ 'debug',
  \ 'force-unlock',
  \ 'state'
  \ ]
endfunction
