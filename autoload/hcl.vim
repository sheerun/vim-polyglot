if polyglot#init#is_disabled(expand('<sfile>:p'), 'terraform', 'autoload/hcl.vim')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

function! hcl#align() abort
  let p = '^.*=[^>]*$'
  if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
    Tabularize/=.*/l1
    normal! 0
    call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save
