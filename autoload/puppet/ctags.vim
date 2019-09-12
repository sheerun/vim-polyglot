if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1


if !exists('s:ctags_type')
  let s:ctags_type = 0
endif

let s:ctags_options_dir = expand('<sfile>:p:h:h:h') . '/ctags/'

" Return full path to option file for ctags application
function! puppet#ctags#OptionFile()

  if puppet#ctags#Type() == 'universal'
    let l:ctags_options = 'puppet_u.ctags'
  else
    let l:ctags_options = 'puppet.ctags'
  endif
  return s:ctags_options_dir . l:ctags_options
endfunction

" Return type of installed ctags application,
" can be 'universal' or 'exuberant'
function! puppet#ctags#Type()

  if !s:ctags_type
    let l:version = system('ctags --version')
    if l:version =~ 'Universal Ctags'
      let s:ctags_type = 'universal'
    elseif l:version =~ 'Exuberant Ctags'
      let s:ctags_type = 'exuberant'
    else
       echoerr 'Unknown version of Ctags'
    endif
  endif

  return s:ctags_type
endfunction


endif
