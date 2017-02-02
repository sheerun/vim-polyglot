" Enable jsx syntax by default
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 0
endif

" Disable json concealing by default
if !exists('g:vim_json_syntax_conceal')
  let g:vim_json_syntax_conceal = 0
endif

let g:filetype_euphoria = 'elixir'
