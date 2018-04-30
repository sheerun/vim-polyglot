if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1
  
" Vim syntax file
" Language: Ansible YAML/Jinja templates
" Maintainer: Dave Honneffer <pearofducks@gmail.com>
" Last Change: 2015.09.06

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'jinja2'
endif

let b:current_syntax = ''
unlet b:current_syntax
runtime! syntax/jinja2.vim

if exists("g:ansible_extra_syntaxes")
  let s:extra_syntax = split(g:ansible_extra_syntaxes)
  for syntax_name in s:extra_syntax
    let b:current_syntax = ''
    unlet b:current_syntax
    execute 'runtime!' "syntax/" . syntax_name
  endfor
endif

let b:current_syntax = "ansible_template"

endif
