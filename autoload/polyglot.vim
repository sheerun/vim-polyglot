" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

func! polyglot#Shebang()
  " Try to detect filetype from shebang
  let ft = polyglot#ShebangFiletype()
  if ft != ""
    let &ft = ft
    return 1
  endif

  return 0
endfunc

let s:interpreters = {
  \ 'osascript': 'applescript',
  \ 'tcc': 'c',
  \ 'coffee': 'coffee',
  \ 'crystal': 'crystal',
  \ 'dart': 'dart',
  \ 'elixir': 'elixir',
  \ 'escript': 'erlang',
  \ 'fish': 'fish',
  \ 'gnuplot': 'gnuplot',
  \ 'groovy': 'groovy',
  \ 'runhaskell': 'haskell',
  \ 'chakra': 'javascript',
  \ 'd8': 'javascript',
  \ 'gjs': 'javascript',
  \ 'js': 'javascript',
  \ 'node': 'javascript',
  \ 'nodejs': 'javascript',
  \ 'qjs': 'javascript',
  \ 'rhino': 'javascript',
  \ 'v8': 'javascript',
  \ 'v8-shell': 'javascript',
  \ 'julia': 'julia',
  \ 'lua': 'lua',
  \ 'moon': 'moon',
  \ 'ocaml': 'ocaml',
  \ 'ocamlrun': 'ocaml',
  \ 'ocamlscript': 'ocaml',
  \ 'cperl': 'perl',
  \ 'perl': 'perl',
  \ 'php': 'php',
  \ 'swipl': 'prolog',
  \ 'yap': 'prolog',
  \ 'pwsh': 'ps1',
  \ 'python': 'python',
  \ 'python2': 'python',
  \ 'python3': 'python',
  \ 'qmake': 'qmake',
  \ 'Rscript': 'r',
  \ 'racket': 'racket',
  \ 'perl6': 'raku',
  \ 'raku': 'raku',
  \ 'rakudo': 'raku',
  \ 'ruby': 'ruby',
  \ 'macruby': 'ruby',
  \ 'rake': 'ruby',
  \ 'jruby': 'ruby',
  \ 'rbx': 'ruby',
  \ 'scala': 'scala',
  \ 'ash': 'sh',
  \ 'bash': 'sh',
  \ 'dash': 'sh',
  \ 'ksh': 'sh',
  \ 'mksh': 'sh',
  \ 'pdksh': 'sh',
  \ 'rc': 'sh',
  \ 'sh': 'sh',
  \ 'zsh': 'sh',
  \ 'boolector': 'smt2',
  \ 'cvc4': 'smt2',
  \ 'mathsat5': 'smt2',
  \ 'opensmt': 'smt2',
  \ 'smtinterpol': 'smt2',
  \ 'smt-rat': 'smt2',
  \ 'stp': 'smt2',
  \ 'verit': 'smt2',
  \ 'yices2': 'smt2',
  \ 'z3': 'smt2',
  \ 'deno': 'typescript',
  \ 'ts-node': 'typescript',
  \ }

let s:r_hashbang = '^#!\s*\(\S\+\)\s*\(.*\)\s*'
let s:r_envflag = '%(\S\+=\S\+\|-[iS]\|--ignore-environment\|--split-string\)'
let s:r_env = '^\%(\' . s:r_envflag . '\s\+\)*\(\S\+\)'

func! polyglot#ShebangFiletype()
  let l:line1 = getline(1)

  if l:line1 !~# "^#!"
    return
  endif

  let l:pathrest = matchlist(l:line1, s:r_hashbang)

  if len(l:pathrest) == 0
    return 
  endif

  let [_, l:path, l:rest; __] = l:pathrest

  let l:script = split(l:path, "/")[-1]

  if l:script == "env"
    let l:argspath = matchlist(l:rest, s:r_env)
    if len(l:argspath) == 0
      return
    endif

    let l:script = l:argspath[1]
  endif

  if has_key(s:interpreters, l:script)
    return s:interpreters[l:script]
  endif

  for interpreter in keys(s:interpreters)
    if l:script =~# '^' . interpreter
      return s:interpreters[interpreter]
    endif
  endfor
endfunc

func! polyglot#DetectInpFiletype()
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

func! polyglot#DetectAsaFiletype()
  if exists("g:filetype_asa")
    let &ft = g:filetype_asa | return
  endif
  set ft=aspvbs | return
endfunc

func! polyglot#DetectAspFiletype()
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

func! polyglot#DetectHFiletype()
  for lnum in range(1, min([line("$"), 200]))
    let line = getline(lnum)
    if line =~# '^\s*\(@\(interface\|class\|protocol\|property\|end\|synchronised\|selector\|implementation\)\(\<\|\>\)\|#import\s\+.\+\.h[">]\)'
      if exists("g:c_syntax_for_h")
        set ft=objc | return
      endif
      set ft=objcpp | return
    endif
  endfor
  if exists("g:c_syntax_for_h")
    set ft=c | return
  endif
  if exists("g:ch_syntax_for_h")
    set ft=ch | return
  endif
  set ft=cpp | return
endfunc

func! polyglot#DetectMFiletype()
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
      set ft=octave | return
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
  set ft=octave | return
endfunc

func! polyglot#DetectFsFiletype()
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

func! polyglot#DetectReFiletype()
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\s*#\%(\%(if\|ifdef\|define\|pragma\)\s\+\w\|\s*include\s\+[<"]\|template\s*<\)'
      set ft=cpp | return
    endif
    set ft=reason | return
  endfor
endfunc

func! polyglot#DetectIdrFiletype()
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

func! polyglot#DetectLidrFiletype()
  for lnum in range(1, min([line("$"), 200]))
    let line = getline(lnum)
    if line =~# '^>\s*--.*[Ii]dris \=1'
      set ft=lidris | return
    endif
  endfor
  set ft=lidris2 | return
endfunc

func! polyglot#DetectBasFiletype()
  for lnum in range(1, min([line("$"), 5]))
    let line = getline(lnum)
    if line =~? 'VB_Name\|Begin VB\.\(Form\|MDIForm\|UserControl\)'
      set ft=vb | return
    endif
  endfor
  set ft=basic | return
endfunc

func! polyglot#DetectPmFiletype()
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
  set ft=perl | return
endfunc

func! polyglot#DetectPlFiletype()
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
  set ft=perl | return
endfunc

func! polyglot#DetectTFiletype()
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
  set ft=perl | return
endfunc

func! polyglot#DetectTt2Filetype()
  for lnum in range(1, min([line("$"), 3]))
    let line = getline(lnum)
    if line =~? '<\%(!DOCTYPE HTML\|[%?]\|html\)'
      set ft=tt2html | return
    endif
  endfor
  set ft=tt2 | return
endfunc

func! polyglot#DetectHtmlFiletype()
  let line = getline(nextnonblank(1))
  if line =~# '^\(%\|<[%&].*>\)'
    set ft=mason | return
  endif
  set ft=html | return
endfunc

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
