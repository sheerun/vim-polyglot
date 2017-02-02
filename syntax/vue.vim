if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1
  
" Vim syntax file
" Language: Vue.js
" Maintainer: Eduardo San Martin Morote

if exists("b:current_syntax")
  finish
endif

if !exists("s:syntaxes")
  " Search available syntax files.
  function s:search_syntaxes(...)
    let syntaxes = {}
    let names = a:000
    for name in names
      let syntaxes[name] = 0
    endfor

    for path in split(&runtimepath, ',')
      if isdirectory(path . '/syntax')
        for name in names
          let syntaxes[name] = syntaxes[name] || filereadable(path . '/syntax/' . name . '.vim')
        endfor
      endif
    endfor
    return syntaxes
  endfunction

  let s:syntaxes = s:search_syntaxes('pug', 'slm', 'coffee', 'stylus', 'sass', 'scss', 'less')
endif


syntax include @HTML syntax/html.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region html keepend start=/^<template>/ end=/^<\/template>/ contains=@HTML fold

if s:syntaxes.pug
  syntax include @PUG syntax/pug.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region pug keepend start=/<template lang=\("\|'\)[^\1]*pug[^\1]*\1>/ end="</template>" contains=@PUG fold
  syntax region pug keepend start=/<template lang=\("\|'\)[^\1]*jade[^\1]*\1>/ end="</template>" contains=@PUG fold
endif

if s:syntaxes.slm
  syntax include @SLM syntax/slm.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region slm keepend start=/<template lang=\("\|'\)[^\1]*slm[^\1]*\1>/ end="</template>" contains=@SLM fold
endif

syntax include @JS syntax/javascript.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region javascript keepend matchgroup=Delimiter start=/<script\( lang="babel"\)\?\( type="text\/babel"\)\?>/ end="</script>" contains=@JS fold

if s:syntaxes.coffee
  syntax include @COFFEE syntax/coffee.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  " Matchgroup seems to be necessary for coffee
  syntax region coffee keepend matchgroup=Delimiter start="<script lang=\"coffee\">" end="</script>" contains=@COFFEE fold
endif

syntax include @CSS syntax/css.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syntax region css keepend start=/<style\( \+scoped\)\?>/ end="</style>" contains=@CSS fold

if s:syntaxes.stylus
  syntax include @stylus syntax/stylus.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region stylus keepend start=/<style lang=\("\|'\)[^\1]*stylus[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@stylus fold
endif

if s:syntaxes.sass
  syntax include @sass syntax/sass.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region sass keepend start=/<style\( \+scoped\)\? lang=\("\|'\)[^\1]*sass[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@sass fold
endif

if s:syntaxes.scss
  syntax include @scss syntax/scss.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region scss keepend start=/<style\( \+scoped\)\? lang=\("\|'\)[^\1]*scss[^\1]*\1\( \+scoped\)\?>/ end="</style>" contains=@scss fold
endif

if s:syntaxes.less
  syntax include @less syntax/less.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  syntax region less keepend matchgroup=PreProc start=/<style\%( \+scoped\)\? lang=\("\|'\)[^\1]*less[^\1]*\1\%( \+scoped\)\?>/ end="</style>" contains=@less fold
endif

let b:current_syntax = "vue"

endif
