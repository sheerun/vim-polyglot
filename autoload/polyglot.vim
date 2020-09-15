" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

" We need it because scripts.vim in vim uses "set ft=" which cannot be
" overridden with setf (and we can't use set ft= so our scripts.vim work)
func! s:Setf(ft)
  if &filetype !~# '<'.a:ft.'>'
    let &filetype = a:ft
  endif
endfunc

func! polyglot#Heuristics()
  " Try to detect filetype from shebang
  let l:filetype = polyglot#Shebang()
  if l:filetype != ""
    exec "setf " . l:filetype
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

func! polyglot#Shebang()
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
  let line = getline(1)
  if line =~# '^\*'
    call s:Setf('abaqus') | return
  endif
  for lnum in range(1, min([line("$"), 500]))
    let line = getline(lnum)
    if line =~? '^header surface data'
      call s:Setf('trasys') | return
    endif
  endfor
endfunc

func! polyglot#DetectAsaFiletype()
  if exists("g:filetype_asa")
    call s:Setf(g:filetype_asa) | return
  endif
  call s:Setf('aspvbs') | return
endfunc

func! polyglot#DetectAspFiletype()
  if exists("g:filetype_asp")
    call s:Setf(g:filetype_asp) | return
  endif
  for lnum in range(1, min([line("$"), 3]))
    let line = getline(lnum)
    if line =~? 'perlscript'
      call s:Setf('aspperl') | return
    endif
  endfor
  call s:Setf('aspvbs') | return
endfunc

func! polyglot#DetectHFiletype()
  for lnum in range(1, min([line("$"), 200]))
    let line = getline(lnum)
    if line =~# '^\s*\(@\(interface\|class\|protocol\|property\|end\|synchronised\|selector\|implementation\)\(\<\|\>\)\|#import\s\+.\+\.h[">]\)'
      if exists("g:c_syntax_for_h")
        call s:Setf('objc') | return
      endif
      call s:Setf('objcpp') | return
    endif
  endfor
  if exists("g:c_syntax_for_h")
    call s:Setf('c') | return
  endif
  if exists("g:ch_syntax_for_h")
    call s:Setf('ch') | return
  endif
  call s:Setf('cpp') | return
endfunc

func! polyglot#DetectMFiletype()
  let saw_comment = 0
  for lnum in range(1, min([line("$"), 100]))
    let line = getline(lnum)
    if line =~# '^\s*/\*'
      let saw_comment = 1
    endif
    if line =~# '^\s*\(@\(interface\|class\|protocol\|property\|end\|synchronised\|selector\|implementation\)\(\<\|\>\)\|#import\s\+.\+\.h[">]\)'
      call s:Setf('objc') | return
    endif
    if line =~# '^\s*%'
      call s:Setf('octave') | return
    endif
    if line =~# '^\s*(\*'
      call s:Setf('mma') | return
    endif
    if line =~? '^\s*\(\(type\|var\)\(\<\|\>\)\|--\)'
      call s:Setf('murphi') | return
    endif
  endfor
  if saw_comment
    call s:Setf('objc') | return
  endif
  if exists("g:filetype_m")
    call s:Setf(g:filetype_m) | return
  endif
  call s:Setf('octave') | return
endfunc

func! polyglot#DetectFsFiletype()
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\(: \|new-device\)'
      call s:Setf('forth') | return
    endif
    if line =~# '^\s*\(#light\|import\|let\|module\|namespace\|open\|type\)'
      call s:Setf('fsharp') | return
    endif
    if line =~# '\s*\(#version\|precision\|uniform\|varying\|vec[234]\)'
      call s:Setf('glsl') | return
    endif
  endfor
  if exists("g:filetype_fs")
    call s:Setf(g:filetype_fs) | return
  endif
  call s:Setf('forth') | return
endfunc

func! polyglot#DetectReFiletype()
  for lnum in range(1, min([line("$"), 50]))
    let line = getline(lnum)
    if line =~# '^\s*#\%(\%(if\|ifdef\|define\|pragma\)\s\+\w\|\s*include\s\+[<"]\|template\s*<\)'
      call s:Setf('cpp') | return
    endif
    call s:Setf('reason') | return
  endfor
endfunc

func! polyglot#DetectIdrFiletype()
  for lnum in range(1, min([line("$"), 5]))
    let line = getline(lnum)
    if line =~# '^\s*--.*[Ii]dris \=1'
      call s:Setf('idris') | return
    endif
    if line =~# '^\s*--.*[Ii]dris \=2'
      call s:Setf('idris2') | return
    endif
  endfor
  for lnum in range(1, min([line("$"), 30]))
    let line = getline(lnum)
    if line =~# '^pkgs =.*'
      call s:Setf('idris') | return
    endif
    if line =~# '^depends =.*'
      call s:Setf('idris2') | return
    endif
    if line =~# '^%language \(TypeProviders\|ElabReflection\)'
      call s:Setf('idris') | return
    endif
    if line =~# '^%language PostfixProjections'
      call s:Setf('idris2') | return
    endif
    if line =~# '^%access .*'
      call s:Setf('idris') | return
    endif
    if exists("g:filetype_idr")
      call s:Setf(g:filetype_idr) | return
    endif
  endfor
  call s:Setf('idris2') | return
endfunc

func! polyglot#DetectLidrFiletype()
  for lnum in range(1, min([line("$"), 200]))
    let line = getline(lnum)
    if line =~# '^>\s*--.*[Ii]dris \=1'
      call s:Setf('lidris') | return
    endif
  endfor
  call s:Setf('lidris2') | return
endfunc

func! polyglot#DetectBasFiletype()
  for lnum in range(1, min([line("$"), 5]))
    let line = getline(lnum)
    if line =~? 'VB_Name\|Begin VB\.\(Form\|MDIForm\|UserControl\)'
      call s:Setf('vb') | return
    endif
  endfor
  call s:Setf('basic') | return
endfunc

" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
