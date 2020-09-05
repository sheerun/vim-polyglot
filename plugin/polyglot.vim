" Heuristically set expandtab and shiftwidth options
"
" Modified version of vim-sleuth:
"   - tabstop is not set, it's up to user to set it
"   - check maximum of 32 lines, instead of 1024
"   - check maximum 6 files, instead of 20
"   - check maximum of 2 filer per directory level, instead of 8
"   - check maximum of 3 directory levels
"   - check only to the nearest .git, .hg, or .svn directory
"   - globs are concatenated for performance
if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'autoindent') != -1
  finish
endif

if exists("g:loaded_polyglot") || v:version < 700 || &cp
  finish
endif

let g:loaded_sleuth = 1
let g:loaded_polyglot = 1

" Makes shiftwidth to be synchronized with tabstop by default
if &shiftwidth == &tabstop
  let &shiftwidth = 0
endif

function! s:guess(lines) abort
  let options = {}
  let ccomment = 0
  let podcomment = 0
  let triplequote = 0
  let backtick = 0
  let xmlcomment = 0
  let heredoc = ''
  let minindent = 10
  let spaces_minus_tabs = 0

  for line in a:lines
    if !len(line) || line =~# '^\W*$'
      continue
    endif

    if line =~# '^\s*/\*'
      let ccomment = 1
    endif
    if ccomment
      if line =~# '\*/'
        let ccomment = 0
      endif
      continue
    endif

    if line =~# '^=\w'
      let podcomment = 1
    endif
    if podcomment
      if line =~# '^=\%(end\|cut\)\>'
        let podcomment = 0
      endif
      continue
    endif

    if triplequote
      if line =~# '^[^"]*"""[^"]*$'
        let triplequote = 0
      endif
      continue
    elseif line =~# '^[^"]*"""[^"]*$'
      let triplequote = 1
    endif

    if backtick
      if line =~# '^[^`]*`[^`]*$'
        let backtick = 0
      endif
      continue
    elseif &filetype ==# 'go' && line =~# '^[^`]*`[^`]*$'
      let backtick = 1
    endif

    if line =~# '^\s*<\!--'
      let xmlcomment = 1
    endif
    if xmlcomment
      if line =~# '-->'
        let xmlcomment = 0
      endif
      continue
    endif

    " This is correct order because both "<<EOF" and "EOF" matches end
    if heredoc != ''
      if line =~# heredoc
        let heredoc = ''
      endif
      continue
    endif
    let herematch = matchlist(line, '\C<<\W*\([A-Z]\+\)\s*$')
    if len(herematch) > 0
      let heredoc = herematch[1] . '$'
    endif

    let spaces_minus_tabs += line[0] == "\t" ? 1 : -1

    if line[0] == "\t"
      setlocal noexpandtab
      return 1
    elseif line[0] == " "
      let indent = len(matchstr(line, '^ *'))
      if indent % 2 == 0 && indent < minindent
        let minindent = indent
      endif
    endif
  endfor

  if minindent < 10
    setlocal expandtab
    let &shiftwidth=minindent
    return 1
  endif

  return 0
endfunction

function! s:detect_indent() abort
  if &buftype ==# 'help'
    return
  endif

  if s:guess(getline(1, 32))
    return
  endif
  let pattern = sleuth#GlobForFiletype(&filetype)
  if len(pattern) == 0
    return
  endif
  let pattern = '{' . pattern . ',.git,.svn,.hg}'
  let dir = expand('%:p:h')
  let level = 3
  while isdirectory(dir) && dir !=# fnamemodify(dir, ':h') && level > 0
    " Ignore files from homedir and root 
    if dir == expand('~') || dir == '/'
      return
    endif
    for neighbor in glob(dir . '/' . pattern, 0, 1)[0:level]
      " Do not consider directories above .git, .svn or .hg
      if fnamemodify(neighbor, ":h:t")[0] == "."
        return
      endif
      if neighbor !=# expand('%:p') && filereadable(neighbor)
        if s:guess(readfile(neighbor, '', 32))
          return
        endif
      endif
    endfor

    let dir = fnamemodify(dir, ':h')
    let level -= 1
  endwhile
endfunction

setglobal smarttab

augroup polyglot
  autocmd!
  autocmd FileType * call s:detect_indent()
augroup END
