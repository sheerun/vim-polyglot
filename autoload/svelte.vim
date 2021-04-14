if polyglot#init#is_disabled(expand('<sfile>:p'), 'svelte', 'autoload/svelte.vim')
  finish
endif

let s:name = 'vim-svelte-plugin'
let s:debug = exists("g:vim_svelte_plugin_debug")
      \ && g:vim_svelte_plugin_debug == 1

function! svelte#GetConfig(name, default)
  let name = 'g:vim_svelte_plugin_'.a:name
  return exists(name) ? eval(name) : a:default
endfunction

" Since svelte#Log and svelte#GetConfig are always called 
" in syntax and indent files,
" this file will be sourced when opening the first svelte file
if exists('##CursorMoved') && exists('*OnChangeSvelteSubtype')
  augroup vim_svelte_plugin
    autocmd!
    autocmd CursorMoved,CursorMovedI,WinEnter *.svelte
          \ call s:CheckSubtype()
  augroup END

  let s:subtype = ''
  function! s:CheckSubtype()
    let subtype = GetSvelteSubtype()

    if s:subtype != subtype
      call OnChangeSvelteSubtype(subtype)
      let s:subtype = subtype
    endif
  endfunction
endif

function! s:SynsEOL(lnum)
  let lnum = prevnonblank(a:lnum)
  let cnum = strlen(getline(lnum))
  return map(synstack(lnum, cnum), 'synIDattr(v:val, "name")')
endfunction

function! GetSvelteSubtype()
  let lnum = line('.')
  let cursyns = s:SynsEOL(lnum)
  let syn = !empty(cursyns) ? get(cursyns, 0, '') : ''

  let subtype = matchstr(syn, '\w\+\zeSvelte')
  if subtype =~ 'css\w\+'
    " For cssScss, cssLess, ...
    let subtype = subtype[3:]
  endif
  let subtype = tolower(subtype)
  return subtype
endfunction

function! GetSvelteTag(...)
  let lnum = a:0 > 0 ? a:1 : line('.')
  let cursyns = s:SynsEOL(lnum)
  let syn = get(cursyns, 0, '')

  if syn =~ 'SvelteTemplate'
    let tag = 'template'
  elseif syn =~ 'SvelteScript'
    let tag = 'script'
  elseif syn =~ 'SvelteStyle'
    let tag = 'style'
  else
    let tag = ''
  endif

  return tag
endfunction
