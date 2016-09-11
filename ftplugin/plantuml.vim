if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'plantuml') == -1
  
" Vim plugin file
" Language:     PlantUML
" Maintainer:   Aaron C. Meadows < language name at shadowguarddev dot com>
" Last Change:  19-Jun-2012
" Version:      0.1

if exists("b:loaded_plantuml_plugin")
  finish
endif
let b:loaded_plantuml_plugin = 1

if !exists("g:plantuml_executable_script")
  let g:plantuml_executable_script="plantuml"
endif

if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_words =
        \ '\(\<ref\>\|\<box\>\|\<opt\>\|\<alt\>\|\<group\>\|\<loop\>\|\<note\>\|\<legend\>\):\<else\>:\<end\>' .
        \ ',\<if\>:\<elseif\>:\<else\>:\<endif\>' .
        \ ',\<rnote\>:\<endrnote\>' .
        \ ',\<hnote\>:\<endhnote\>' .
        \ ',\<title\>:\<endtitle\>' .
        \ ',\<\while\>:\<endwhile\>'
endif

let &l:makeprg=g:plantuml_executable_script . " " .  fnameescape(expand("%"))

setlocal comments=s1:/',mb:',ex:'/,:' commentstring=/'%s'/ formatoptions-=t formatoptions+=croql

let b:endwise_addition = '\=index(["note","legend"], submatch(0))!=-1 ? "end " . submatch(0) : "end"'
let b:endwise_words = 'loop,group,alt,note,legend'
let b:endwise_pattern = '^\s*\zs\<\(loop\|group\|alt\|note\ze[^:]*$\|legend\)\>.*$'
let b:endwise_syngroups = 'plantumlKeyword'

endif
