" WARNING: seems like we can't use <expr> maps, because we need side-effects
" ALT: {s: <C-g>...<C-g>, o: <Esc>, i: <C-o>, c: <C-\>e}
function! s:map_triggers(e)
  for [a, i] in items({'FocusGained': 0, 'FocusLost': 1})
    let key = keys(a:e)[i] | exe 'set '.key.'='.a:e[key]
    exe "fun! s:F".i."()\nif g:focau.active|sil! doau ".a."|en|return''\nendf"
    for [ms, prf] in items({'nv': '@=', 'o': ':call ', 'ic': '<C-r>='})
      for m in split(ms, '\zs')
        exe m.'noremap <silent> '.key.' '.prf.'<SID>F'.i.'()<CR>'
  endfor | endfor | endfor
endfunction


function! focau#init#main()
  augroup focau
    autocmd!
  augroup END

  call focau#cursor#shape_preserve()

  if g:focau.auto
    let g:focau.focuses = focau#events#auto_choose()
    let g:focau.cursors = focau#cursor#auto_shape()
    "" FIX: must be dynamic and check curr lang before each mode/lang-switch
    " call s:focau_lang_choose() "primary/secondary
  endif

  " Wrap choosen keys in event triggers
  call s:map_triggers(g:focau.events)
  " Start
  call focau#events#enable(g:focau.active)
  au focau VimEnter * if g:focau.active | sil! doau FocusGained | endif
endfunction
