if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'crystal') == -1

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

if exists('loaded_matchit') && !exists('b:match_words')
  let b:match_ignorecase = 0

  let b:match_words =
        \ '\<\%(if\|unless\|case\|while\|until\|for\|do\|class\|module\|struct\|lib\|macro\|ifdef\|def\|fun\|begin\|enum\)\>=\@!' .
        \ ':' .
        \ '\<\%(else\|elsif\|ensure\|when\|rescue\|break\|redo\|next\|retry\)\>' .
        \ ':' .
        \ '\<end\>' .
        \ ',{:},\[:\],(:)'

  let b:match_skip =
        \ "synIDattr(synID(line('.'),col('.'),0),'name') =~ '" .
        \ "\\<crystal\\%(String\\|StringDelimiter\\|ASCIICode\\|Escape\\|" .
        \ "Interpolation\\|NoInterpolation\\|Comment\\|Documentation\\|" .
        \ "ConditionalModifier\\|RepeatModifier\\|OptionalDo\\|" .
        \ "Function\\|BlockArgument\\|KeywordAsMethod\\|ClassVariable\\|" .
        \ "InstanceVariable\\|GlobalVariable\\|Symbol\\)\\>'"
endif

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal suffixesadd=.cr

" Set format for quickfix window
setlocal errorformat=
  \%ESyntax\ error\ in\ line\ %l:\ %m,
  \%ESyntax\ error\ in\ %f:%l:\ %m,
  \%EError\ in\ %f:%l:\ %m,
  \%C%p^,
  \%-C%.%#

let g:crystal_compiler_command = get(g:, 'crystal_compiler_command', 'crystal')
let g:crystal_auto_format = get(g:, 'crystal_auto_format', 0)

command! -buffer -nargs=* CrystalImpl echo crystal_lang#impl(expand('%'), getpos('.'), <q-args>).output
command! -buffer -nargs=0 CrystalDef call crystal_lang#jump_to_definition(expand('%'), getpos('.'))
command! -buffer -nargs=* CrystalContext echo crystal_lang#context(expand('%'), getpos('.'), <q-args>).output
command! -buffer -nargs=* CrystalHierarchy echo crystal_lang#type_hierarchy(expand('%'), <q-args>)
command! -buffer -nargs=? CrystalSpecSwitch call crystal_lang#switch_spec_file(<f-args>)
command! -buffer -nargs=? CrystalSpecRunAll call crystal_lang#run_all_spec(<f-args>)
command! -buffer -nargs=? CrystalSpecRunCurrent call crystal_lang#run_current_spec(<f-args>)
command! -buffer -nargs=* -bar CrystalFormat call crystal_lang#format(<q-args>, 0)
command! -buffer -nargs=* CrystalExpand echo crystal_lang#expand(expand('%'), getpos('.'), <q-args>).output

nnoremap <buffer><Plug>(crystal-jump-to-definition) :<C-u>CrystalDef<CR>
nnoremap <buffer><Plug>(crystal-show-context) :<C-u>CrystalContext<CR>
nnoremap <buffer><Plug>(crystal-spec-switch) :<C-u>CrystalSpecSwitch<CR>
nnoremap <buffer><Plug>(crystal-spec-run-all) :<C-u>CrystalSpecRunAll<CR>
nnoremap <buffer><Plug>(crystal-spec-run-current) :<C-u>CrystalSpecRunCurrent<CR>
nnoremap <buffer><Plug>(crystal-format) :<C-u>CrystalFormat<CR>

augroup plugin-ft-crystal
    autocmd BufWritePre <buffer> if g:crystal_auto_format | call crystal_lang#format('', 1) | endif
augroup END

if get(g:, 'crystal_define_mappings', 1)
  nmap <buffer>gd <Plug>(crystal-jump-to-definition)
  nmap <buffer>gc <Plug>(crystal-show-context)
  nmap <buffer>gss <Plug>(crystal-spec-switch)
  nmap <buffer>gsa <Plug>(crystal-spec-run-all)
  nmap <buffer>gsc <Plug>(crystal-spec-run-current)
endif

if &l:ofu ==# ''
  setlocal omnifunc=crystal_lang#complete
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: nowrap sw=2 sts=2 ts=8:

endif
