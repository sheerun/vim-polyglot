if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'terraform') == -1

" Ensure no conflict with arguments from the environment
let $TF_CLI_ARGS_fmt=''

function! terraform#fmt()
  if !filereadable(expand('%:p'))
    return
  endif
  let l:curw = winsaveview()
  " Make a fake change so that the undo point is right.
  normal! ix
  normal! "_x
  silent execute '%!terraform fmt -no-color -'
  if v:shell_error != 0
    let output = getline(1, '$')
    silent undo
    echo join(output, "\n")
  endif
  call winrestview(l:curw)
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

function! terraform#commands(ArgLead, CmdLine, CursorPos)
  let l:commands = [
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
    \ 'refresh',
    \ 'show',
    \ 'taint',
    \ 'untaint',
    \ 'validate',
    \ 'version',
    \ 'workspace',
    \ '0.12upgrade',
    \ 'debug',
    \ 'force-unlock',
    \ 'push',
    \ 'state'
  \ ]
  return join(l:commands, "\n")
endfunction

endif
