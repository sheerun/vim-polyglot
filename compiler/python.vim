if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'python-compiler') == -1

" Vim compiler file
" Compiler:	Unit testing tool for Python
" Maintainer:	Ali Aliev <ali@aliev.me>
" Last Change: 2015 Nov 2

if exists("current_compiler")
  finish
endif

let current_compiler = "python"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" Disable Python warnings
if !exists('$PYTHONWARNINGS')
  let $PYTHONWARNINGS="ignore"
endif

" For Flake8 first
CompilerSet efm  =%E%f:%l:\ could\ not\ compile,
CompilerSet efm +=%-Z%p^,
CompilerSet efm +=%A%f:%l:%c:\ %t%n\ %m,
CompilerSet efm +=%A%f:%l:\ %t%n\ %m,

" Python errors are multi-lined. They often start with 'Traceback', so
" we want to capture that (with +G) and show it in the quickfix window
" because it explains the order of error messages.

CompilerSet efm +=%+GTraceback%.%#,

" The error message itself starts with a line with 'File' in it. There
" are a couple of variations, and we need to process a line beginning
" with whitespace followed by File, the filename in "", a line number,
" and optional further text. %E here indicates the start of a multi-line
" error message. The %\C at the end means that a case-sensitive search is
" required.
CompilerSet efm +=%E\ \ File\ \"%f\"\\,\ line\ %l\\,%m%\\C,
CompilerSet efm +=%E\ \ File\ \"%f\"\\,\ line\ %l%\\C,

" The possible continutation lines are idenitifed to Vim by %C. We deal
" with these in order of most to least specific to ensure a proper
" match. A pointer (^) identifies the column in which the error occurs
" (but will not be entirely accurate due to indention of Python code).
CompilerSet efm +=%C%p^,

" Any text, indented by more than two spaces contain useful information.
" We want this to appear in the quickfix window, hence %+.
CompilerSet efm +=%+C\ \ \ \ %.%#,
CompilerSet efm +=%+C\ \ %.%#,

" The last line (%Z) does not begin with any whitespace. We use a zero
" width lookahead (\&) to check this. The line contains the error
" message itself (%m)
CompilerSet efm +=%Z%\\S%\\&%m,

" We can ignore any other lines (%-G)
CompilerSet efm +=%-G%.%#

if filereadable("Makefile")
  CompilerSet makeprg=make
else
  CompilerSet makeprg=python
endif

" vim:foldmethod=marker:foldlevel=0

endif
