" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

" DO NOT EDIT CODE BELOW, IT IS GENERATED WITH MAKEFILE

func! polyglot#detect#Inp(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  let line = getline(nextnonblank(1))
  if line =~# '^\*'
    set ft=abaqus | return
  endif
  for lnum in range(1, min([line("$"), 500]))
    let line = getline(lnum)
    if line =~? '^header surface data'
      set ft=trasys | return
    endif
  endfor
endfunc

func! polyglot#detect#Asa(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  if exists("g:filetype_asa")
    let &ft = g:filetype_asa | return
  endif
  set ft=aspvbs | return
endfunc

func! polyglot#detect#Asp(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  if exists("g:filetype_asp")
    let &ft = g:filetype_asp | return
  endif
  for lnum in range(1, min([line("$"), 3]))
    let line = getline(lnum)
    if line =~? 'perlscript'
      set ft=aspperl | return
    endif
  endfor
  set ft=aspvbs | return
endfunc

func! polyglot#detect#H(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 200]))
    let line = getline(lnum)
    if line =~# '^\s*\(@\(interface\|class\|protocol\|property\|end\|synchronised\|selector\|implementation\)\(\<\|\>\)\|#import\s\+.\+\.h[">]\)'
      if exists('g:c_syntax_for_h')
        set ft=objc | return
      endif
      set ft=objcpp | return
    endif
  endfor
  if exists('g:c_syntax_for_h')
    set ft=c | return
  endif
  if exists('g:ch_syntax_for_h')
    set ft=ch | return
  endif
  set ft=cpp | return
endfunc

func! polyglot#detect#M(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  let saw_comment = 0
  for lnum in range(1, min([line("$"), 100]))
    let line = getline(lnum)
    if line =~# '^\s*/\*'
      let saw_comment = 1
    endif
    if line =~# '^\s*\(@\(interface\|class\|protocol\|property\|end\|synchronised\|selector\|implementation\)\(\<\|\>\)\|#import\s\+.\+\.h[">]\)'
      set ft=objc | return
    endif
    if line =~# '^\s*%'
      if !has_key(g:polyglot_is_disabled, 'octave')
        set ft=octave | return
      endif
    endif
    if line =~# '^\s*%'
      if has_key(g:polyglot_is_disabled, 'octave')
        set ft=matlab | return
      endif
    endif
    if line =~# '^\s*(\*'
      set ft=mma | return
    endif
    if line =~? '^\s*\(\(type\|var\)\(\<\|\>\)\|--\)'
      set ft=murphi | return
    endif
  endfor
  if saw_comment
    set ft=objc | return
  endif
  if exists("g:filetype_m")
    let &ft = g:filetype_m | return
  endif
  if !has_key(g:polyglot_is_disabled, 'octave')
    set ft=octave | return
  endif
  if has_key(g:polyglot_is_disabled, 'octave')
    set ft=matlab | return
  endif
endfunc

func! polyglot#detect#Fs(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\(: \|new-device\)'
      set ft=forth | return
    endif
    if line =~# '^\s*\(#light\|import\|let\|module\|namespace\|open\|type\)'
      set ft=fsharp | return
    endif
    if line =~# '\s*\(#version\|precision\|uniform\|varying\|vec[234]\)'
      set ft=glsl | return
    endif
  endfor
  if exists("g:filetype_fs")
    let &ft = g:filetype_fs | return
  endif
  set ft=forth | return
endfunc

func! polyglot#detect#Re(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\s*#\%(\%(if\|ifdef\|define\|pragma\)\s\+\w\|\s*include\s\+[<"]\|template\s*<\)'
      set ft=cpp | return
    endif
    set ft=reason | return
  endfor
endfunc

func! polyglot#detect#Idr(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 5]))
    let line = getline(lnum)
    if line =~# '^\s*--.*[Ii]dris \=1'
      set ft=idris | return
    endif
    if line =~# '^\s*--.*[Ii]dris \=2'
      set ft=idris2 | return
    endif
  endfor
  for lnum in range(1, min([line("$"), 30]))
    let line = getline(lnum)
    if line =~# '^pkgs =.*'
      set ft=idris | return
    endif
    if line =~# '^depends =.*'
      set ft=idris2 | return
    endif
    if line =~# '^%language \(TypeProviders\|ElabReflection\)'
      set ft=idris | return
    endif
    if line =~# '^%language PostfixProjections'
      set ft=idris2 | return
    endif
    if line =~# '^%access .*'
      set ft=idris | return
    endif
  endfor
  if exists("g:filetype_idr")
    let &ft = g:filetype_idr | return
  endif
  set ft=idris2 | return
endfunc

func! polyglot#detect#Lidr(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 200]))
    let line = getline(lnum)
    if line =~# '^>\s*--.*[Ii]dris \=1'
      set ft=lidris | return
    endif
  endfor
  set ft=lidris2 | return
endfunc

func! polyglot#detect#Bas(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 5]))
    let line = getline(lnum)
    if line =~? 'VB_Name\|Begin VB\.\(Form\|MDIForm\|UserControl\)'
      set ft=vb | return
    endif
  endfor
  set ft=basic | return
endfunc

func! polyglot#detect#Pm(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  let line = getline(nextnonblank(1))
  if line =~# 'XPM2'
    set ft=xpm2 | return
  endif
  if line =~# 'XPM'
    set ft=xpm | return
  endif
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\s*\%(use\s\+v6\(\<\|\>\)\|\(\<\|\>\)module\(\<\|\>\)\|\(\<\|\>\)\%(my\s\+\)\=class\(\<\|\>\)\)'
      set ft=raku | return
    endif
    if line =~# '\(\<\|\>\)use\s\+\%(strict\(\<\|\>\)\|v\=5\.\)'
      set ft=perl | return
    endif
  endfor
  if exists("g:filetype_pm")
    let &ft = g:filetype_pm | return
  endif
  if polyglot#shebang#Detect() | return | endif
  set ft=perl | return
endfunc

func! polyglot#detect#Pl(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  let line = getline(nextnonblank(1))
  if line =~# '^[^#]*:-' || line =~# '^\s*\%(%\|/\*\)' || line =~# '\.\s*$'
    set ft=prolog | return
  endif
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\s*\%(use\s\+v6\(\<\|\>\)\|\(\<\|\>\)module\(\<\|\>\)\|\(\<\|\>\)\%(my\s\+\)\=class\(\<\|\>\)\)'
      set ft=raku | return
    endif
    if line =~# '\(\<\|\>\)use\s\+\%(strict\(\<\|\>\)\|v\=5\.\)'
      set ft=perl | return
    endif
  endfor
  if exists("g:filetype_pl")
    let &ft = g:filetype_pl | return
  endif
  if polyglot#shebang#Detect() | return | endif
  set ft=perl | return
endfunc

func! polyglot#detect#T(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 5]))
    let line = getline(lnum)
    if line =~# '^\.'
      set ft=nroff | return
    endif
  endfor
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\s*\%(use\s\+v6\(\<\|\>\)\|\(\<\|\>\)module\(\<\|\>\)\|\(\<\|\>\)\%(my\s\+\)\=class\(\<\|\>\)\)'
      set ft=raku | return
    endif
    if line =~# '\(\<\|\>\)use\s\+\%(strict\(\<\|\>\)\|v\=5\.\)'
      set ft=perl | return
    endif
  endfor
  if exists("g:filetype_t")
    let &ft = g:filetype_t | return
  endif
  if polyglot#shebang#Detect() | return | endif
  set ft=perl | return
endfunc

func! polyglot#detect#Tt2(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  for lnum in range(1, min([line("$"), 3]))
    let line = getline(lnum)
    if line =~? '<\%(!DOCTYPE HTML\|[%?]\|html\)'
      set ft=tt2html | return
    endif
  endfor
  set ft=tt2 | return
endfunc

func! polyglot#detect#Html(...)
  if a:0 != 1 && did_filetype()
    return
  endif
  let line = getline(nextnonblank(1))
  if line =~# '^\(%\|<[%&].*>\)'
    set ft=mason | return
  endif
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '{%-\=\s*\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\|load\)\(\<\|\>\)\|{#\s\+'
      set ft=htmldjango | return
    endif
    if line =~# '\(\<\|\>\)DTD\s\+XHTML\s'
      set ft=xhtml | return
    endif
  endfor
  set ft=html | return
endfunc

" DO NOT EDIT CODE ABOVE, IT IS GENERATED WITH MAKEFILE

let &cpo = s:cpo_save
unlet s:cpo_save
