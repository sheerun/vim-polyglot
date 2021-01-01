if polyglot#init#is_disabled(expand('<sfile>:p'), 'crystal', 'autoload/ecrystal.vim')
  finish
endif

let s:ecrystal_extensions = {
      \ 'cr': 'crystal',
      \ 'yml': 'yaml',
      \ 'js': 'javascript',
      \ 'txt': 'text',
      \ 'md': 'markdown'
      \ }

if exists('g:ecrystal_extensions')
  call extend(s:ecrystal_extensions, g:ecrystal_extensions, 'force')
endif

function! ecrystal#SetSubtype() abort
  if exists('b:ecrystal_subtype')
    return
  endif

  let b:ecrystal_subtype = matchstr(substitute(expand('%:t'), '\c\%(\.ecr\)\+$', '', ''), '\.\zs\w\+\%(\ze+\w\+\)\=$')

  let b:ecrystal_subtype = get(s:ecrystal_extensions, b:ecrystal_subtype, b:ecrystal_subtype)

  if b:ecrystal_subtype ==# ''
    let b:ecrystal_subtype = get(g:, 'ecrystal_default_subtype', 'html')
  endif

  if b:ecrystal_subtype !=# ''
    exec 'setlocal filetype=ecrystal.' . b:ecrystal_subtype
    exec 'setlocal syntax=ecrystal.' . b:ecrystal_subtype
  endif
endfunction

" vim: sw=2 sts=2 et:
