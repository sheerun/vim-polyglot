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

  let s:syntaxes = s:search_syntaxes('pug', 'slm', 'coffee', 'stylus', 'sass', 'scss', 'less', 'typescript')
endif


syntax include @HTML syntax/html.vim
unlet! b:current_syntax
syntax region html keepend start=/^<template\_[^>]*>/ end=/^<\/template>/ contains=@HTML fold

if s:syntaxes.pug
  syntax include @PUG syntax/pug.vim
  unlet! b:current_syntax
  syntax region pug keepend start=/<template lang=\("\|'\)[^\1]*pug[^\1]*\1>/ end="</template>" contains=@PUG fold
  syntax region pug keepend start=/<template lang=\("\|'\)[^\1]*jade[^\1]*\1>/ end="</template>" contains=@PUG fold
endif

if s:syntaxes.slm
  syntax include @SLM syntax/slm.vim
  unlet! b:current_syntax
  syntax region slm keepend start=/<template lang=\("\|'\)[^\1]*slm[^\1]*\1>/ end="</template>" contains=@SLM fold
endif

syntax include @JS syntax/javascript.vim
unlet! b:current_syntax
syntax region javascript keepend matchgroup=Delimiter start=/<script\( lang="babel"\)\?\( type="text\/babel"\)\?>/ end="</script>" contains=@JS fold

if s:syntaxes.typescript
  syntax include @TS syntax/typescript.vim
  unlet! b:current_syntax
  syntax region typescript keepend matchgroup=Delimiter start=/<script \_[^>]*\(lang=\("\|'\)[^\2]*\(ts\|typescript\)[^\2]*\2\|ts\)\_[^>]*>/ end="</script>" contains=@TS fold
endif

if s:syntaxes.coffee
  syntax include @COFFEE syntax/coffee.vim
  unlet! b:current_syntax
  " Matchgroup seems to be necessary for coffee
  syntax region coffee keepend matchgroup=Delimiter start="<script lang=\"coffee\">" end="</script>" contains=@COFFEE fold
endif

syntax include @CSS syntax/css.vim
unlet! b:current_syntax
syntax region css keepend start=/<style\_[^>]*>/ end="</style>" contains=@CSS fold

if s:syntaxes.stylus
  syntax include @stylus syntax/stylus.vim
  unlet! b:current_syntax
  syntax region stylus keepend start=/<style \_[^>]*lang=\("\|'\)[^\1]*stylus[^\1]*\1\_[^>]*>/ end="</style>" contains=@stylus fold
endif

if s:syntaxes.sass
  syntax include @sass syntax/sass.vim
  unlet! b:current_syntax
  syntax region sass keepend start=/<style \_[^>]*lang=\("\|'\)[^\1]*sass[^\1]*\1\_[^>]*>/ end="</style>" contains=@sass fold
endif

if s:syntaxes.scss
  syntax include @scss syntax/scss.vim
  unlet! b:current_syntax
  syntax region scss keepend start=/<style \_[^>]*lang=\("\|'\)[^\1]*scss[^\1]*\1\_[^>]*>/ end="</style>" contains=@scss fold
endif

if s:syntaxes.less
  syntax include @less syntax/less.vim
  unlet! b:current_syntax
  syntax region less keepend matchgroup=PreProc start=/<style \_[^>]*lang=\("\|'\)[^\1]*less[^\1]*\1\_[^>]*>/ end="</style>" contains=@less fold
endif

let b:current_syntax = "vue"

endif
