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

  " coffeescript
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
  autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
  autocmd BufNewFile,BufRead *._coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.litcoffee set filetype=litcoffee
  autocmd BufNewFile,BufRead *.coffee.md set filetype=litcoffee


  " elixir
  au BufRead,BufNewFile *.ex,*.exs call s:setf('elixir')
  au BufRead,BufNewFile *.eex call s:setf('eelixir')

  " fish
  autocmd BufRead,BufNewFile *.fish setfiletype fish
  autocmd BufRead fish_funced_*_*.fish call search('^$')
  autocmd BufRead,BufNewFile ~/.config/fish/fish_{read_,}history setfiletype yaml
  autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly
  autocmd BufNewFile ~/.config/fish/functions/*.fish
              \ call append(0, ['function '.expand('%:t:r'),
                               \'',
                               \'end']) |
              \ 2
  
  " git
  autocmd BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
  autocmd BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
  autocmd BufNewFile,BufRead */.config/git/config                          set ft=gitconfig
  autocmd BufNewFile,BufRead *.git/modules/**/config                       set ft=gitconfig
  autocmd BufNewFile,BufRead git-rebase-todo                               set ft=gitrebase
  autocmd BufNewFile,BufRead .gitsendemail.*                               set ft=gitsendemail

  " plantuml
  autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml setfiletype plantuml | set filetype=plantuml

  " scala
  au BufRead,BufNewFile *.scala,*.sc set filetype=scala
  au BufRead,BufNewFile *.sbt setfiletype sbt.scala

  " swift
  autocmd BufNewFile,BufRead *.swift set filetype=swift
augroup END

" Fix for https://github.com/sheerun/vim-polyglot/issues/236#issuecomment-387984954
if (!exists('g:graphql_javascript_tags'))
  let g:graphql_javascript_tags = ['gql', 'graphql', 'Relay.QL']
endif
