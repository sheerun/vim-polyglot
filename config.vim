function! s:SetDefault(name, value)
  if !exists(a:name)
    let {a:name} = a:value
  endif
endfunction

call s:SetDefault('g:markdown_enable_spell_checking', 0)
call s:SetDefault('g:markdown_enable_input_abbreviations', 0)
call s:SetDefault('g:markdown_enable_mappings', 0)

" Enable jsx syntax by default
call s:SetDefault('g:jsx_ext_required', 0)

" Make csv loading faster
call s:SetDefault('g:csv_start', 1)
call s:SetDefault('g:csv_end', 2)

" Disable json concealing by default
call s:SetDefault('g:vim_json_syntax_conceal', 0)

call s:SetDefault('g:filetype_euphoria', 'elixir')

call s:SetDefault('g:python_highlight_builtins', 1)
call s:SetDefault('g:python_highlight_builtin_objs', 1)
call s:SetDefault('g:python_highlight_builtin_types', 1)
call s:SetDefault('g:python_highlight_builtin_funcs', 1)
call s:SetDefault('g:python_highlight_builtin_funcs_kwarg', 1)
call s:SetDefault('g:python_highlight_exceptions', 1)
call s:SetDefault('g:python_highlight_string_formatting', 1)
call s:SetDefault('g:python_highlight_string_format', 1)
call s:SetDefault('g:python_highlight_string_templates', 1)
call s:SetDefault('g:python_highlight_indent_errors', 1)
call s:SetDefault('g:python_highlight_space_errors', 1)
call s:SetDefault('g:python_highlight_doctests', 1)
call s:SetDefault('g:python_highlight_func_calls', 1)
call s:SetDefault('g:python_highlight_class_vars', 1)
call s:SetDefault('g:python_highlight_operators', 1)
call s:SetDefault('g:python_highlight_file_headers_as_comments', 1)
call s:SetDefault('g:python_slow_sync', 1)

augroup filetypedetect
  autocmd BufNewFile,BufReadPost *.vb setlocal filetype=vbnet
augroup END

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
  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au BufRead,BufNewFile *.eex,*.leex set filetype=eelixir
  au BufRead,BufNewFile mix.lock set filetype=elixir

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
  autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml setfiletype plantuml | set filetype=plantuml

  " scala
  au BufRead,BufNewFile *.scala,*.sc set filetype=scala
  au BufRead,BufNewFile *.sbt setfiletype sbt.scala

  " swift
  autocmd BufNewFile,BufRead *.swift set filetype=swift

  "jinja
  autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja,*.nunjucks,*.nunjs,*.njk set ft=jinja

  "jsx
  au BufNewFile,BufRead *.jsx     setf javascriptreact
augroup END
