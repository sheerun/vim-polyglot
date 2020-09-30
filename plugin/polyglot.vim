if !exists("did_load_polyglot")
  if expand("<sfile>:p") =~# '/pack/' && (exists("did_load_filetypes") || exists("did_indent_on"))
    echohl WarningMsg
    echo "Improper install of vim-polyglot. Please add 'packload' to .vimrc"
    echohl None
  end
  filetype plugin indent on
  syntax enable
endif
