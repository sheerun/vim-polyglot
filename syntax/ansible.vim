if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1
  
" Vim syntax file
" Language: Ansible YAML/Jinja templates
" Maintainer: Dave Honneffer <pearofducks@gmail.com>
" Last Change: 2015.09.06

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'yaml'
endif

let b:current_syntax = ''
unlet b:current_syntax
runtime! syntax/yaml.vim

let b:current_syntax = ''
unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim

let b:current_syntax = ''
unlet b:current_syntax
syntax include @Jinja syntax/jinja2.vim

" Jinja
" ================================

syn cluster jinjaSLSBlocks add=jinjaTagBlock,jinjaVarBlock,jinjaComment
" https://github.com/mitsuhiko/jinja2/blob/6b7c0c23/ext/Vim/jinja.vim
syn region jinjaTagBlock matchgroup=jinjaTagDelim start=/{%-\?/ end=/-\?%}/ containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment,@jinjaSLSBlocks
syn region jinjaVarBlock matchgroup=jinjaVarDelim start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment,@jinjaSLSBlocks
syn region jinjaComment matchgroup=jinjaCommentDelim start="{#" end="#}" containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaString,@jinjaSLSBlocks
highlight link jinjaVariable Constant
highlight link jinjaVarDelim Delimiter

" YAML
" ================================

" Reset some YAML to plain styling
" the number 80 in Ansible isn't any more important than the word root
highlight link yamlInteger NONE
highlight link yamlBool NONE
highlight link yamlFlowString NONE
" but it does make sense we visualize quotes easily
highlight link yamlFlowStringDelimiter Delimiter

fun! s:attribute_highlight(attributes)
  if a:attributes =~ 'a'
    syn match ansible_attributes "\v\w+\=" containedin=yamlPlainScalar
  else
    syn match ansible_attributes "\v^\s*\w+\=" containedin=yamlPlainScalar
  endif
  if a:attributes =~ 'n'
    highlight link ansible_attributes NONE
  elseif a:attributes =~ 'd'
    highlight link ansible_attributes Comment
  else
    highlight link ansible_attributes Structure
  endif
endfun

if exists("g:ansible_attribute_highlight")
  call s:attribute_highlight(g:ansible_attribute_highlight)
else
  call s:attribute_highlight('ad')
endif

if exists("g:ansible_name_highlight")
  syn keyword ansible_name name containedin=yamlBlockMappingKey contained
  if g:ansible_name_highlight =~ 'd'
    highlight link ansible_name Comment
  else
    highlight link ansible_name Underlined
  endif
endif

syn keyword ansible_debug_keywords debug containedin=yamlBlockMappingKey contained
highlight link ansible_debug_keywords Debug

syn match ansible_with_keywords "\vwith_.+" containedin=yamlBlockMappingKey contained
syn keyword ansible_special_keywords include until retries delay when only_if become become_user block rescue always notify containedin=yamlBlockMappingKey contained
highlight link ansible_with_keywords Statement
highlight link ansible_special_keywords Statement

let b:current_syntax = "ansible"

endif
