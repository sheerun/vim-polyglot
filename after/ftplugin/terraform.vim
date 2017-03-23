if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'terraform') == -1
  
if !exists('g:terraform_align')
  let g:terraform_align = 0
endif

if g:terraform_align && exists(':Tabularize')
  inoremap <buffer> <silent> = =<Esc>:call <SID>terraformalign()<CR>a
  function! s:terraformalign()
    let p = '^.*=[^>]*$'
    if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
      Tabularize/=/l1
      normal! 0
      call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
endif

" Match the identation put in place by Hashicorp and :TerraformFmt, https://github.com/hashivim/vim-terraform/issues/21
if get(g:, "terraform_align", 1)
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
endif

endif
