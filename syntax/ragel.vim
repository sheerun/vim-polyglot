if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ragel') == -1

" Vim syntax file
"
" Language: Ragel
" Author: Adrian Thurston

syntax clear

if !exists("g:ragel_default_subtype")
  let g:ragel_default_subtype = 'c'
endif

function! <SID>Split(path) abort " {{{1
  if type(a:path) == type([]) | return a:path | endif
  let split = split(a:path,'\\\@<!\%(\\\\\)*\zs,')
  return map(split,'substitute(v:val,''\\\([\\,]\)'',''\1'',"g")')
endfunction " }}}1

fun! <SID>ReadOnPath(script)
  for dir in <SID>Split(&rtp)
    let filepath = dir.'/'.a:script
    if filereadable(filepath)
      return join(readfile(filepath), " | ")
    endif
  endfor
endfun

" Try to detect the subtype. stolen from eruby.vim
if !exists("b:ragel_subtype") || b:ragel_subtype == ''
  " first check for an annotation in the first 5 lines or on the last line
  let s:lines = getline(1)."\n".getline(2)."\n".getline(3)."\n".getline(4)."\n".getline(5)."\n".getline("$")
  let b:ragel_subtype = matchstr(s:lines, 'ragel_subtype=\zs\w\+')

  " failing that, check the filename for .*.rl
  if b:ragel_subtype == ''
    let b:ragel_subtype = matchstr(substitute(expand("%:t"),'\c\%(\.rl\|\.ragel\)\+$','',''),'\.\zs\w\+$')

    " ...and do a couple of transformations if necessary

    " .rb -> ruby
    if b:ragel_subtype == 'rb'
      let b:ragel_subtype = 'ruby'

    " .m -> objc
    elseif b:ragel_subtype == 'm'
      let b:ragel_subtype = 'objc'
    
    " .cxx -> cpp
    elseif b:ragel_subtype == 'cxx'
      let b:ragel_subtype = 'cpp'
    endif
  endif

  " default to g:ragel_default_subtype
  if b:ragel_subtype == ''
    let b:ragel_subtype = g:ragel_default_subtype
  endif
endif

if exists('b:ragel_subtype') && b:ragel_subtype != ''
  exec 'runtime! syntax/'.b:ragel_subtype.'.vim'
  " source s:subtype_file
  unlet! b:current_syntax
endif

" Identifiers
syntax match anyId "[a-zA-Z_][a-zA-Z_0-9]*" contained

" Inline code only
syntax keyword fsmType fpc fc fcurs fbuf fblen ftargs fstack contained
syntax keyword fsmKeyword fhold fgoto fcall fret fentry fnext fexec fbreak contained

syntax cluster rlItems contains=rlComment,rlLiteral,rlAugmentOps,rlOtherOps,rlKeywords,rlWrite,rlCodeCurly,rlCodeSemi,rlNumber,anyId,rlLabelColon,rlExprKeywords

syntax region machineSpec1 matchgroup=beginRL start="%%{" end="}%%" contains=@rlItems
syntax region machineSpec2 matchgroup=beginRL start="%%[^{]"rs=e-1 end="$" keepend contains=@rlItems
syntax region machineSpec2 matchgroup=beginRL start="%%$" end="$" keepend contains=@rlItems

" Comments
syntax match rlComment "#.*$" contained

" Literals
" single quoted strings  '...'
  syntax match rlLiteral "'\(\\.\|[^'\\]\)*'[i]*" contained
" double quoted strings  "..."
  syntax match rlLiteral "\"\(\\.\|[^\"\\]\)*\"[i]*" contained
" simple regexes         /.../
  syntax match rlLiteral /\/\(\\.\|[^\/\\]\)*\/[i]*/ contained
" char unions            [...]
  syntax match rlLiteral "\[\(\\.\|[^\]\\]\)*\]" contained

" Numbers
syntax match rlNumber "[0-9][0-9]*" contained
syntax match rlNumber "0x[0-9a-fA-F][0-9a-fA-F]*" contained

" Operators
syntax match rlAugmentOps "[>$%@]" contained
syntax match rlAugmentOps "<>\|<" contained
syntax match rlAugmentOps "[>\<$%@][!\^/*~]" contained
syntax match rlAugmentOps "[>$%]?" contained
syntax match rlAugmentOps "<>[!\^/*~]" contained
syntax match rlAugmentOps "=>" contained
syntax match rlOtherOps "->" contained

syntax match rlOtherOps ":>" contained
syntax match rlOtherOps ":>>" contained
syntax match rlOtherOps "<:" contained

" Keywords
" FIXME: Enable the range keyword post 5.17.
" syntax keyword rlKeywords machine action context include range contained
syntax keyword rlKeywords machine action context include import export prepush postpop contained
syntax keyword rlExprKeywords when inwhen outwhen err lerr eof from to contained

" Case Labels
syntax keyword caseLabelKeyword case contained
syntax cluster caseLabelItems contains=caseLabelKeyword,anyId,fsmType,fsmKeyword
syntax match caseLabelColon "case" contains=@caseLabelItems contained
syntax match caseLabelColon "case[\t ]\+.*:$" contains=@caseLabelItems contained
syntax match caseLabelColon "case[\t ]\+.*:[^=:]"me=e-1 contains=@caseLabelItems contained

syntax match rlLabelColon "[a-zA-Z_][a-zA-Z_0-9]*[ \t]*:$" contained contains=anyLabel
syntax match rlLabelColon "[a-zA-Z_][a-zA-Z_0-9]*[ \t]*:[^=:>]"me=e-1 contained contains=anyLabel
syntax match anyLabel "[a-zA-Z_][a-zA-Z_0-9]*" contained

" All items that can go in a code block.

syntax cluster inlineItems contains=TOP add=anyId,fsmType,fsmKeyword,caseLabelColon

" Blocks of code. rlCodeCurly is recursive.
syntax region rlCodeCurly matchgroup=NONE start="{" end="}" keepend contained contains=TOP
syntax region rlCodeSemi matchgroup=Type start="\<alphtype\>" start="\<getkey\>" start="\<access\>" start="\<variable\>" matchgroup=NONE end=";" contained contains=@inlineItems

syntax region rlWrite matchgroup=Type start="\<write\>" matchgroup=NONE end="[;)]" contained contains=rlWriteKeywords,rlWriteOptions

syntax keyword rlWriteKeywords init data exec exports start error first_final contained
syntax keyword rlWriteOptions noerror nofinal noprefix noend nocs contained

"
" Sync at the start of machine specs.
"
" Match The ragel delimiters only if there quotes no ahead on the same line.
" On the open marker, use & to consume the leader.
syntax sync match ragelSyncPat grouphere NONE "^[^\'\"%]*%%{&^[^\'\"%]*"
syntax sync match ragelSyncPat grouphere NONE "^[^\'\"%]*%%[^{]&^[^\'\"%]*"
syntax sync match ragelSyncPat grouphere NONE "^[^\'\"]*}%%"

"
" Specifying Groups
"
hi link rlComment Comment
hi link rlNumber Number
hi link rlLiteral String
hi link rlAugmentOps Keyword
hi link rlExprKeywords Keyword
hi link rlWriteKeywords Keyword
hi link rlWriteOptions Keyword
hi link rlKeywords Type
hi link fsmType Type
hi link fsmKeyword Keyword
hi link anyLabel Label
hi link caseLabelKeyword Keyword
hi link beginRL Type
 
let b:current_syntax = "ragel"

endif
