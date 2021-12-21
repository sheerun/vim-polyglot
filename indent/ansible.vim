if polyglot#init#is_disabled(expand('<sfile>:p'), 'ansible', 'indent/ansible.vim')
  finish
endif

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
let s:blank = '\v^\s*$' " line with only spaces

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
  let default = GetYAMLIndent(a:lnum)
  let increase = indent(prevlnum) + &sw

  let prevline = getline(prevlnum)
  let line = getline(a:lnum)
  if line !~ s:blank
    return default  " we only special case blank lines
  elseif prevline =~ s:array_entry
    if prevline =~ s:named_module_entry
      return increase
    else
      return default
    endif
  elseif prevline =~ s:dictionary_entry
    return increase
  elseif prevline =~ s:key_value
    if prevline =~ s:scalar_value
      return increase
    else
      return default
    endif
  else
    return default
  endif
endfunction

let &cpo = s:save_cpo
