if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cryptol') == -1

" Vim compiler file
" Compiler:         Cryptol version 1.8.19-academic Compiler
" Maintainer:       Edward O'Callaghan <victoredwardocallaghan AT gmail DOT com>
" Latest Revision:  25-Apr-2013

if exists("current_compiler")
  finish
endif
let current_compiler = "cryptol"

if exists(":CompilerSet") != 2
   command = -nargs =* CompilerSet setlocal <args>
endif

" TODO: Work out errorformat for the Cryptol compiler, see
" :help errorformat
CompilerSet errorformat&     " use the default 'errorformat'

" "%<" means the current file name without extension.
CompilerSet makeprg=cryptol\ -o\ %<\ %

endif
