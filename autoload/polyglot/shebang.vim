func! polyglot#shebang#Detect()
  let ft = s:Filetype()
  if ft != ""
    let &ft = ft
  endif

  if &ft == ""
    runtime! scripts.vim
  endif

  return &ft != ""
endfunc

let s:r_hashbang = '^#!\s*\(\S\+\)\s*\(.*\)\s*'
let s:r_envflag = '%(\S\+=\S\+\|-[iS]\|--ignore-environment\|--split-string\)'
let s:r_env = '^\%(\' . s:r_envflag . '\s\+\)*\(\S\+\)'

func! s:Filetype()
  let l:line1 = getline(1)

  if l:line1 !~# "^#!"
    return
  endif

  let l:pathrest = matchlist(l:line1, s:r_hashbang)

  if len(l:pathrest) == 0
    return
  endif

  let [_, l:path, l:rest; __] = l:pathrest

  let l:pathparts = split(l:path, "/")

  if len(l:pathparts) == 0
    return
  endif

  let l:script = l:pathparts[-1]

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

" DO NOT EDIT CODE BELOW, IT IS GENERATED WITH MAKEFILE

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
