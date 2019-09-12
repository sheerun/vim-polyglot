if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elm') == -1

" plugin for Elm (http://elm-lang.org/)

if exists('b:did_ftplugin')
  finish
endif

let b:did_ftplugin = 1

" Settings
if !exists('g:elm_jump_to_error')
	let g:elm_jump_to_error = 0
endif

if !exists('g:elm_make_output_file')
	let g:elm_make_output_file = 'elm.js'
endif

if !exists('g:elm_make_show_warnings')
	let g:elm_make_show_warnings = 0
endif

if !exists('g:elm_syntastic_show_warnings')
	let g:elm_syntastic_show_warnings = 0
endif

if !exists('g:elm_format_autosave')
	let g:elm_format_autosave = 1
endif

if !exists('g:elm_format_fail_silently')
    let g:elm_format_fail_silently = 0
endif

if !exists('g:elm_setup_keybindings')
	let g:elm_setup_keybindings = 1
endif

setlocal omnifunc=elm#Complete

setlocal comments=:--
setlocal commentstring=--\ %s

" Commands
command -buffer -nargs=? -complete=file ElmMake call elm#Make(<f-args>)
command -buffer ElmMakeMain call elm#Make("Main.elm")
command -buffer -nargs=? -complete=file ElmTest call elm#Test(<f-args>)
command -buffer ElmRepl call elm#Repl()
command -buffer ElmErrorDetail call elm#ErrorDetail()
command -buffer ElmShowDocs call elm#ShowDocs()
command -buffer ElmBrowseDocs call elm#BrowseDocs()
command -buffer ElmFormat call elm#Format()

" Commands cleanup
let b:undo_ftplugin = "
      \ delcommand ElmMake
      \|delcommand ElmMakeMain
      \|delcommand ElmTest
      \|delcommand ElmRepl
      \|delcommand ElmErrorDetail
      \|delcommand ElmShowDocs
      \|delcommand ElmBrowseDocs
      \|delcommand ElmFormat
      \"

if get(g:, 'elm_setup_keybindings', 1)
  nmap <buffer> <LocalLeader>m <Plug>(elm-make)
  nmap <buffer> <LocalLeader>b <Plug>(elm-make-main)
  nmap <buffer> <LocalLeader>t <Plug>(elm-test)
  nmap <buffer> <LocalLeader>r <Plug>(elm-repl)
  nmap <buffer> <LocalLeader>e <Plug>(elm-error-detail)
  nmap <buffer> <LocalLeader>d <Plug>(elm-show-docs)
  nmap <buffer> <LocalLeader>w <Plug>(elm-browse-docs)
endif

" Better gf command
nmap <buffer> gf :call elm#util#GoToModule(expand('<cfile>'))<CR>

" Elm code formatting on save
if get(g:, 'elm_format_autosave', 1)
  augroup elmFormat
	autocmd!
	autocmd BufWritePre *.elm call elm#Format()
	autocmd BufWritePost *.elm call elm#util#EchoStored()
   augroup END
endif
if has('win32')
	set viewdir=$HOME/vimfiles/views/
endif

" Enable go to file under cursor from module name
" Based on: https://github.com/elixir-lang/vim-elixir/blob/bd66ed134319d1e390f3331e8c4d525109f762e8/ftplugin/elixir.vim#L22-L56
function! GetElmFilename(word)
  let l:word = a:word

  " replace module dots with slash
  let l:word = substitute(l:word,'\.','/','g')

  return l:word
endfunction

let &l:path =
      \ join([
      \   elm#FindRootDirectory().'/src',
      \   elm#FindRootDirectory().'/elm-stuff/packages/**/src',
      \   &g:path
      \ ], ',')
setlocal includeexpr=GetElmFilename(v:fname)
setlocal include=^\\s*import\\s\\+
setlocal suffixesadd=.elm

endif
