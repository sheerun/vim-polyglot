if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'terraform') == -1
  
if !exists('g:terraform_align')
  let g:terraform_align = 0
endif

if !exists('g:terraform_remap_spacebar')
  let g:terraform_remap_spacebar = 0
endif

if !exists('g:terraform_fold_sections')
  let g:terraform_fold_sections = 0
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

if g:terraform_fold_sections
  function! TerraformFolds()
    let thisline = getline(v:lnum)
    if match(thisline, '^resource') >= 0
      return ">1"
    elseif match(thisline, '^provider') >= 0
      return ">1"
    elseif match(thisline, '^module') >= 0
      return ">1"
    elseif match(thisline, '^variable') >= 0
      return ">1"
    elseif match(thisline, '^output') >= 0
      return ">1"
    elseif match(thisline, '^data') >= 0
      return ">1"
    elseif match(thisline, '^terraform') >= 0
      return ">1"
    elseif match(thisline, '^locals') >= 0
      return ">1"
    else
      return "="
    endif
  endfunction
  setlocal foldmethod=expr
  setlocal foldexpr=TerraformFolds()
  setlocal foldlevel=1

  function! TerraformFoldText()
    let foldsize = (v:foldend-v:foldstart)
    return getline(v:foldstart).' ('.foldsize.' lines)'
  endfunction
  setlocal foldtext=TerraformFoldText()
endif

" Re-map the space bar to fold and unfold
if get(g:, "terraform_remap_spacebar", 1)
  "inoremap <space> <C-O>za
  nnoremap <space> za
  onoremap <space> <C-C>za
  vnoremap <space> zf
endif

" Match the identation put in place by Hashicorp and :TerraformFmt, https://github.com/hashivim/vim-terraform/issues/21
if get(g:, "terraform_align", 1)
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
endif

endif
