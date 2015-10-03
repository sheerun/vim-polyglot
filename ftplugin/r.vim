" ftplugin for R files
"
" Author: Iago Mosqueira <i.mosqueira@ic.ac.uk>
" Author: Johannes Ranke <jranke@uni-bremen.de>
" Author: Fernando Henrique Ferraz Pereira da Rosa <feferraz@ime.usp.br>
" Maintainer: Johannes Ranke <jranke@uni-bremen.de>
" Last Change: 2007 Nov 21
" SVN: $Id: r.vim 75 2007-11-21 13:34:02Z ranke $
"
" Code written in vim is sent to R through a perl pipe
" [funnel.pl, by Larry Clapp <vim@theclapp.org>], as individual lines,
" blocks, or the whole file.

" Press <F2> to open a new xterm with a new R interpreter listening
" to its standard input (you can type R commands into the xterm)
" as well as to code pasted from within vim.
"
" After selecting a visual block, 'r' sends it to the R interpreter
"
" In insert mode, <M-Enter> sends the active line to R and moves to the next
" line (write and process mode).
"
" Maps:
"       <F2>		Start a listening R interpreter in new xterm
"       <F3>		Start a listening R-devel interpreter in new xterm
"       <F4>		Start a listening R --vanilla interpreter in new xterm
"       <F5>        Run current file
"       <F9>        Run line under cursor
"       r	        Run visual block
"       <M-Enter>   Write and process

" Only do this when not yet done for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Disable backup for .r-pipe
setl backupskip=.*pipe

" Set tabstop so it is compatible with the emacs edited code. Personally, I
" prefer shiftwidth=2, which I have in my .vimrc anyway
set expandtab
set shiftwidth=4
set tabstop=8

" Start a listening R interpreter in new xterm
noremap <buffer> <F2> :!xterm -T 'R' -e funnel.pl ~/.r-pipe "R && echo -e 'Interpreter has finished. Exiting. Goodbye.\n'"&<CR><CR>

" Start a listening R-devel interpreter in new xterm
noremap <buffer> <F3> :!xterm -T 'R' -e funnel.pl ~/.r-pipe "R-devel && echo 'Interpreter has finished. Exiting. Goodbye.'"&<CR><CR>

" Start a listening R --vanilla interpreter in new xterm
noremap <buffer> <F4> :!xterm -T 'R' -e funnel.pl ~/.r-pipe "R -vanilla && echo 'Interpreter has finished. Exiting. Goodbye.'"&<CR><CR>

" Send line under cursor to R
noremap <buffer> <F9> :execute line(".") 'w >> ~/.r-pipe'<CR>
inoremap <buffer> <F9> <Esc> :execute line(".") 'w >> ~/.r-pipe'<CR>

" Send visual selected block to R
vnoremap <buffer> r :w >> ~/.r-pipe<CR>

" Write and process mode (somehow mapping <C-Enter> does not work)
inoremap <M-Enter> <Esc>:execute line(".") 'w >> ~/.r-pipe'<CR>o

" Send current file to R
noremap <buffer> <F5> :execute '1 ,' line("$") 'w >> ~/.r-pipe' <CR><CR>
