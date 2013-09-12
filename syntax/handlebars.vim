" Handlebars syntax
" Language:    Handlebars
" Maintainer:  Bruno Michel <brmichel@free.fr>
" Last Change: Mar 8th, 2013
" Version:	   0.3
" URL:         https://github.com/nono/vim-handlebars

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

ru! syntax/html.vim
unlet b:current_syntax


syn keyword hbsTodo             TODO FIXME XXX contained

syn match   hbsError            /}}}\?/
syn match   hbsInsideError      /{{[{#<>=!\/]\?/   containedin=@hbsInside

syn cluster htmlHbsContainer   add=htmlHead,htmlTitle,htmlString,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6
syn region  hbsInside          start=/{{/ end=/}}/  keepend transparent containedin=@htmlHbsContainer

syn match   hbsHandlebars      "{{\|}}"                                 containedin=hbsInside
syn match   hbsUnescape        "{{{\|}}}"                               containedin=hbsInside
syn match   hbsOperators       "=\|\.\|/"                               containedin=hbsInside

syn region  hbsSection         start="{{[#/]"lc=2 end=/}}/me=e-2        containedin=hbsInside
syn region  hbsPartial         start=/{{[<>]/lc=2 end=/}}/me=e-2        containedin=hbsInside
syn region  hbsMarkerSet       start=/{{=/lc=2    end=/=}}/me=e-2       containedin=hbsInside

syn region  hbsComment         start=/{{!/rs=s+2    end=/}}/re=e-2      containedin=htmlHead contains=hbsTodo,Todo
syn region  hbsBlockComment    start=/{{!--/rs=s+2  end=/--}}/re=e-2    containedin=htmlHead contains=hbsTodo,Todo
syn region  hbsQString         start=/'/ skip=/\\'/ end=/'/             containedin=hbsInside
syn region  hbsDQString        start=/"/ skip=/\\"/ end=/"/             containedin=hbsInside

syn match   hbsConditionals    "\([/#]\(if\|unless\)\|else\)"           containedin=hbsInside
syn match   hbsHelpers         "[/#]\(with\|each\)"                     containedin=hbsInside


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lisp_syntax_inits")
  if version < 508
    let did_lisp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink hbsTodo          Todo

  HiLink hbsError         Error
  HiLink hbsInsideError   Error

  HiLink hbsHandlebars    Identifier
  HiLink hbsUnescape      Special
  HiLink hbsOperators     Operator

  HiLink hbsConditionals  Conditional
  HiLink hbsHelpers       Repeat

  HiLink hbsSection       Number
  HiLink hbsPartial       Include
  HiLink hbsMarkerSet     Number

  HiLink hbsBlockComment  Comment
  HiLink hbsComment       Comment
  HiLink hbsQString       String
  HiLink hbsDQString      String

  delcommand HiLink
endif


let b:current_syntax = 'handlebars'
