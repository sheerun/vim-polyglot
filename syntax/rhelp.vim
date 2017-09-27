if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vim') == -1
  
" Vim syntax file
" Language:    R Help File
" Maintainer: Jakson Aquino <jalvesaq@gmail.com>
" Former Maintainer: Johannes Ranke <jranke@uni-bremen.de>
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change: Tue Jun 28, 2016  08:53AM
" Remarks:     - Includes R syntax highlighting in the appropriate
"                sections if an r.vim file is in the same directory or in the
"                default debian location.
"              - There is no Latex markup in equations
"              - Thanks to Will Gray for finding and fixing a bug
"              - No support for \var tag within quoted string

" Version Clears: {{{1
if exists("b:current_syntax")
  finish
endif 

scriptencoding utf-8

syn case match

" R help identifiers {{{1
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\name{" end="}" 
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\alias{" end="}" 
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\pkg{" end="}" contains=rhelpLink
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\CRANpkg{" end="}" contains=rhelpLink
syn region rhelpIdentifier matchgroup=rhelpSection start="\\method{" end="}" contained
syn region rhelpIdentifier matchgroup=rhelpSection start="\\Rdversion{" end="}"


" Highlighting of R code using an existing r.vim syntax file if available {{{1
syn include @R syntax/r.vim

" Strings {{{1
syn region rhelpString start=/"/ skip=/\\"/ end=/"/ contains=rhelpSpecialChar,rhelpCodeSpecial,rhelpLink contained

" Special characters in R strings
syn match rhelpCodeSpecial display contained "\\\\\(n\|r\|t\|b\|a\|f\|v\|'\|\"\)\|\\\\"

" Special characters  ( \$ \& \% \# \{ \} \_)
syn match rhelpSpecialChar        "\\[$&%#{}_]"


" R code {{{1
syn match rhelpDots		"\\dots" containedin=@R
syn region rhelpRcode matchgroup=Delimiter start="\\examples{" matchgroup=Delimiter transparent end="}" contains=@R,rhelpLink,rhelpIdentifier,rhelpString,rhelpSpecialChar,rhelpSection
syn region rhelpRcode matchgroup=Delimiter start="\\usage{" matchgroup=Delimiter transparent end="}" contains=@R,rhelpIdentifier,rhelpS4method
syn region rhelpRcode matchgroup=Delimiter start="\\synopsis{" matchgroup=Delimiter transparent end="}" contains=@R
syn region rhelpRcode matchgroup=Delimiter start="\\special{" matchgroup=Delimiter transparent end="}" contains=@R

if v:version > 703
  syn region rhelpRcode matchgroup=Delimiter start="\\code{" skip='\\\@1<!{.\{-}\\\@1<!}' transparent end="}" contains=@R,rhelpDots,rhelpString,rhelpSpecialChar,rhelpLink keepend
else
  syn region rhelpRcode matchgroup=Delimiter start="\\code{" skip='\\\@<!{.\{-}\\\@<!}' transparent end="}" contains=@R,rhelpDots,rhelpString,rhelpSpecialChar,rhelpLink keepend
endif
syn region rhelpS4method matchgroup=Delimiter start="\\S4method{.*}(" matchgroup=Delimiter transparent end=")" contains=@R,rhelpDots
syn region rhelpSexpr matchgroup=Delimiter start="\\Sexpr{" matchgroup=Delimiter transparent end="}" contains=@R

" PreProc {{{1
syn match rhelpPreProc "^#ifdef.*" 
syn match rhelpPreProc "^#endif.*" 

" Special Delimiters {{{1
syn match rhelpDelimiter		"\\cr"
syn match rhelpDelimiter		"\\tab "

" Keywords {{{1
syn match rhelpKeyword	"\\R\>"
syn match rhelpKeyword	"\\ldots\>"
syn match rhelpKeyword	"\\sspace\>"
syn match rhelpKeyword  "--"
syn match rhelpKeyword  "---"

" Condition Keywords {{{2
syn match rhelpKeyword	"\\if\>"
syn match rhelpKeyword	"\\ifelse\>"
syn match rhelpKeyword	"\\out\>"
" Examples of usage:
" \ifelse{latex}{\eqn{p = 5 + 6 - 7 \times 8}}{\eqn{p = 5 + 6 - 7 * 8}}
" \ifelse{latex}{\out{$\alpha$}}{\ifelse{html}{\out{&alpha;}}{alpha}}

" Keywords and operators valid only if in math mode {{{2
syn match rhelpMathOp  "<" contained
syn match rhelpMathOp  ">" contained
syn match rhelpMathOp  "+" contained
syn match rhelpMathOp  "-" contained
syn match rhelpMathOp  "=" contained

" Conceal function based on syntax/tex.vim {{{2
if exists("g:tex_conceal")
  let s:tex_conceal = g:tex_conceal
else
  let s:tex_conceal = 'gm'
endif
function s:HideSymbol(pat, cchar, hide)
  if a:hide
    exe "syn match rhelpMathSymb '" . a:pat . "' contained conceal cchar=" . a:cchar
  else
    exe "syn match rhelpMathSymb '" . a:pat . "' contained"
  endif
endfunction

" Math symbols {{{2
if s:tex_conceal =~ 'm'
  let s:hd = 1
else
  let s:hd = 0
endif
call s:HideSymbol('\\infty\>',  '∞', s:hd)
call s:HideSymbol('\\ge\>',     '≥', s:hd)
call s:HideSymbol('\\le\>',     '≤', s:hd)
call s:HideSymbol('\\prod\>',   '∏', s:hd)
call s:HideSymbol('\\sum\>',    '∑', s:hd)
syn match rhelpMathSymb   	"\\sqrt\>" contained

" Greek letters {{{2
if s:tex_conceal =~ 'g'
  let s:hd = 1
else
  let s:hd = 0
endif
call s:HideSymbol('\\alpha\>',    'α', s:hd)
call s:HideSymbol('\\beta\>',     'β', s:hd)
call s:HideSymbol('\\gamma\>',    'γ', s:hd)
call s:HideSymbol('\\delta\>',    'δ', s:hd)
call s:HideSymbol('\\epsilon\>',  'ϵ', s:hd)
call s:HideSymbol('\\zeta\>',     'ζ', s:hd)
call s:HideSymbol('\\eta\>',      'η', s:hd)
call s:HideSymbol('\\theta\>',    'θ', s:hd)
call s:HideSymbol('\\iota\>',     'ι', s:hd)
call s:HideSymbol('\\kappa\>',    'κ', s:hd)
call s:HideSymbol('\\lambda\>',   'λ', s:hd)
call s:HideSymbol('\\mu\>',       'μ', s:hd)
call s:HideSymbol('\\nu\>',       'ν', s:hd)
call s:HideSymbol('\\xi\>',       'ξ', s:hd)
call s:HideSymbol('\\pi\>',       'π', s:hd)
call s:HideSymbol('\\rho\>',      'ρ', s:hd)
call s:HideSymbol('\\sigma\>',    'σ', s:hd)
call s:HideSymbol('\\tau\>',      'τ', s:hd)
call s:HideSymbol('\\upsilon\>',  'υ', s:hd)
call s:HideSymbol('\\phi\>',      'ϕ', s:hd)
call s:HideSymbol('\\chi\>',      'χ', s:hd)
call s:HideSymbol('\\psi\>',      'ψ', s:hd)
call s:HideSymbol('\\omega\>',    'ω', s:hd)
call s:HideSymbol('\\Gamma\>',    'Γ', s:hd)
call s:HideSymbol('\\Delta\>',    'Δ', s:hd)
call s:HideSymbol('\\Theta\>',    'Θ', s:hd)
call s:HideSymbol('\\Lambda\>',   'Λ', s:hd)
call s:HideSymbol('\\Xi\>',       'Ξ', s:hd)
call s:HideSymbol('\\Pi\>',       'Π', s:hd)
call s:HideSymbol('\\Sigma\>',    'Σ', s:hd)
call s:HideSymbol('\\Upsilon\>',  'Υ', s:hd)
call s:HideSymbol('\\Phi\>',      'Φ', s:hd)
call s:HideSymbol('\\Psi\>',      'Ψ', s:hd)
call s:HideSymbol('\\Omega\>',    'Ω', s:hd)
delfunction s:HideSymbol
" Note: The letters 'omicron', 'Alpha', 'Beta', 'Epsilon', 'Zeta', 'Eta',
" 'Iota', 'Kappa', 'Mu', 'Nu', 'Omicron', 'Rho', 'Tau' and 'Chi' are listed
" at src/library/tools/R/Rd2txt.R because they are valid in HTML, although
" they do not make valid LaTeX code (e.g. &Alpha; versus \Alpha).

" Links {{{1
syn region rhelpLink matchgroup=rhelpType start="\\link{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\link\[.\{-}\]{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\linkS4class{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\url{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\href{" end="}" contained keepend extend
syn region rhelpLink matchgroup=rhelpType start="\\figure{" end="}" contained keepend extend

" Verbatim like {{{1
syn region rhelpVerbatim matchgroup=rhelpType start="\\samp{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpSpecialChar,rhelpComment
syn region rhelpVerbatim matchgroup=rhelpType start="\\verb{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpSpecialChar,rhelpComment

" Equation {{{1
syn region rhelpEquation matchgroup=rhelpType start="\\eqn{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpMathSymb,rhelpMathOp,rhelpRegion contained keepend extend
syn region rhelpEquation matchgroup=rhelpType start="\\deqn{" skip='\\\@1<!{.\{-}\\\@1<!}' end="}" contains=rhelpMathSymb,rhelpMathOp,rhelpRegion contained keepend extend

" Type Styles {{{1
syn match rhelpType		"\\emph\>"
syn match rhelpType		"\\strong\>"
syn match rhelpType		"\\bold\>"
syn match rhelpType		"\\sQuote\>"
syn match rhelpType		"\\dQuote\>"
syn match rhelpType		"\\preformatted\>"
syn match rhelpType		"\\kbd\>"
syn match rhelpType		"\\file\>"
syn match rhelpType		"\\email\>"
syn match rhelpType		"\\enc\>"
syn match rhelpType		"\\var\>"
syn match rhelpType		"\\env\>"
syn match rhelpType		"\\option\>"
syn match rhelpType		"\\command\>"
syn match rhelpType		"\\newcommand\>"
syn match rhelpType		"\\renewcommand\>"
syn match rhelpType		"\\dfn\>"
syn match rhelpType		"\\cite\>"
syn match rhelpType		"\\acronym\>"
syn match rhelpType		"\\doi\>"

" rhelp sections {{{1
syn match rhelpSection		"\\encoding\>"
syn match rhelpSection		"\\title\>"
syn match rhelpSection		"\\item\>"
syn match rhelpSection		"\\description\>"
syn match rhelpSection		"\\concept\>"
syn match rhelpSection		"\\arguments\>"
syn match rhelpSection		"\\details\>"
syn match rhelpSection		"\\value\>"
syn match rhelpSection		"\\references\>"
syn match rhelpSection		"\\note\>"
syn match rhelpSection		"\\author\>"
syn match rhelpSection		"\\seealso\>"
syn match rhelpSection		"\\keyword\>"
syn match rhelpSection		"\\docType\>"
syn match rhelpSection		"\\format\>"
syn match rhelpSection		"\\source\>"
syn match rhelpSection    "\\itemize\>"
syn match rhelpSection    "\\describe\>"
syn match rhelpSection    "\\enumerate\>"
syn match rhelpSection    "\\item "
syn match rhelpSection    "\\item$"
syn match rhelpSection		"\\tabular{[lcr]*}"
syn match rhelpSection		"\\dontrun\>"
syn match rhelpSection		"\\dontshow\>"
syn match rhelpSection		"\\testonly\>"
syn match rhelpSection		"\\donttest\>"

" Freely named Sections {{{1
syn region rhelpFreesec matchgroup=Delimiter start="\\section{" matchgroup=Delimiter transparent end="}"
syn region rhelpFreesubsec matchgroup=Delimiter start="\\subsection{" matchgroup=Delimiter transparent end="}" 

syn match rhelpDelimiter "{\|\[\|(\|)\|\]\|}"

" R help file comments {{{1
syn match rhelpComment /%.*$/

" Error {{{1
syn region rhelpRegion matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ contains=@Spell,rhelpCodeSpecial,rhelpComment,rhelpDelimiter,rhelpDots,rhelpFreesec,rhelpFreesubsec,rhelpIdentifier,rhelpKeyword,rhelpLink,rhelpPreProc,rhelpRComment,rhelpRcode,rhelpRegion,rhelpS4method,rhelpSection,rhelpSexpr,rhelpSpecialChar,rhelpString,rhelpType,rhelpVerbatim,rhelpEquation
syn region rhelpRegion matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ contains=@Spell,rhelpCodeSpecial,rhelpComment,rhelpDelimiter,rhelpDots,rhelpFreesec,rhelpFreesubsec,rhelpIdentifier,rhelpKeyword,rhelpLink,rhelpPreProc,rhelpRComment,rhelpRcode,rhelpRegion,rhelpS4method,rhelpSection,rhelpSexpr,rhelpSpecialChar,rhelpString,rhelpType,rhelpVerbatim,rhelpEquation
syn region rhelpRegion matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ contains=@Spell,rhelpCodeSpecial,rhelpComment,rhelpDelimiter,rhelpDots,rhelpFreesec,rhelpFreesubsec,rhelpIdentifier,rhelpKeyword,rhelpLink,rhelpPreProc,rhelpRComment,rhelpRcode,rhelpRegion,rhelpS4method,rhelpSection,rhelpSexpr,rhelpSpecialChar,rhelpString,rhelpType,rhelpVerbatim,rhelpEquation
syn match rhelpError      /[)\]}]/
syn match rhelpBraceError /[)}]/ contained
syn match rhelpCurlyError /[)\]]/ contained
syn match rhelpParenError /[\]}]/ contained

syntax sync match rhelpSyncRcode grouphere rhelpRcode "\\examples{"

" Define the default highlighting {{{1
hi def link rhelpVerbatim    String
hi def link rhelpDelimiter   Delimiter
hi def link rhelpIdentifier  Identifier
hi def link rhelpString      String
hi def link rhelpCodeSpecial Special
hi def link rhelpKeyword     Keyword
hi def link rhelpDots        Keyword
hi def link rhelpLink        Underlined
hi def link rhelpType        Type
hi def link rhelpSection     PreCondit
hi def link rhelpError       Error
hi def link rhelpBraceError  Error
hi def link rhelpCurlyError  Error
hi def link rhelpParenError  Error
hi def link rhelpPreProc     PreProc
hi def link rhelpDelimiter   Delimiter
hi def link rhelpComment     Comment
hi def link rhelpRComment    Comment
hi def link rhelpSpecialChar SpecialChar
hi def link rhelpMathSymb    Special
hi def link rhelpMathOp      Operator

let   b:current_syntax = "rhelp"

" vim: foldmethod=marker sw=2

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'r-lang') == -1
  
" Vim syntax file
" Language:    R Help File
" Maintainer:  Johannes Ranke <jranke@uni-bremen.de>
" Last Change: 2006 Apr 24
" Version:     0.7
" SVN:		   $Id: rhelp.vim 57 2006-04-24 15:52:13Z ranke $
" Remarks:     - Now includes R syntax highlighting in the appropriate
"                sections if an r.vim file is in the same directory or in the
"                default debian location.
"              - There is no Latex markup in equations

" Version Clears: {{{1
" For version 5.x: Clear all syntax items
" For version 6.x and 7.x: Quit when a syntax file was already loaded
if version < 600 
  syntax clear
elseif exists("b:current_syntax")
  finish
endif 

syn case match

" R help identifiers {{{
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\name{" end="}" 
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\alias{" end="}" 
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\pkg{" end="}" 
syn region rhelpIdentifier matchgroup=rhelpSection	start="\\item{" end="}" contained contains=rhelpDots
syn region rhelpIdentifier matchgroup=rhelpSection start="\\method{" end=/}/ contained

" Highlighting of R code using an existing r.vim syntax file if available {{{1
syn include @R syntax/r.vim
syn match rhelpDots		"\\dots" containedin=@R
syn region rhelpRcode matchgroup=Delimiter start="\\examples{" matchgroup=Delimiter transparent end=/}/ contains=@R,rhelpSection
syn region rhelpRcode matchgroup=Delimiter start="\\usage{" matchgroup=Delimiter transparent end=/}/ contains=@R,rhelpIdentifier,rhelpS4method
syn region rhelpRcode matchgroup=Delimiter start="\\synopsis{" matchgroup=Delimiter transparent end=/}/ contains=@R
syn region rhelpRcode matchgroup=Delimiter start="\\special{" matchgroup=Delimiter transparent end=/}/ contains=@R contained
syn region rhelpRcode matchgroup=Delimiter start="\\code{" matchgroup=Delimiter transparent end=/}/ contains=@R,rhelpLink contained
syn region rhelpS4method matchgroup=Delimiter start="\\S4method{.*}(" matchgroup=Delimiter transparent end=/)/ contains=@R,rhelpDots contained

" Strings {{{1
syn region rhelpString start=/"/ end=/"/ 

" Special characters  ( \$ \& \% \# \{ \} \_) {{{1
syn match rhelpSpecialChar        "\\[$&%#{}_]"

" Special Delimiters {{{1
syn match rhelpDelimiter		"\\cr"
syn match rhelpDelimiter		"\\tab "

" Keywords {{{1
syn match rhelpKeyword	"\\R"
syn match rhelpKeyword	"\\ldots"
syn match rhelpKeyword  "--"
syn match rhelpKeyword  "---"
syn match rhelpKeyword  "<"
syn match rhelpKeyword  ">"

" Links {{{1
syn region rhelpLink matchgroup=rhelpSection start="\\link{" end="}" contained keepend
syn region rhelpLink matchgroup=rhelpSection start="\\link\[.*\]{" end="}" contained keepend
syn region rhelpLink matchgroup=rhelpSection start="\\linkS4class{" end="}" contained keepend

" Type Styles {{{1
syn match rhelpType		"\\emph\>"
syn match rhelpType		"\\strong\>"
syn match rhelpType		"\\bold\>"
syn match rhelpType		"\\sQuote\>"
syn match rhelpType		"\\dQuote\>"
syn match rhelpType		"\\preformatted\>"
syn match rhelpType		"\\kbd\>"
syn match rhelpType		"\\samp\>"
syn match rhelpType		"\\eqn\>"
syn match rhelpType		"\\deqn\>"
syn match rhelpType		"\\file\>"
syn match rhelpType		"\\email\>"
syn match rhelpType		"\\url\>"
syn match rhelpType		"\\var\>"
syn match rhelpType		"\\env\>"
syn match rhelpType		"\\option\>"
syn match rhelpType		"\\command\>"
syn match rhelpType		"\\dfn\>"
syn match rhelpType		"\\cite\>"
syn match rhelpType		"\\acronym\>"

" rhelp sections {{{1
syn match rhelpSection		"\\encoding\>"
syn match rhelpSection		"\\title\>"
syn match rhelpSection		"\\description\>"
syn match rhelpSection		"\\concept\>"
syn match rhelpSection		"\\arguments\>"
syn match rhelpSection		"\\details\>"
syn match rhelpSection		"\\value\>"
syn match rhelpSection		"\\references\>"
syn match rhelpSection		"\\note\>"
syn match rhelpSection		"\\author\>"
syn match rhelpSection		"\\seealso\>"
syn match rhelpSection		"\\keyword\>"
syn match rhelpSection		"\\docType\>"
syn match rhelpSection		"\\format\>"
syn match rhelpSection		"\\source\>"
syn match rhelpSection     "\\itemize\>"
syn match rhelpSection     "\\describe\>"
syn match rhelpSection     "\\enumerate\>"
syn match rhelpSection     "\\item "
syn match rhelpSection     "\\item$"
syn match rhelpSection		"\\tabular{[lcr]*}"
syn match rhelpSection		"\\dontrun\>"
syn match rhelpSection		"\\dontshow\>"
syn match rhelpSection		"\\testonly\>"

" Freely named Sections {{{1
syn region rhelpFreesec matchgroup=Delimiter start="\\section{" matchgroup=Delimiter transparent end=/}/ 

" R help file comments {{{1
syn match rhelpComment /%.*$/ contained 

" Error {{{1
syn region rhelpRegion matchgroup=Delimiter start=/(/ matchgroup=Delimiter end=/)/ transparent contains=ALLBUT,rhelpError,rhelpBraceError,rhelpCurlyError
syn region rhelpRegion matchgroup=Delimiter start=/{/ matchgroup=Delimiter end=/}/ transparent contains=ALLBUT,rhelpError,rhelpBraceError,rhelpParenError
syn region rhelpRegion matchgroup=Delimiter start=/\[/ matchgroup=Delimiter end=/]/ transparent contains=ALLBUT,rhelpError,rhelpCurlyError,rhelpParenError
syn match rhelpError      /[)\]}]/
syn match rhelpBraceError /[)}]/ contained
syn match rhelpCurlyError /[)\]]/ contained
syn match rhelpParenError /[\]}]/ contained

" Define the default highlighting {{{1
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_rhelp_syntax_inits")
  if version < 508
    let did_rhelp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink rhelpIdentifier  Identifier
  HiLink rhelpString      String
  HiLink rhelpKeyword     Keyword
  HiLink rhelpDots        Keyword
  HiLink rhelpLink        Underlined
  HiLink rhelpType	      Type
  HiLink rhelpSection     PreCondit
  HiLink rhelpError       Error
  HiLink rhelpBraceError  Error
  HiLink rhelpCurlyError  Error
  HiLink rhelpParenError  Error
  HiLink rhelpDelimiter   Delimiter
  HiLink rhelpComment     Comment
  HiLink rhelpRComment    Comment
  HiLink rhelpSpecialChar SpecialChar
  delcommand HiLink
endif 

let   b:current_syntax = "rhelp"
" vim: foldmethod=marker:

endif
