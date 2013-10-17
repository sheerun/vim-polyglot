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


syn region  hbsInside          start=/{{/ end=/}}/ keepend

syn keyword hbsTodo            TODO FIXME XXX contained

syn match   hbsError           /}}}\?/
syn match   hbsInsideError     /{{[{#<>=!\/]\?/                         contained containedin=@hbsInside

syn match   hbsHandlebars      "{{\|}}"                                 contained containedin=hbsInside
syn match   hbsUnescape        "{{{\|}}}"                               contained containedin=hbsInside extend
syn match   hbsOperators       "=\|\.\|/"                               contained containedin=hbsInside

syn region  hbsSection         start="{{[#/]"lc=2 end=/}}/me=e-2        contained containedin=hbsInside
syn region  hbsPartial         start=/{{[<>]/lc=2 end=/}}/me=e-2        contained containedin=hbsInside
syn region  hbsMarkerSet       start=/{{=/lc=2    end=/=}}/me=e-2       contained containedin=hbsInside

syn region  hbsComment         start=/{{!/rs=s+2    end=/}}/re=e-2      contained containedin=hbsInside contains=hbsTodo,Todo
syn region  hbsBlockComment    start=/{{!--/rs=s+2  end=/--}}/re=e-2    contained containedin=hbsInside contains=hbsTodo,Todo extend
syn region  hbsQString         start=/'/ skip=/\\'/ end=/'/             contained containedin=hbsInside
syn region  hbsDQString        start=/"/ skip=/\\"/ end=/"/             contained containedin=hbsInside

syn match   hbsConditionals    "\([/#]\(if\|unless\)\|else\)"           contained containedin=hbsInside
syn match   hbsHelpers         "[/#]\(with\|each\)"                     contained containedin=hbsInside

syn cluster allHbsItems        add=hbsTodo,hbsError,hbsInsideError,hbsInside,hbsHandlebars,
\                                  hbsUnescape,hbsOperators,hbsSection,hbsPartial,hbsMarkerSet,
\                                  hbsComment,hbsBlockComment,hbsQString,hbsDQString,hbsConditionals,
\                                  hbsHelpers,hbsPartial,hbsMarkerSet,hbsComment,hbsBlockComment,
\                                  hbsQString,hbsDQString,hbsConditionals,hbsHelpers

syn cluster htmlAdditional     add=htmlTag,htmlEndTag,htmlTagName,htmlSpecialChar

syn region  hbsScriptTemplate  start=+<script [^>]*type *=[^>]*text/x-handlebars-template[^>]*>+
\                              end=+</script>+me=s-1 keepend contains=@htmlHbsContainer,@allHbsItems,@htmlAdditional


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
