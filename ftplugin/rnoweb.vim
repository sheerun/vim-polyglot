if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim filetype plugin file
" Language: Rnoweb
" Maintainer: Jakson Alves de Aquino <jalvesaq@gmail.com>
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change:	Tue Apr 07, 2015  04:37PM

" Only do this when not yet done for this buffer
if exists("b:did_ftplugin")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

runtime! ftplugin/tex.vim

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Enables Vim-Latex-Suite, LaTeX-Box if installed
runtime ftplugin/tex_*.vim

setlocal iskeyword=@,48-57,_,.
setlocal suffixesadd=.bib,.tex
setlocal comments=b:%,b:#,b:##,b:###,b:#'

if has("gui_win32") && !exists("b:browsefilter")
  let b:browsefilter = "R Source Files (*.R *.Rnw *.Rd *.Rmd *.Rrst)\t*.R;*.Rnw;*.Rd;*.Rmd;*.Rrst\n" .
        \ "All Files (*.*)\t*.*\n"
endif

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= " | setl isk< sua< com< | unlet! b:browsefilter"
else
  let b:undo_ftplugin = "setl isk< sua< com< | unlet! b:browsefilter"
endif

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'r-lang') == -1
  
" ftplugin for Sweave files containing both LaTeX and R code
"
" Maintainer: Johannes Ranke <jranke@uni-bremen.de>
" Last Change: 2007 Nov 21
" SVN: $Id: rnoweb.vim 75 2007-11-21 13:34:02Z ranke $
"
" Usage:
"
" Press <F2> to open a new xterm with a new R interpreter listening
" to its standard input (you can type R commands into the xterm)
" as well as to code pasted from within vim.
"
" A Makefile for producing R noweb files is in included in my Vim script
" R.vim:
" 	http://www.vim.org/scripts/script.php?script_id=1048
" You can also look in my SVN repository under:
" 	http://kri/viewcvs/*checkout*/Makefile.rnoweb?root=vim
"
"
" After selecting a visual block, 'r' sends it to the R interpreter
"
" Add to filetypes.vim, if you don't use vim 7
"   au BufNewFile,BufRead *.Rnw,*.rnw   setf rnoweb
" and/or
"   au BufNewFile,BufRead *.Snw,*.snw   setf rnoweb
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

" Disable backup for .r-pipe
setl backupskip=.*pipe

" Set R friendly tabbing
set expandtab
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
