" Turn on filetype plugins (:help filetype-plugin).
if has('autocmd') && !(exists("did_load_filetypes") && exists("did_indent_on"))
  filetype plugin indent on
endif

" Enable syntax highlighting.
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
