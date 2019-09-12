if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pony') == -1

" Vim indent file
" Language:     Pony
" Maintainer:   Jak Wings

if exists('b:did_indent')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


setlocal nolisp
setlocal nocindent
setlocal nosmartindent
setlocal autoindent
setlocal indentexpr=pony#Indent()
setlocal indentkeys=!^F,o,O,0\|,0(,0),0[,0],0{,0},0==>,0=\"\"\",0=end,0=then,0=else,0=in,0=do,0=until,0=actor,0=class,0=struct,0=primitive,0=trait,0=interface,0=new,0=be,0=fun,0=type,0=use
setlocal cinkeys=!^F,o,O,0\|,0(,0),0[,0],0{,0},0==>,0=\"\"\",0=end,0=then,0=else,0=in,0=do,0=until,0=actor,0=class,0=struct,0=primitive,0=trait,0=interface,0=new,0=be,0=fun,0=type,0=use
setlocal cinwords=ifdef,if,match,while,for,repeat,try,with,recover,object,lambda,then,elseif,else,until,do,actor,class,struct,primitive,trait,interface,new,be,fun,iftype,elseiftype

augroup pony
  autocmd! * <buffer>
  autocmd CursorHold <buffer> call pony#ClearTrailingSpace(1, 1)
  "autocmd InsertEnter <buffer> call pony#ClearTrailingSpace(0, 0)
  autocmd InsertLeave <buffer> call pony#ClearTrailingSpace(0, 1)
  autocmd BufWritePre <buffer> call pony#ClearTrailingSpace(1, 0, 1)
augroup END

let b:undo_indent = 'set lisp< cindent< autoindent< smartindent< indentexpr< indentkeys< cinkeys< cinwords<'
      \ . ' | execute("autocmd! pony * <buffer>")'


let &cpo = s:cpo_save
unlet s:cpo_save

let b:did_indent = 1

endif
