if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rspec') == -1
  
autocmd BufReadPost,BufNewFile *_spec.rb set syntax=rspec
autocmd BufReadPost,BufNewFile *_spec.rb setlocal commentstring=#\ %s

endif
