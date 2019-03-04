if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'racket') != -1
  finish
endif

if !exists("g:raco_command")
  let g:raco_command = system("which raco")
endif
