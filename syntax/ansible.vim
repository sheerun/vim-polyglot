if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1

" Vim syntax file
" Language: Ansible YAML/Jinja templates
" Maintainer: Dave Honneffer <pearofducks@gmail.com>
" Last Change: 2018.02.08

if !exists("main_syntax")
  let main_syntax = 'yaml'
endif

if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif

syntax include @Jinja syntax/jinja2.vim

if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

" Jinja
" ================================

syn cluster jinjaSLSBlocks add=jinjaTagBlock,jinjaVarBlock,jinjaComment
" https://github.com/mitsuhiko/jinja2/blob/6b7c0c23/ext/Vim/jinja.vim
syn region jinjaTagBlock matchgroup=jinjaTagDelim start=/{%-\?/ end=/-\?%}/ containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment,@jinjaSLSBlocks
syn region jinjaVarBlock matchgroup=jinjaVarDelim start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,yamlComment,jinjaTagBlock,jinjaVarBlock,jinjaRaw,jinjaString,jinjaNested,jinjaComment,@jinjaSLSBlocks
syn region jinjaComment matchgroup=jinjaCommentDelim start="{#" end="#}" containedin=ALLBUT,jinjaTagBlock,jinjaVarBlock,jinjaString,@jinjaSLSBlocks
highlight link jinjaVariable Constant
highlight link jinjaVarDelim Delimiter

" YAML
" ================================

if exists("g:ansible_yamlKeyName")
  let s:yamlKey = g:ansible_yamlKeyName
else
  let s:yamlKey = "yamlBlockMappingKey"
endif

" Reset some YAML to plain styling
" the number 80 in Ansible isn't any more important than the word root
highlight link yamlInteger NONE
highlight link yamlBool NONE
highlight link yamlFlowString NONE
" but it does make sense we visualize quotes easily
highlight link yamlFlowStringDelimiter Delimiter
" This is only found in stephypy/vim-yaml, since it's one line it isn't worth
" making conditional
highlight link yamlConstant NONE

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
    highlight default link ansible_attributes Structure
  endif
endfun

if exists("g:ansible_attribute_highlight")
  call s:attribute_highlight(g:ansible_attribute_highlight)
else
  call s:attribute_highlight('ad')
endif

if exists("g:ansible_name_highlight")
  execute 'syn keyword ansible_name name containedin='.s:yamlKey.' contained'
  if g:ansible_name_highlight =~ 'd'
    highlight link ansible_name Comment
  else
    highlight default link ansible_name Underlined
  endif
endif

execute 'syn keyword ansible_debug_keywords debug containedin='.s:yamlKey.' contained'
highlight default link ansible_debug_keywords Debug

if exists("g:ansible_extra_keywords_highlight")
  execute 'syn keyword ansible_extra_special_keywords register always_run changed_when failed_when no_log args vars delegate_to ignore_errors containedin='.s:yamlKey.' contained'
  highlight link ansible_extra_special_keywords Statement
endif

execute 'syn keyword ansible_normal_keywords include include_tasks import_tasks until retries delay when only_if become become_user block rescue always notify containedin='.s:yamlKey.' contained'
if exists("g:ansible_normal_keywords_highlight")
  execute 'highlight link ansible_normal_keywords '.g:ansible_normal_keywords_highlight
else
  highlight default link ansible_normal_keywords Statement
endif

execute 'syn match ansible_with_keywords "\vwith_.+" containedin='.s:yamlKey.' contained'
if exists("g:ansible_with_keywords_highlight")
  execute 'highlight link ansible_with_keywords '.g:ansible_with_keywords_highlight
else
  highlight default link ansible_with_keywords Statement
endif

let b:current_syntax = "ansible"

endif
