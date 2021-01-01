if polyglot#init#is_disabled(expand('<sfile>:p'), 'gleam', 'compiler/gleam.vim')
  finish
endif

" Check we've not run already
if exists('current_compiler')
    finish
endif

let current_compiler = "gleam"

" Defined CompilerSet command if it doesn't exist.
" Needed for older vim versions.
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

" Tell vim to run 'gleam' when the user runs :make. So ':make build .' becomes
" 'gleam build .'
CompilerSet makeprg=gleam\ $*


" With the compiler set, we set the errorformat which is a set of rules that
" vim uses to parse the output of the current compiler program in order to
" extract file, line, column & error message information so that it can
" populate the quickfix list and the user can jump between the errors.
"
" This errorformat 'parser' will have to change if the output of the compiler
" changes.
"
" Written with the help of: https://flukus.github.io/vim-errorformat-demystified.html
"
CompilerSet errorformat=%Eerror:\ %m                  " use 'error:' to indicate the start of a new error
CompilerSet errorformat+=%C\ %#┌─%#\ %f:%l:%c\ %#-%#  " pull out the file, line & column (matches optional spaces & dashes at the end in case they come back.)
CompilerSet errorformat+=%C                           " allow empty lines within an error
CompilerSet errorformat+=%C%.%#│%.%#                  " ignore any line with a vertial formatting pipe in it
CompilerSet errorformat+=%Z%m                         " assume any other line contributes to the error message


" Example error message
"
" error: Unknown variable
"    ┌─ /home/michael/root/projects/tutorials/gleam/try/code/src/main.gleam:19:18
"    │
" 19 │   Ok(tuple(name, spot))
"    │                  ^^^^ did you mean `sport`?
" 
" The name `spot` is not in scope here.

