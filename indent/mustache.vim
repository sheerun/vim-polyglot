if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'handlebars') == -1

" Mustache & Handlebars syntax
" Language:	Mustache, Handlebars
" Maintainer:	Juvenn Woo <machese@gmail.com>
" Screenshot:   http://imgur.com/6F408
" Version:	3
" Last Change:  26 Nov 2018
" Remarks: based on eruby indent plugin by tpope
" References:
"   [Mustache](http://github.com/defunkt/mustache)
"   [Handlebars](https://github.com/wycats/handlebars.js)
"   [ctemplate](http://code.google.com/p/google-ctemplate/)
"   [ctemplate doc](http://google-ctemplate.googlecode.com/svn/trunk/doc/howto.html)
"   [et](http://www.ivan.fomichev.name/2008/05/erlang-template-engine-prototype.html)

if exists("b:did_indent_hbs")
  finish
endif

unlet! b:did_indent
setlocal indentexpr=

runtime! indent/html.vim
unlet! b:did_indent

" Force HTML indent to not keep state.
let b:html_indent_usestate = 0

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:handlebars_subtype_indentexpr = &l:indentexpr

let b:did_indent = 1
let b:did_indent_hbs = 1

setlocal indentexpr=GetHandlebarsIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when

" Only define the function once.
if exists("*GetHandlebarsIndent")
  finish
endif

function! GetHandlebarsIndent(...)
  " The value of a single shift-width
  if exists('*shiftwidth')
    let sw = shiftwidth()
  else
    let sw = &sw
  endif

  if a:0 && a:1 == '.'
    let v:lnum = line('.')
  elseif a:0 && a:1 =~ '^\d'
    let v:lnum = a:1
  endif
  let vcol = col('.')
  call cursor(v:lnum,1)
  call cursor(v:lnum,vcol)
  exe "let ind = ".b:handlebars_subtype_indentexpr

  " Workaround for Andy Wokula's HTML indent. This should be removed after
  " some time, since the newest version is fixed in a different way.
  if b:handlebars_subtype_indentexpr =~# '^HtmlIndent('
  \ && exists('b:indent')
  \ && type(b:indent) == type({})
  \ && has_key(b:indent, 'lnum')
    " Force HTML indent to not keep state
    let b:indent.lnum = -1
  endif
  let lnum = prevnonblank(v:lnum-1)
  let prevLine = getline(lnum)
  let currentLine = getline(v:lnum)

  " all indent rules only apply if the block opening/closing
  " tag is on a separate line

  " indent after block {{#block
  if prevLine =~# '\v\s*\{\{[#^].*\s*'
    let ind = ind + sw
  endif
  " but not if the block ends on the same line
  if prevLine =~# '\v\s*\{\{\#(.+)(\s+|\}\}).*\{\{\/\1'
    let ind = ind - sw
  endif
  " unindent after block close {{/block}}
  if currentLine =~# '\v^\s*\{\{\/\S*\}\}\s*'
    let ind = ind - sw
  endif
  " indent after component block {{a-component
  if prevLine =~# '\v\s*\{\{\w'
    let ind = ind + sw
  endif
  " but not if the component block ends on the same line
  if prevLine =~# '\v\s*\{\{\w(.+)\}\}'
    let ind = ind - sw
  endif
  " unindent }} lines, and following lines if not inside a block expression
  let savedPos = getpos('.')
  if currentLine =~# '\v^\s*\}\}\s*$' || (currentLine !~# '\v^\s*\{\{\/' && prevLine =~# '\v^\s*[^\{\} \t]+\}\}\s*$')
    let closingLnum = search('}}\s*$', 'Wbc', lnum)
    let [openingLnum, col] = searchpairpos('{{', '', '}}', 'Wb')
    if openingLnum > 0 && closingLnum > 0
      if strpart(getline(openingLnum), col - 1, 3) !~ '{{[#^]'
        let ind = ind - sw
      endif
    else
      call setpos('.', savedPos)
    endif
  endif
  " unindent {{else}}
  if currentLine =~# '\v^\s*\{\{else.*\}\}\s*$'
    let ind = ind - sw
  endif
  " indent again after {{else}}
  if prevLine =~# '\v^\s*\{\{else.*\}\}\s*$'
    let ind = ind + sw
  endif

  return ind
endfunction

endif
