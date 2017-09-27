if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'plantuml') == -1
  
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetPlantUMLIndent()
setlocal indentkeys=o,O,<CR>,<:>,!^F,0end,0else,}

" only define the indent code once
if exists('*GetPlantUMLIndent')
  finish
endif

let s:incIndent =
      \ '^\s*\%(loop\|alt\|opt\|group\|critical\|else\|legend\|box\|if\|while\)\>\|' .
      \ '^\s*ref\>[^:]*$\|' .
      \ '^\s*[hr]\?note\>\%(\%("[^"]*" \<as\>\)\@![^:]\)*$\|' .
      \ '^\s*title\s*$\|' .
      \ '^\s*skinparam\>.*{\s*$\|' .
      \ '^\s*\%(state\|class\|partition\|rectangle\|enum\|interface\|namespace\|object\)\>.*{'

let s:decIndent = '^\s*\%(end\|else\|}\)'

function! GetPlantUMLIndent(...) abort
  "for current line, use arg if given or v:lnum otherwise
  let clnum = a:0 ? a:1 : v:lnum

  if !s:insidePlantUMLTags(clnum)
    return indent(clnum)
  endif

  let pnum = prevnonblank(clnum-1)
  let pindent = indent(pnum)
  let pline = getline(pnum)
  let cline = getline(clnum)

  if cline =~ s:decIndent
    if pline =~ s:incIndent
      return pindent
    else
      return pindent - shiftwidth()
    endif

  elseif pline =~ s:incIndent
    return pindent + shiftwidth()
  endif

  return pindent

endfunction

function! s:insidePlantUMLTags(lnum) abort
  call cursor(a:lnum, 1)
  return search('@startuml', 'Wbn') && search('@enduml', 'Wn')
endfunction

endif
