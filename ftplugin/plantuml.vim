if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'plantuml') == -1
  
" Vim plugin file
" Language:     PlantUML
" Maintainer:   Aaron C. Meadows < language name at shadowguarddev dot com>
" Last Change:  19-Jun-2012
" Version:      0.1

if exists("g:loaded_plantuml_plugin")
    finish
endif
let g:loaded_plantuml_plugin = 1

if !exists("g:plantuml_executable_script")
	let g:plantuml_executable_script="plantuml"
endif

autocmd Filetype plantuml let &l:makeprg=g:plantuml_executable_script . " " .  fnameescape(expand("%"))

setlocal comments=s1:/',mb:',ex:'/,:' commentstring=/'%s'/ formatoptions-=t formatoptions+=croql

endif
