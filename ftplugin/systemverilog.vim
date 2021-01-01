if polyglot#init#is_disabled(expand('<sfile>:p'), 'systemverilog', 'ftplugin/systemverilog.vim')
  finish
endif

" Vim filetype plugin file
" Language:    SystemVerilog
" Maintainer:  kocha <kocha.lsifrontend@gmail.com>
" Last Change: 12-Aug-2013. 

if exists("b:did_ftplugin")
  finish
endif

" Behaves just like Verilog
runtime! ftplugin/verilog.vim
