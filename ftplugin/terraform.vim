if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'terraform') != -1
  finish
endif

" terraform.vim - basic vim/terraform integration
" Maintainer: HashiVim <https://github.com/hashivim>

set formatoptions-=t

if exists("g:loaded_terraform") || v:version < 700 || &cp || !executable('terraform')
  finish
endif
let g:loaded_terraform = 1

if !exists("g:terraform_fmt_on_save") || !filereadable(expand("%:p"))
  let g:terraform_fmt_on_save = 0
endif

function! s:commands(A, L, P)
  return join([
  \ "apply",
  \ "console",
  \ "destroy",
  \ "env",
  \ "fmt",
  \ "get",
  \ "graph",
  \ "import",
  \ "init",
  \ "output",
  \ "plan",
  \ "providers",
  \ "push",
  \ "refresh",
  \ "show",
  \ "taint",
  \ "untaint",
  \ "validate",
  \ "version",
  \ "workspace",
  \ "debug",
  \ "force-unlock",
  \ "state"
  \ ], "\n")
endfunction

" Adapted from vim-hclfmt:
" https://github.com/fatih/vim-hclfmt/blob/master/autoload/fmt.vim
function! terraform#fmt()
  let l:curw = winsaveview()
  let l:tmpfile = tempname() . ".tf"
  call writefile(getline(1, "$"), l:tmpfile)
  let output = system("terraform fmt -write " . l:tmpfile)
  if v:shell_error == 0
    try | silent undojoin | catch | endtry
    call rename(l:tmpfile, resolve(expand("%")))
    silent edit!
    let &syntax = &syntax
  else
    echo output
    call delete(l:tmpfile)
  endif
  call winrestview(l:curw)
endfunction

augroup terraform
  autocmd!
  autocmd BufEnter *
        \ command! -nargs=+ -complete=custom,s:commands Terraform execute '!terraform '.<q-args>. ' -no-color'
  autocmd BufEnter * command! -nargs=0 TerraformFmt call terraform#fmt()
  if get(g:, "terraform_fmt_on_save", 1)
    autocmd BufWritePre *.tf call terraform#fmt()
    autocmd BufWritePre *.tfvars call terraform#fmt()
  endif
augroup END
