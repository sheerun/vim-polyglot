" Heuristically set buffer options
"
" Modified version of vim-sleuth:
"   - softtab and tabstop reduced from 8 to 2
"   - number of considered lines reduced from 1024 to 64
"   - maximum 6 other files are checked instead of 20
"   - check maximum of files 2 per directory level instead of 8
"   - maximum of 3 directory levels are checked
"   - globs are concatenated for performance

if exists("g:loaded_sleuth") || v:version < 700 || &cp
  finish
endif
let g:loaded_sleuth = 1

function! s:guess(lines) abort
  let options = {}
  let heuristics = {'spaces': 0, 'hard': 0, 'soft': 0}
  let ccomment = 0
  let podcomment = 0
  let triplequote = 0
  let backtick = 0
  let xmlcomment = 0
  let softtab = repeat(' ', 2)

  for line in a:lines
    if !len(line) || line =~# '^\s*$'
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

    if line =~# '^\t'
      let heuristics.hard += 1
    elseif line =~# '^' . softtab
      let heuristics.soft += 1
    endif
    if line =~# '^  '
      let heuristics.spaces += 1
    endif
    let indent = len(matchstr(substitute(line, '\t', softtab, 'g'), '^ *'))
    if indent > 1 && (indent < 4 || indent % 2 == 0) &&
          \ get(options, 'shiftwidth', 99) > indent
      let options.shiftwidth = indent
    endif
  endfor

  if heuristics.hard && !heuristics.spaces
    return {'expandtab': 0, 'shiftwidth': &tabstop}
  elseif heuristics.soft != heuristics.hard
    let options.expandtab = heuristics.soft > heuristics.hard
    if heuristics.hard
      let options.tabstop = 2
    endif
  endif

  return options
endfunction

function! s:apply_if_ready(options) abort
  if !has_key(a:options, 'expandtab') || !has_key(a:options, 'shiftwidth')
    return 0
  else
    for [option, value] in items(a:options)
      call setbufvar('', '&'.option, value)
    endfor
    return 1
  endif
endfunction

function! s:detect() abort
  if &buftype ==# 'help'
    return
  endif

  let options = s:guess(getline(1, 64))
  if s:apply_if_ready(options)
    return
  endif
  let c = 6
  let pattern = c > 0 ? sleuth#GlobForFiletype(&filetype) : ''
  let dir = expand('%:p:h')
  let level = 3
  while isdirectory(dir) && dir !=# fnamemodify(dir, ':h') && c > 0 && level > 0
    let level -= 1
    for neighbor in glob(dir.'/'.pattern,0,1)[0:1]
      if neighbor !=# expand('%:p') && filereadable(neighbor)
        call extend(options, s:guess(readfile(neighbor, '', 32)), 'keep')
        let c -= 1
      endif
      if s:apply_if_ready(options)
        let b:sleuth_culprit = neighbor
        return
      endif
      if c <= 0
        break
      endif
    endfor
    if c <= 0
      break
    endif
    let dir = fnamemodify(dir, ':h')
  endwhile
  if has_key(options, 'shiftwidth')
    return s:apply_if_ready(extend({'expandtab': 1}, options))
  endif
endfunction

setglobal smarttab

if !exists('g:did_indent_on')
  filetype indent on
endif

augroup polyglot
  autocmd!
  autocmd FileType * call s:detect()
augroup END
