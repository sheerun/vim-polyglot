if polyglot#init#is_disabled(expand('<sfile>:p'), 'terraform', 'ftplugin/terraform.vim')
  finish
endif

" terraform.vim - basic vim/terraform integration
" Maintainer: HashiVim <https://github.com/hashivim>

if exists('b:did_ftplugin') || v:version < 700 || &compatible
  finish
endif

" Have only kept the terraform versions of these options for backwards
" compatibility.
if get(g:, 'terraform_fold_sections', 0)
  let s:hcl_fold_sections_save = get(g:, 'hcl_fold_sections', 0)
  let g:hcl_fold_sections=1
end

if get(g:, 'terraform_align', 0)
  let s:hcl_align_save = get(g:, 'hcl_align', 0)
  let g:hcl_align=1
end

runtime! ftplugin/hcl.vim

if exists('s:hcl_align_save')
  let g:hcl_align = s:hcl_align_save
end
if exists('s:hcl_fold_sections_save')
  let g:hcl_fold_sections = s:hcl_fold_sections_save
end

let s:cpo_save = &cpoptions
set cpoptions&vim

if !exists('g:terraform_binary_path')
  let g:terraform_binary_path='terraform'
endif

if !executable(g:terraform_binary_path)
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

command! -nargs=+ -complete=custom,terraform#commands -buffer Terraform
  \ execute '!'.g:terraform_binary_path.' '.<q-args>.' -no-color'

command! -nargs=0 -buffer TerraformFmt call terraform#fmt()
let b:undo_ftplugin .= '|delcommand Terraform|delcommand TerraformFmt'

if get(g:, 'terraform_fmt_on_save', 0)
  augroup vim.terraform.fmt
    autocmd!
    autocmd BufWritePre *.tf call terraform#fmt()
    autocmd BufWritePre *.tfvars call terraform#fmt()
  augroup END
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
