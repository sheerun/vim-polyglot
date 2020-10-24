let files = filter(globpath(&rtp, 'ftplugin/wast.vim', 1, 1), { _, v -> v !~ "vim-polyglot" && v !~ $VIMRUNTIME && v !~ "after" })
if len(files) > 0
  exec 'source ' . files[0]
  finish
endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'wast') == -1

" Vim filetype plugin file
" Language:     WebAssembly
" Maintainer:   rhysd <lin90162@yahoo.co.jp>
" Last Change:  Jul 29, 2018
" For bugs, patches and license go to https://github.com/rhysd/vim-wasm

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal comments=s:(;,e:;),:;;
setlocal commentstring=(;%s;)
setlocal formatoptions-=t
setlocal iskeyword+=$,.,/

let b:undo_ftplugin = "setlocal comments< commentstring< formatoptions< iskeyword<"

endif
