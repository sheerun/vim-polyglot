call polyglot#init#init()

" Turn on filetype plugins (:help filetype-plugin).
if has('autocmd') && !(exists("did_load_filetypes") && exists("did_indent_on"))
  filetype plugin indent on
endif

" Enable syntax highlighting.
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" No need to duplicate work
if exists('g:loaded_sensible')
  finish
endif

" Code taken from https://github.com/tpope/vim-sensible
" and (mostly comments) from https://github.com/sheerun/vimrc
"
" Only settings that matter for proper editing are left
if !has_key(g:polyglot_is_disabled, 'sensible')
  " Allow backspace in insert mode.
  if &backspace == ""
    set backspace=indent,eol,start
  endif

  " Allow for mappings including `Esc`, while preserving
  " zero timeout after pressing it manually.
  " (only vim needs a fix for this)
  if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
  endif

  " Set default whitespace characters when using `:set list`
  if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif

  " Delete comment character when joining commented lines
  if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
  endif

  " Search upwards for tags file instead only locally
  if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
  endif

  " Fix issues with fish shell
  " https://github.com/tpope/vim-sensible/issues/50
  if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
    set shell=/usr/bin/env\ bash
  endif

  " Increase history size to 1000 items.
  if &history < 1000
    set history=1000
  endif

  " Allow for up to 50 opened tabs on Vim start.
  if &tabpagemax < 50
    set tabpagemax=50
  endif

  " Reduce updatetime from 4000 to 300 to avoid issues with coc.nvim
  if &updatetime == 4000
    set updatetime=300
  endif

  " Automatically reload file if changed somewhere else
  redir => capture
  silent autocmd CursorHold
  redir END
  if match(capture, 'checktime') == -1
    augroup polyglot-sensible
      au!
      au CursorHold * silent! checktime
    augroup END
  endif

  " Always save upper case variables to viminfo file.
  if !empty(&viminfo)
    set viminfo^=!
  endif

  " Don't save options in sessions and views
  set sessionoptions-=options
  set viewoptions-=options

  " Allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^Eterm'
    set t_Co=16
  endif

  " Load matchit.vim, but only if the user hasn't installed a newer version.
  if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
  endif

  " `Ctrl-U` in insert mode deletes a lot. Use `Ctrl-G` u to first break undo,
  " so that you can undo `Ctrl-U` without undoing what you typed before it.
  if empty(mapcheck('<C-U>', 'i'))
    inoremap <C-U> <C-G>u<C-U>
  endif

  if empty(mapcheck('<C-W>', 'i'))
    inoremap <C-W> <C-G>u<C-W>
  endif
endif
