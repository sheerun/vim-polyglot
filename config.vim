" Enable jsx syntax by default
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 0
endif

" Disable json concealing by default
if !exists('g:vim_json_syntax_conceal')
  let g:vim_json_syntax_conceal = 0
endif

let g:filetype_euphoria = 'elixir'

augroup filetypedetect
  autocmd BufNewFile,BufReadPost *.vb setlocal filetype=vbnet
augroup END

let g:python_highlight_all = 1

augroup filetypedetect
  if v:version < 704
    " NOTE: this line fixes an issue with the default system-wide lisp ftplugin
    "       which didn't define b:undo_ftplugin on older Vim versions
    "       (*.jl files are recognized as lisp)
    autocmd BufRead,BufNewFile *.jl    let b:undo_ftplugin = "setlocal comments< define< formatoptions< iskeyword< lisp<"
  endif
  
  autocmd BufRead,BufNewFile *.jl      set filetype=julia
augroup END
