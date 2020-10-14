" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

func! polyglot#shebang#Detect()
  let ft = s:Filetype()
  if ft != ""
    let &ft = ft
    return 1
  endif

  let err = polyglot#shebang#VimDetect()
  if err == ""
    return 1
  endif

  return 0
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

func! polyglot#shebang#VimDetect()
  let line1 = getline(1)

  if line1 =~# "^#!"
    " A script that starts with "#!".

    " Check for a line like "#!/usr/bin/env {options} bash".  Turn it into
    " "#!/usr/bin/bash" to make matching easier.
    " Recognize only a few {options} that are commonly used.
    if line1 =~# '^#!\s*\S*\<env\s'
      let line1 = substitute(line1, '\S\+=\S\+', '', 'g')
      let line1 = substitute(line1, '\(-[iS]\|--ignore-environment\|--split-string\)', '', '')
      let line1 = substitute(line1, '\<env\s\+', '', '')
    endif

    " Get the program name.
    " Only accept spaces in PC style path "#!c:/program files/perl [args]".
    " If the word env is used, use the first word after the space:
    " "#!/usr/bin/env perl [path/args]"
    " If there is no path use the first word: "#!perl [path/args]".
    " Otherwise get the last word after a slash: "#!/usr/bin/perl [path/args]".
    if line1 =~# '^#!\s*\a:[/\\]'
      let name = substitute(line1, '^#!.*[/\\]\(\i\+\).*', '\1', '')
    elseif line1 =~# '^#!.*\<env\>'
      let name = substitute(line1, '^#!.*\<env\>\s\+\(\i\+\).*', '\1', '')
    elseif line1 =~# '^#!\s*[^/\\ ]*\>\([^/\\]\|$\)'
      let name = substitute(line1, '^#!\s*\([^/\\ ]*\>\).*', '\1', '')
    else
      let name = substitute(line1, '^#!\s*\S*[/\\]\(\i\+\).*', '\1', '')
    endif

    " tcl scripts may have #!/bin/sh in the first line and "exec wish" in the
    " third line.  Suggested by Steven Atkinson.
    if getline(3) =~# '^exec wish'
      let name = 'wish'
    endif

    " Bourne-like shell script bash bash2 ksh ksh93 sh
    if name =~# '^\(bash\d*\|\|ksh\d*\|sh\)\>'
      call dist#ft#SetFileTypeSH(line1)	" defined in filetype.vim
      return

      " csh scripts
    elseif name =~# '^csh\>'
      if exists("g:filetype_csh")
        call dist#ft#SetFileTypeShell(g:filetype_csh)
        return
      else
        call dist#ft#SetFileTypeShell("csh")
        return
      endif

      " tcsh scripts
    elseif name =~# '^tcsh\>'
      call dist#ft#SetFileTypeShell("tcsh")
      return

      " Z shell scripts
    elseif name =~# '^zsh\>'
      set ft=zsh | return

      " TCL scripts
    elseif name =~# '^\(tclsh\|wish\|expectk\|itclsh\|itkwish\)\>'
      set ft=tcl | return

      " Expect scripts
    elseif name =~# '^expect\>'
      set ft=expect | return

      " Gnuplot scripts
    elseif name =~# '^gnuplot\>'
      set ft=gnuplot | return

      " Makefiles
    elseif name =~# 'make\>'
      set ft=make | return

      " Pike
    elseif name =~# '^pike\%(\>\|[0-9]\)'
      set ft=pike | return

      " Lua
    elseif name =~# 'lua'
      set ft=lua | return

      " Perl 6
    elseif name =~# 'perl6'
      set ft=perl6 | return

      " Perl
    elseif name =~# 'perl'
      set ft=perl | return

      " PHP
    elseif name =~# 'php'
      set ft=php | return

      " Python
    elseif name =~# 'python'
      set ft=python | return

      " Groovy
    elseif name =~# '^groovy\>'
      set ft=groovy | return

      " Ruby
    elseif name =~# 'ruby'
      set ft=ruby | return

      " JavaScript
    elseif name =~# 'node\(js\)\=\>\|js\>' || name =~# 'rhino\>'
      set ft=javascript | return

      " BC calculator
    elseif name =~# '^bc\>'
      set ft=bc | return

      " sed
    elseif name =~# 'sed\>'
      set ft=sed | return

      " OCaml-scripts
    elseif name =~# 'ocaml'
      set ft=ocaml | return

      " Awk scripts; also finds "gawk"
    elseif name =~# 'awk\>'
      set ft=awk | return

      " Website MetaLanguage
    elseif name =~# 'wml'
      set ft=wml | return

      " Scheme scripts
    elseif name =~# 'scheme'
      set ft=scheme | return

      " CFEngine scripts
    elseif name =~# 'cfengine'
      set ft=cfengine | return

      " Erlang scripts
    elseif name =~# 'escript'
      set ft=erlang | return

      " Haskell
    elseif name =~# 'haskell'
      set ft=haskell | return

      " Scala
    elseif name =~# 'scala\>'
      set ft=scala | return

      " Clojure
    elseif name =~# 'clojure'
      set ft=clojure | return

    endif
    unlet name

  else
    " File does not start with "#!".

    let line2 = getline(2)
    let line3 = getline(3)
    let line4 = getline(4)
    let line5 = getline(5)

    " Bourne-like shell script sh ksh bash bash2
    if line1 =~# '^:$'
      call dist#ft#SetFileTypeSH(line1)	" defined in filetype.vim
      return

    " Z shell scripts
    elseif line1 =~# '^#compdef\>' || line1 =~# '^#autoload\>' ||
          \ "\n".line1."\n".line2."\n".line3."\n".line4."\n".line5 =~# '\n\s*emulate\s\+\%(-[LR]\s\+\)\=[ckz]\=sh\>'
      set ft=zsh | return

    " ELM Mail files
    elseif line1 =~# '^From \([a-zA-Z][a-zA-Z_0-9\.=-]*\(@[^ ]*\)\=\|-\) .* \(19\|20\)\d\d$'
      set ft=mail | return

    " Mason
    elseif line1 =~# '^<[%&].*>'
      set ft=mason | return

    " Vim scripts (must have '" vim' as the first line to trigger this)
    elseif line1 =~# '^" *[vV]im$'
      set ft=vim | return

    " libcxx and libstdc++ standard library headers like "iostream" do not have
    " an extension, recognize the Emacs file mode.
    elseif line1 =~? '-\*-.*C++.*-\*-'
      set ft=cpp | return

    " MOO
    elseif line1 =~# '^\*\* LambdaMOO Database, Format Version \%([1-3]\>\)\@!\d\+ \*\*$'
      set ft=moo | return

      " Diff file:
      " - "diff" in first line (context diff)
      " - "Only in " in first line
      " - "--- " in first line and "+++ " in second line (unified diff).
      " - "*** " in first line and "--- " in second line (context diff).
      " - "# It was generated by makepatch " in the second line (makepatch diff).
      " - "Index: <filename>" in the first line (CVS file)
      " - "=== ", line of "=", "---", "+++ " (SVK diff)
      " - "=== ", "--- ", "+++ " (bzr diff, common case)
      " - "=== (removed|added|renamed|modified)" (bzr diff, alternative)
      " - "# HG changeset patch" in first line (Mercurial export format)
    elseif line1 =~# '^\(diff\>\|Only in \|\d\+\(,\d\+\)\=[cda]\d\+\>\|# It was generated by makepatch \|Index:\s\+\f\+\r\=$\|===== \f\+ \d\+\.\d\+ vs edited\|==== //\f\+#\d\+\|# HG changeset patch\)'
    \ || (line1 =~# '^--- ' && line2 =~# '^+++ ')
    \ || (line1 =~# '^\* looking for ' && line2 =~# '^\* comparing to ')
    \ || (line1 =~# '^\*\*\* ' && line2 =~# '^--- ')
    \ || (line1 =~# '^=== ' && ((line2 =~# '^=\{66\}' && line3 =~# '^--- ' && line4 =~# '^+++') || (line2 =~# '^--- ' && line3 =~# '^+++ ')))
    \ || (line1 =~# '^=== \(removed\|added\|renamed\|modified\)')
      set ft=diff | return

      " PostScript Files (must have %!PS as the first line, like a2ps output)
    elseif line1 =~# '^%![ \t]*PS'
      set ft=postscr | return

      " M4 script Guess there is a line that starts with "dnl".
    elseif line1 =~# '^\s*dnl\>'
    \ || line2 =~# '^\s*dnl\>'
    \ || line3 =~# '^\s*dnl\>'
    \ || line4 =~# '^\s*dnl\>'
    \ || line5 =~# '^\s*dnl\>'
      set ft=m4 | return

      " AmigaDos scripts
    elseif $TERM == "amiga"
    \ && (line1 =~# "^;" || line1 =~? '^\.bra')
      set ft=amiga | return

      " SiCAD scripts (must have procn or procd as the first line to trigger this)
    elseif line1 =~? '^ *proc[nd] *$'
      set ft=sicad | return

      " Purify log files start with "****  Purify"
    elseif line1 =~# '^\*\*\*\*  Purify'
      set ft=purifylog | return

      " XML
    elseif line1 =~# '<?\s*xml.*?>'
      set ft=xml | return

      " XHTML (e.g.: PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN")
    elseif line1 =~# '\<DTD\s\+XHTML\s'
      set ft=xhtml | return

      " HTML (e.g.: <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN")
      " Avoid "doctype html", used by slim.
    elseif line1 =~? '<!DOCTYPE\s\+html\>'
      set ft=html | return

      " PDF
    elseif line1 =~# '^%PDF-'
      set ft=pdf | return

      " XXD output
    elseif line1 =~# '^\x\{7}: \x\{2} \=\x\{2} \=\x\{2} \=\x\{2} '
      set ft=xxd | return

      " RCS/CVS log output
    elseif line1 =~# '^RCS file:' || line2 =~# '^RCS file:'
      set ft=rcslog | return

      " CVS commit
    elseif line2 =~# '^CV' || getline("$") =~# '^CV '
      set ft=cvs | return

      " Prescribe
    elseif line1 =~# '^!R!'
      set ft=prescribe | return

      " Send-pr
    elseif line1 =~# '^SEND-PR:'
      set ft=sendpr | return

      " SNNS files
    elseif line1 =~# '^SNNS network definition file'
      set ft=snnsnet | return
    elseif line1 =~# '^SNNS pattern definition file'
      set ft=snnspat | return
    elseif line1 =~# '^SNNS result file'
      set ft=snnsres | return

      " Virata
    elseif line1 =~# '^%.\{-}[Vv]irata'
    \ || line2 =~# '^%.\{-}[Vv]irata'
    \ || line3 =~# '^%.\{-}[Vv]irata'
    \ || line4 =~# '^%.\{-}[Vv]irata'
    \ || line5 =~# '^%.\{-}[Vv]irata'
      set ft=virata | return

      " Strace
    elseif line1 =~# '[0-9:.]* *execve(' || line1 =~# '^__libc_start_main'
      set ft=strace | return

      " VSE JCL
    elseif line1 =~# '^\* $$ JOB\>' || line1 =~# '^// *JOB\>'
      set ft=vsejcl | return

      " TAK and SINDA
    elseif line4 =~# 'K & K  Associates' || line2 =~# 'TAK 2000'
      set ft=takout | return
    elseif line3 =~# 'S Y S T E M S   I M P R O V E D '
      set ft=sindaout | return
    elseif getline(6) =~# 'Run Date: '
      set ft=takcmp | return
    elseif getline(9) =~# 'Node    File  1'
      set ft=sindacmp | return

      " DNS zone files
    elseif line1.line2.line3.line4 =~# '^; <<>> DiG [0-9.]\+.* <<>>\|$ORIGIN\|$TTL\|IN\s\+SOA'
      set ft=bindzone | return

      " BAAN
    elseif line1 =~# '|\*\{1,80}' && line2 =~# 'VRC '
    \ || line2 =~# '|\*\{1,80}' && line3 =~# 'VRC '
      set ft=baan | return

    " Valgrind
    elseif line1 =~# '^==\d\+== valgrind' || line3 =~# '^==\d\+== Using valgrind'
      set ft=valgrind | return

    " Go docs
    elseif line1 =~# '^PACKAGE DOCUMENTATION$'
      set ft=godoc | return

    " Renderman Interface Bytestream
    elseif line1 =~# '^##RenderMan'
      set ft=rib | return

    " Scheme scripts
    elseif line1 =~# 'exec\s\+\S*scheme' || line2 =~# 'exec\s\+\S*scheme'
      set ft=scheme | return

    " Git output
    elseif line1 =~# '^\(commit\|tree\|object\) \x\{40\}\>\|^tag \S\+$'
      set ft=git | return

     " Gprof (gnu profiler)
     elseif line1 == 'Flat profile:'
       \ && line2 == ''
       \ && line3 =~# '^Each sample counts as .* seconds.$'
       set ft=gprof | return

    " Erlang terms
    " (See also: http://www.gnu.org/software/emacs/manual/html_node/emacs/Choosing-Modes.html#Choosing-Modes)
    elseif line1 =~? '-\*-.*erlang.*-\*-'
      set ft=erlang | return

    " YAML
    elseif line1 =~# '^%YAML'
      set ft=yaml | return

    " CVS diff
    else
      let lnum = 1
      while getline(lnum) =~# "^? " && lnum < line("$")
        let lnum += 1
      endwhile
      if getline(lnum) =~# '^Index:\s\+\f\+$'
        set ft=diff | return

        " locale input file Formal Definitions of Cultural Conventions
        " filename must be like en_US, fr_FR@euro or en_US.UTF-8
      elseif expand("%") =~# '\a\a_\a\a\($\|[.@]\)\|i18n$\|POSIX$\|translit_'
        let lnum = 1
        while lnum < 100 && lnum < line("$")
    if getline(lnum) =~# '^LC_\(IDENTIFICATION\|CTYPE\|COLLATE\|MONETARY\|NUMERIC\|TIME\|MESSAGES\|PAPER\|TELEPHONE\|MEASUREMENT\|NAME\|ADDRESS\)$'
      setf fdcc | return
      break
    endif
    let lnum += 1
        endwhile
      endif
      unlet lnum

    endif

  endif

  return 1
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
  \ 'runghc': 'haskell',
  \ 'runhaskell': 'haskell',
  \ 'runhugs': 'haskell',
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
  \ 'zsh': 'zsh',
  \ }
" DO NOT EDIT CODE ABOVE, IT IS GENERATED WITH MAKEFILE

let &cpo = s:cpo_save
unlet s:cpo_save
