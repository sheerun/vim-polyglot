if polyglot#init#is_disabled(expand('<sfile>:p'), 'ansible', 'syntax/ansible.vim')
  finish
endif

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
  execute 'syn keyword ansible_extra_special_keywords
              \ become become_exe become_flags become_method become_user become_pass prompt_l10n
              \ debugger always_run check_mode diff no_log args tags force_handlers
              \ vars vars_files vars_prompt delegate_facts delegate_to
              \ any_errors_fatal ignore_errors ignore_unreachable max_fail_percentage
              \ connection hosts port remote_user module_defaults
              \ environment fact_path gather_facts gather_subset gather_timeout
              \ async poll throttle timeout order run_once serial strategy
              \ containedin='.s:yamlKey.' contained'
  if exists("g:ansible_extra_keywords_highlight_group")
    execute 'highlight link ansible_extra_special_keywords '.g:ansible_extra_keywords_highlight_group
  else
    highlight link ansible_extra_special_keywords Structure
  endif
endif

execute 'syn keyword ansible_normal_keywords
            \ include include_role include_tasks include_vars import_role import_playbook import_tasks
            \ when changed_when failed_when block rescue always notify listen register
            \ action local_action post_tasks pre_tasks tasks handlers roles collections
            \ containedin='.s:yamlKey.' contained'
if exists("g:ansible_normal_keywords_highlight")
  execute 'highlight link ansible_normal_keywords '.g:ansible_normal_keywords_highlight
else
  highlight default link ansible_normal_keywords Statement
endif

execute 'syn keyword ansible_loop_keywords
            \ loop loop_control until retries delay
            \ containedin='.s:yamlKey.' contained'
execute 'syn match ansible_loop_keywords "\vwith_.+" containedin='.s:yamlKey.' contained'
if exists("g:ansible_loop_keywords_highlight")
  execute 'highlight link ansible_loop_keywords '.g:ansible_loop_keywords_highlight
" backward compatibility: ansible_with_keywords_highlight replaced by ansible_loop_keywords_highlight
elseif exists("g:ansible_with_keywords_highlight")
  execute 'highlight link ansible_loop_keywords '.g:ansible_with_keywords_highlight
else
  highlight default link ansible_loop_keywords Statement
endif

let b:current_syntax = "ansible"
