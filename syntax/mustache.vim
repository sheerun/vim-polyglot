" Mustache & Handlebars syntax
" Language:	Mustache, Handlebars
" Maintainer:	Juvenn Woo <machese@gmail.com>
" Screenshot:   http://imgur.com/6F408
" Version:	2
" Last Change:  Oct 26th 2013
" Remark:
"   It lexically hilights embedded mustaches (exclusively) in html file.
"   While it was written for Ruby-based Mustache template system, it should
"   work for Google's C-based *ctemplate* as well as Erlang-based *et*. All
"   of them are, AFAIK, based on the idea of ctemplate.
" References:
"   [Mustache](http://github.com/defunkt/mustache)
"   [Handlebars](https://github.com/wycats/handlebars.js)
"   [ctemplate](http://code.google.com/p/google-ctemplate/)
"   [ctemplate doc](http://google-ctemplate.googlecode.com/svn/trunk/doc/howto.html)
"   [et](http://www.ivan.fomichev.name/2008/05/erlang-template-engine-prototype.html)
" TODO: Feedback is welcomed.


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Standard HiLink will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syntax match mustacheError '}}}\?'
syntax match mustacheInsideError '{{[{$#<>=!\/]\?'
syntax region mustacheInside start=/{{/ end=/}}}\?/ keepend containedin=TOP,@htmlMustacheContainer
syntax match mustacheOperators '=\|\.\|/' contained containedin=mustacheInside,@htmlMustacheContainer
syntax region mustacheSection start='{{[$#^/]'lc=2 end=/}}/me=e-2 contained containedin=mustacheInside,@htmlMustacheContainer
syntax region mustachePartial start=/{{[<>]/lc=2 end=/}}/me=e-2 contained containedin=mustacheInside,@htmlMustacheContainer
syntax region mustacheMarkerSet start=/{{=/lc=2 end=/=}}/me=e-2 contained containedin=mustacheInside,@htmlMustacheContainer
syntax match mustacheHandlebars '{{\|}}' contained containedin=mustacheInside,@htmlMustacheContainer
syntax match mustacheUnescape '{{{\|}}}' contained containedin=mustacheInside,@htmlMustacheContainer
syntax match mustacheConditionals '\([/#]\(if\|unless\)\|else\)' contained containedin=mustacheInside
syntax match mustacheHelpers '[/#]\(with\|each\)' contained containedin=mustacheSection
syntax region mustacheComment start=/{{!/rs=s+2 end=/}}/re=e-2 contains=Todo contained containedin=mustacheInside,@htmlMustacheContainer
syntax region mustacheBlockComment start=/{{!--/rs=s+2 end=/--}}/re=e-2 contains=Todo contained containedin=mustacheInside,@htmlMustacheContainer
syntax region mustacheQString start=/'/ skip=/\\'/ end=/'/ contained containedin=mustacheInside
syntax region mustacheDQString start=/"/ skip=/\\"/ end=/"/ contained containedin=mustacheInside

" Clustering
syntax cluster htmlMustacheContainer add=htmlHead,htmlTitle,htmlString,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlLink,htmlBold,htmlUnderline,htmlItalic,htmlValue


" Hilighting
" mustacheInside hilighted as Number, which is rarely used in html
" you might like change it to Function or Identifier
HtmlHiLink mustacheVariable Number
HtmlHiLink mustacheVariableUnescape Number
HtmlHiLink mustachePartial Number
HtmlHiLink mustacheSection Number
HtmlHiLink mustacheMarkerSet Number

HtmlHiLink mustacheComment Comment
HtmlHiLink mustacheBlockComment Comment
HtmlHiLink mustacheError Error
HtmlHiLink mustacheInsideError Error

HtmlHiLink mustacheHandlebars Special
HtmlHiLink mustacheUnescape Identifier
HtmlHiLink mustacheOperators Operator
HtmlHiLink mustacheConditionals Conditional
HtmlHiLink mustacheHelpers Repeat
HtmlHiLink mustacheQString String
HtmlHiLink mustacheDQString String

syn region mustacheScriptTemplate start=+<script [^>]*type *=[^>]*text/\(mustache\|x-handlebars-template\)[^>]*>+
\                       end=+</script>+me=s-1 keepend
\                       contains=mustacheInside,@htmlMustacheContainer,htmlTag,htmlEndTag,htmlTagName,htmlSpecialChar

let b:current_syntax = "mustache"
delcommand HtmlHiLink
