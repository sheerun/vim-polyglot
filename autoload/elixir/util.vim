let s:base = expand("<sfile>:h:h")
let Filter = { _, v -> stridx(v, s:base) == -1 && stridx(v, $VIMRUNTIME) == -1 && v !~ "after" }
let files = filter(globpath(&rtp, 'autoload/elixir/util.vim', 1, 1), Filter)
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1

function! elixir#util#get_filename(word) abort
  let word = a:word

  " get first thing that starts uppercase, until the first space or end of line
  let word = substitute(word,'^\s*\(\u[^ ]\+\).*$','\1','g')

  " remove any trailing characters that don't look like a nested module
  let word = substitute(word,'\.\U.*$','','g')

  " replace module dots with slash
  let word = substitute(word,'\.','/','g')

  " remove any special chars
  let word = substitute(word,'[^A-z0-9-_/]','','g')

  " convert to snake_case
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'-','_','g')
  let word = tolower(word)

  return word
endfunction

endif
