" Oh yeah, we are loading before vim's filetype.vim so we can
" make startup little faster by preventing it to load later
if !exists("did_load_filetypes")
  runtime! ftdetect/polyglot.vim

  " We need to do it here to avoid recursive loop
  runtime! ftdetect/*.vim
endif
