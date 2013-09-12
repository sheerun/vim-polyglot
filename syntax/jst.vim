if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'jst'
endif

if !exists("g:jst_default_subtype")
  let g:jst_default_subtype = "html"
endif

if &filetype =~ '^jst\.'
  let b:jst_subtype = matchstr(&filetype,'^jst\.\zs\w\+')
elseif !exists("b:jst_subtype") && main_syntax == 'jst'
  let s:lines = getline(1)."\n".getline(2)."\n".getline(3)."\n".getline(4)."\n".getline(5)."\n".getline("$")
  let b:jst_subtype = matchstr(s:lines,'jst_subtype=\zs\w\+')
  if b:jst_subtype == ''
    let b:jst_subtype = matchstr(substitute(expand("%:t"),'\c\%(\.jst\)\+$','',''),'\.\zs\w\+$')
  endif
  if b:jst_subtype == 'rhtml'
    let b:jst_subtype = 'html'
  elseif b:jst_subtype == 'hamljs'
    let b:jst_subtype = 'haml'
  elseif b:jst_subtype == 'ejs'
    let b:jst_subtype = 'html'
  elseif b:jst_subtype == 'rb'
    let b:jst_subtype = 'ruby'
  elseif b:jst_subtype == 'yml'
    let b:jst_subtype = 'yaml'
  elseif b:jst_subtype == 'js'
    let b:jst_subtype = 'javascript'
  elseif b:jst_subtype == 'txt'
    " Conventional; not a real file type
    let b:jst_subtype = 'text'
  elseif b:jst_subtype == ''
    let b:jst_subtype = g:jst_default_subtype
  endif
endif

if !exists("b:jst_nest_level")
  let b:jst_nest_level = strlen(substitute(substitute(substitute(expand("%:t"),'@','','g'),'\c\.\%(erb\|rhtml\)\>','@','g'),'[^@]','','g'))
endif
if !b:jst_nest_level
  let b:jst_nest_level = 1
endif

if exists("b:jst_subtype") && b:jst_subtype != ''
  exe "runtime! syntax/".b:jst_subtype.".vim"
  unlet! b:current_syntax
endif

syn include @jsTop syntax/javascript.vim

syn cluster jstRegions contains=jstOneLiner,jstBlock,jstExpression,jstComment

exe 'syn region  jstOneLiner   matchgroup=jstDelimiter start="^%\{1,'.b:jst_nest_level.'\}%\@!"    end="$"     contains=@jsTop	     containedin=ALLBUT,@jstRegions keepend oneline'
exe 'syn region  jstBlock      matchgroup=jstDelimiter start="<%\{1,'.b:jst_nest_level.'\}%\@!-\=" end="[=-]\=%\@<!%\{1,'.b:jst_nest_level.'\}>" contains=@jsTop  containedin=ALLBUT,@jstRegions keepend'
exe 'syn region  jstExpression matchgroup=jstDelimiter start="<%\{1,'.b:jst_nest_level.'\}=\{1,4}" end="[=-]\=%\@<!%\{1,'.b:jst_nest_level.'\}>" contains=@jsTop  containedin=ALLBUT,@jstRegions keepend'
exe 'syn region  jstComment    matchgroup=jstDelimiter start="<%\{1,'.b:jst_nest_level.'\}#"       end="%\@<!%\{1,'.b:jst_nest_level.'\}>" contains=jsTodo,@Spell containedin=ALLBUT,@jstRegions keepend'

" Define the default highlighting.

hi def link jstDelimiter		PreProc
hi def link jstComment		Comment

let b:current_syntax = 'jst'

if main_syntax == 'jst'
  unlet main_syntax
endif

" vim: nowrap sw=2 sts=2 ts=8:
