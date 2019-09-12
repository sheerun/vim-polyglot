if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vm') == -1

" Vim syntax file
" Language:	Velocity HTML template
" Maintainer:	Hsiaoming Young <http://lepture.com>
" Last Change:	2012 Jan 09

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

syn keyword velocityTodo FIXME TODO contained
syn region velocitySpec start="@" end=" " oneline contained
syn region velocityComment start="#\*" end="\*#" contains=velocityTodo,velocitySpec
syn match velocityComment /##.*/ contains=velocityTodo,velocitySpec
syn region velocityString start='"' end='"' oneline display
syn region velocityString start="'" end="'" oneline display
syn match velocityNumber "[-+]\=\d\+\(\.\d*\)\=" display
syn region velocityList start='\[' end='\]' oneline contained contains=velocityString,velocityNumber
syn match velocityMath /=\|-\|+\|\/\|\*\|%/ contained
syn match velocityBlock /#[a-z]\{2,\}/ contains=velocityStatement
syn match velocityBlock /#[a-z]\{2,\}(.\+)/ contains=velocityStatement,velocityVar,velocityString,velocityNumber,velocityMath,velocityList
syn keyword velocityStatement in set if else elseif end foreach include parse macro cmsparse stop break evaluate define contained

syn match velocityVar /$!\?[a-zA-Z][a-zA-Z0-9_-]\+\(\.\?[a-zA-Z0-9]*\)\+/ contains=velocityFunction display containedin=ALL
syn match velocityVar /$!\?{[a-zA-Z][a-zA-Z0-9_-]\+}/ display containedin=ALL
syn match velocityFunction /[a-zA-Z][a-zA-Z0-9_-]\+\(\.[a-zA-Z][a-zA-Z0-9_-]\+\)\+([^)]*)/ contains=velocityString,velocityNumber,velocityList,velocityMath,velocityVar,velocityFunction display containedin=velocityBlock

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_velocity_syn_inits")
  if version < 508
    let did_velocity_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink velocityString String
  HiLink velocityNumber Number
  HiLink velocityList Constant
  HiLink velocityBlock PreProc
  HiLink velocitySpec Special
  HiLink velocityVar Identifier
  HiLink velocityFunction Function
  HiLink velocityStatement Statement
  HiLink velocityComment Comment
  HiLink velocityTodo Todo

  delcommand HiLink
endif

let b:current_syntax = "velocity"

endif
