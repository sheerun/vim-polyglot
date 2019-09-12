if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1

let s:save_cpo = &cpo
set cpo&vim

setlocal indentexpr=GetAnsibleIndent(v:lnum)
setlocal indentkeys=!^F,o,O,0#,0},0],<:>,-,*<Return>
setlocal nosmartindent
setlocal expandtab
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal commentstring=#%s
setlocal formatoptions+=cl
" c -> wrap long comments, including #
" l -> do not wrap long lines

let s:comment = '\v^\s*#' " # comment
let s:array_entry = '\v^\s*-\s' " - foo
let s:named_module_entry = '\v^\s*-\s*(name|hosts|role):\s*\S' " - name: 'do stuff'
let s:dictionary_entry = '\v^\s*[^:-]+:\s*$' " with_items:
let s:key_value = '\v^\s*[^:-]+:\s*\S' " apt: name=package
let s:scalar_value = '\v:\s*[>|\|]\s*$' " shell: >

if exists('*GetAnsibleIndent')
  finish
endif

function GetAnsibleIndent(lnum)
  if a:lnum == 1 || !prevnonblank(a:lnum-1)
    return 0
  endif
  if exists("g:ansible_unindent_after_newline")
    if (a:lnum -1) != prevnonblank(a:lnum - 1)
      return 0
    endif
  endif
  let prevlnum = prevnonblank(a:lnum - 1)
  let maintain = indent(prevlnum)
  let increase = maintain + &sw

  let line = getline(prevlnum)
  if line =~ s:array_entry
    if line =~ s:named_module_entry
      return increase
    else
      return maintain
    endif
  elseif line =~ s:dictionary_entry
    return increase
  elseif line =~ s:key_value
    if line =~ s:scalar_value
      return increase
    else
      return maintain
    endif
  else
    return maintain
  endif
endfunction

let &cpo = s:save_cpo

endif
