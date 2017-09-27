if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim filetype plugin file
" Language: R help file
" Maintainer: Jakson Alves de Aquino <jalvesaq@gmail.com>
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change:	Tue Apr 07, 2015  04:37PM

" Only do this when not yet done for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal iskeyword=@,48-57,_,.

if has("gui_win32") && !exists("b:browsefilter")
  let b:browsefilter = "R Source Files (*.R *.Rnw *.Rd *.Rmd *.Rrst)\t*.R;*.Rnw;*.Rd;*.Rmd;*.Rrst\n" .
        \ "All Files (*.*)\t*.*\n"
endif

let b:undo_ftplugin = "setl isk< | unlet! b:browsefilter"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'r-lang') == -1
  
" ftplugin for R help files
"
" Author: Johannes Ranke <jranke@uni-bremen.de>
" Last Change: 2007 Nov 21
" SVN: $Id: rhelp.vim 75 2007-11-21 13:34:02Z ranke $
"
" Usage:
"
" Press <F2> to open a new xterm with a new R interpreter listening
" to its standard input (you can type R commands into the xterm)
" as well as to code pasted from within vim.
"
" After selecting a visual block, 'r' sends it to the R interpreter
"
" Add to filetypes.vim, if you don't use vim 7
"   au BufNewFile,BufRead *.Rd,*.rd   setf rhelp
"
" Maps:
"       <F2>		Start a listening R interpreter in new xterm
"       <F9>        Run line under cursor
"       r	        Run visual block
"       <M-Enter>   Write and process R code
 
" Only do this when not yet done for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Set tabbing
set expandtab
set tabstop=2
set shiftwidth=2

" Start a listening R interpreter in new xterm
noremap <buffer> <F2> :!xterm -T 'R' -e funnel.pl ~/.r-pipe "R && echo -e 'Interpreter has finished. Exiting. Goodbye.\n'"&<CR><CR>

" Send line under cursor to R
noremap <buffer> <F9> :execute line(".") 'w >> ~/.r-pipe'<CR>
inoremap <buffer> <F9> <Esc> :execute line(".") 'w >> ~/.r-pipe'<CR>

" Send visual selected block to R
vnoremap <buffer> r :w >> ~/.r-pipe<CR>

" Write and process mode (somehow mapping <C-Enter> does not work)
inoremap <M-Enter> <Esc>:execute line(".") 'w >> ~/.r-pipe'<CR>o

endif
