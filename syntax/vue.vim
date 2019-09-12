if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1

" Vim syntax file
" Language: Vue.js
" Maintainer: Eduardo San Martin Morote

if exists("b:current_syntax")
  finish
endif

" Convert deprecated variable to new one
if exists('g:vue_disable_pre_processors') && g:vue_disable_pre_processors
  let g:vue_pre_processors = []
endif

runtime! syntax/html.vim
syntax clear htmlTagName
syntax match htmlTagName contained "\<[a-zA-Z0-9:-]*\>"
unlet! b:current_syntax

""
" Get the pattern for a HTML {name} attribute with {value}.
function! s:attr(name, value)
  return a:name . '=\("\|''\)[^\1]*' . a:value . '[^\1]*\1'
endfunction

function! s:should_register(language, start_pattern)
  " Check whether a syntax file for {language} exists
  if empty(globpath(&runtimepath, 'syntax/' . a:language . '.vim'))
    return 0
  endif

  if exists('g:vue_pre_processors')
    if type(g:vue_pre_processors) == v:t_list
      return index(g:vue_pre_processors, s:language.name) != -1
    elseif g:vue_pre_processors is# 'detect_on_enter'
      return search(a:start_pattern, 'n') != 0
    endif
  endif

  return 1
endfunction

let s:languages = [
      \ {'name': 'less',       'tag': 'style'},
      \ {'name': 'pug',        'tag': 'template', 'attr_pattern': s:attr('lang', '\%(pug\|jade\)')},
      \ {'name': 'slm',        'tag': 'template'},
      \ {'name': 'handlebars', 'tag': 'template'},
      \ {'name': 'haml',       'tag': 'template'},
      \ {'name': 'typescript', 'tag': 'script', 'attr_pattern': '\%(lang=\("\|''\)[^\1]*\(ts\|typescript\)[^\1]*\1\|ts\)'},
      \ {'name': 'coffee',     'tag': 'script'},
      \ {'name': 'stylus',     'tag': 'style'},
      \ {'name': 'sass',       'tag': 'style'},
      \ {'name': 'scss',       'tag': 'style'},
      \ ]

for s:language in s:languages
  let s:attr_pattern = has_key(s:language, 'attr_pattern') ? s:language.attr_pattern : s:attr('lang', s:language.name)
  let s:start_pattern = '<' . s:language.tag . '\>\_[^>]*' . s:attr_pattern . '\_[^>]*>'

  if s:should_register(s:language.name, s:start_pattern)
    execute 'syntax include @' . s:language.name . ' syntax/' . s:language.name . '.vim'
    unlet! b:current_syntax
    execute 'syntax region vue_' . s:language.name
          \ 'keepend'
          \ 'start=/' . s:start_pattern . '/'
          \ 'end="</' . s:language.tag . '>"me=s-1'
          \ 'contains=@' . s:language.name . ',vueSurroundingTag'
          \ 'fold'
  endif
endfor

syn region  vueSurroundingTag   contained start=+<\(script\|style\|template\)+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent
syn keyword htmlSpecialTagName  contained template
syn keyword htmlArg             contained scoped ts
syn match   htmlArg "[@v:][-:.0-9_a-z]*\>" contained

syntax sync fromstart

let b:current_syntax = "vue"

endif
