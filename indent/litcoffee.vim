let files = filter(globpath(&rtp, 'indent/litcoffee.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'coffee-script') == -1

if exists('b:did_indent')
  finish
endif

runtime! indent/coffee.vim

let b:did_indent = 1

setlocal indentexpr=GetLitCoffeeIndent()

if exists('*GetLitCoffeeIndent')
  finish
endif

function GetLitCoffeeIndent()
  if searchpair('^    \|\t', '', '$', 'bWnm') > 0
    return GetCoffeeIndent(v:lnum)
  else
    return -1
  endif
endfunc


endif
