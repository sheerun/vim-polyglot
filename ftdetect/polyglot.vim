" Enable jsx syntax by default
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 0
endif

" Make csv loading faster
if !exists('g:csv_start')
  let g:csv_start = 1
endif
if !exists('g:csv_end')
  let g:csv_end = 2
endif

" Disable json concealing by default
if !exists('g:vim_json_syntax_conceal')
  let g:vim_json_syntax_conceal = 0
endif

let g:filetype_euphoria = 'elixir'

augroup filetypedetect
  autocmd BufNewFile,BufReadPost *.vb setlocal filetype=vbnet
augroup END

let g:python_highlight_all = 1

augroup filetypedetect
  if v:version < 704
    " NOTE: this line fixes an issue with the default system-wide lisp ftplugin
    "       which didn't define b:undo_ftplugin on older Vim versions
    "       (*.jl files are recognized as lisp)
    autocmd BufRead,BufNewFile *.jl    let b:undo_ftplugin = "setlocal comments< define< formatoptions< iskeyword< lisp<"
  endif
  
  autocmd BufRead,BufNewFile *.jl      set filetype=julia

  " coffeescript
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
  autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
  autocmd BufNewFile,BufRead *._coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.litcoffee set filetype=litcoffee
  autocmd BufNewFile,BufRead *.coffee.md set filetype=litcoffee


  " elixir
  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au BufRead,BufNewFile *.eex,*.leex set filetype=eelixir
  au BufRead,BufNewFile mix.lock set filetype=elixir

  " fish
  autocmd BufRead,BufNewFile *.fish setfiletype fish
  autocmd BufRead fish_funced_*_*.fish call search('^$')
  autocmd BufRead,BufNewFile ~/.config/fish/fish_{read_,}history setfiletype yaml
  autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly
  autocmd BufNewFile ~/.config/fish/functions/*.fish
              \ call append(0, ['function '.expand('%:t:r'),
                               \'',
                               \'end']) |
              \ 2
  
  " git
  autocmd BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
  autocmd BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
  autocmd BufNewFile,BufRead */.config/git/config                          set ft=gitconfig
  autocmd BufNewFile,BufRead *.git/modules/**/config                       set ft=gitconfig
  autocmd BufNewFile,BufRead git-rebase-todo                               set ft=gitrebase
  autocmd BufNewFile,BufRead .gitsendemail.*                               set ft=gitsendemail

  " plantuml
  autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml,*.puml setfiletype plantuml | set filetype=plantuml

  " scala
  au BufRead,BufNewFile *.scala,*.sc set filetype=scala
  au BufRead,BufNewFile *.sbt setfiletype sbt.scala

  " swift
  autocmd BufNewFile,BufRead *.swift set filetype=swift

  "jinja
  autocmd BufNewFile,BufRead *.jinja2,*.j2,*.jinja,*.nunjucks,*.nunjs,*.njk set ft=jinja
augroup END
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'acpiasl') == -1
  augroup filetypedetect
  " acpiasl, from asl.vim in martinlroth/vim-acpi-asl
au BufRead,BufNewFile *.asl set filetype=asl
au BufRead,BufNewFile *.dsl set filetype=asl
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1
  augroup filetypedetect
  " ansible, from ansible.vim in pearofducks/ansible-vim
function! s:isAnsible()
  let filepath = expand("%:p")
  let filename = expand("%:t")
  if filepath =~ '\v/(tasks|roles|handlers)/.*\.ya?ml$' | return 1 | en
  if filepath =~ '\v/(group|host)_vars/' | return 1 | en
  if filename =~ '\v(playbook|site|main|local)\.ya?ml$' | return 1 | en

  let shebang = getline(1)
  if shebang =~# '^#!.*/bin/env\s\+ansible-playbook\>' | return 1 | en
  if shebang =~# '^#!.*/bin/ansible-playbook\>' | return 1 | en

  return 0
endfunction

function! s:setupTemplate()
  if exists("g:ansible_template_syntaxes")
    let filepath = expand("%:p")
    for syntax_name in items(g:ansible_template_syntaxes)
      let s:syntax_string = '\v/'.syntax_name[0]
      if filepath =~ s:syntax_string
        execute 'set ft='.syntax_name[1].'.jinja2'
        return
      endif
    endfor
  endif
  set ft=jinja2
endfunction

augroup ansible_vim_ftyaml_ansible
    au!
    au BufNewFile,BufRead * if s:isAnsible() | set ft=yaml.ansible | en
augroup END
augroup ansible_vim_ftjinja2
    au!
    au BufNewFile,BufRead *.j2 call s:setupTemplate()
augroup END
augroup ansible_vim_fthosts
    au!
    au BufNewFile,BufRead hosts set ft=ansible_hosts
augroup END
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'apiblueprint') == -1
  augroup filetypedetect
  " apiblueprint, from apiblueprint.vim in sheerun/apiblueprint.vim
autocmd BufReadPost,BufNewFile *.apib set filetype=apiblueprint
autocmd FileType apiblueprint set syntax=apiblueprint
autocmd FileType apiblueprint set makeprg=drafter\ -l\ %
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'applescript') == -1
  augroup filetypedetect
  " applescript, from applescript.vim in mityu/vim-applescript:_SYNTAX
"Plugin Name: AppleScript
"Author: mityu
"Last Change: 04-Mar-2017.

let s:cpo_save=&cpo
set cpo&vim

au BufNewFile,BufRead *.scpt setf applescript
au BufNewFile,BufRead *.applescript setf applescript

let &cpo=s:cpo_save
unlet s:cpo_save

" vim: foldmethod=marker
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'arduino') == -1
  augroup filetypedetect
  " arduino, from arduino.vim in sudar/vim-arduino-syntax
au BufRead,BufNewFile *.ino,*.pde set filetype=arduino
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'asciidoc') == -1
  augroup filetypedetect
  " asciidoc, from asciidoc.vim in asciidoc/vim-asciidoc
autocmd BufNewFile,BufRead *.asciidoc,*.adoc
	\ set ft=asciidoc
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'blade') == -1
  augroup filetypedetect
  " blade, from blade.vim in jwalton512/vim-blade
autocmd BufNewFile,BufRead *.blade.php set filetype=blade
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'caddyfile') == -1
  augroup filetypedetect
  " caddyfile, from caddyfile.vim in isobit/vim-caddyfile
au BufNewFile,BufRead Caddyfile set ft=caddyfile
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'carp') == -1
  augroup filetypedetect
  " carp, from carp.vim in hellerve/carp-vim
au BufRead,BufNewFile *.carp set filetype=carp
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cjsx') == -1
  augroup filetypedetect
  " cjsx, from cjsx.vim in mtscout6/vim-cjsx
augroup CJSX
  au!
  autocmd BufNewFile,BufRead *.csx,*.cjsx set filetype=coffee
augroup END
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'clojure') == -1
  augroup filetypedetect
  " clojure, from clojure.vim in guns/vim-clojure-static
autocmd BufNewFile,BufRead *.clj,*.cljs,*.edn,*.cljx,*.cljc,{build,profile}.boot setlocal filetype=clojure
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cql') == -1
  augroup filetypedetect
  " cql, from cql.vim in elubow/cql-vim
if has("autocmd")
  au  BufNewFile,BufRead *.cql set filetype=cql
endif
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cryptol') == -1
  augroup filetypedetect
  " cryptol, from cryptol.vim in victoredwardocallaghan/cryptol.vim
" Copyright © 2013 Edward O'Callaghan. All Rights Reserved.
"  Normal Cryptol Program;
au! BufRead,BufNewFile *.cry set filetype=cryptol
au! BufRead,BufNewFile *.cyl set filetype=cryptol
"  Literate Cryptol Program;
au! BufRead,BufNewFile *.lcry set filetype=cryptol
au! BufRead,BufNewFile *.lcyl set filetype=cryptol
" Also in LaTeX *.tex which is outside our coverage scope.
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'crystal') == -1
  augroup filetypedetect
  " crystal, from crystal.vim in rhysd/vim-crystal
" vint: -ProhibitAutocmdWithNoGroup
autocmd BufNewFile,BufReadPost *.cr setlocal filetype=crystal
autocmd BufNewFile,BufReadPost Projectfile setlocal filetype=crystal
autocmd BufNewFile,BufReadPost *.ecr setlocal filetype=eruby
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'csv') == -1
  augroup filetypedetect
  " csv, from csv.vim in chrisbra/csv.vim
" Install Filetype detection for CSV files
au BufRead,BufNewFile *.csv,*.dat,*.tsv,*.tab set filetype=csv
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cucumber') == -1
  augroup filetypedetect
  " cucumber, from cucumber.vim in tpope/vim-cucumber
" Cucumber
autocmd BufNewFile,BufReadPost *.feature,*.story set filetype=cucumber
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cue') == -1
  augroup filetypedetect
  " cue, from cuesheet.vim in mgrabovsky/vim-cuesheet
autocmd BufRead,BufNewFile *.cue set filetype=cuesheet
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dart') == -1
  augroup filetypedetect
  " dart, from dart.vim in dart-lang/dart-vim-plugin
autocmd BufRead,BufNewFile *.dart set filetype=dart

function! s:DetectShebang()
  if did_filetype() | return | endif
  if getline(1) == '#!/usr/bin/env dart'
    setlocal filetype=dart
  endif
endfunction

autocmd BufRead * call s:DetectShebang()
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dhall') == -1
  augroup filetypedetect
  " dhall, from dhall.vim in vmchale/dhall-vim
augroup dhall
    autocmd BufNewFile,BufRead *.dhall set filetype=dhall
augroup END
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1
  augroup filetypedetect
  " dlang, from d.vim in JesseKPhillips/d.vim
autocmd BufNewFile,BufRead *.d setf d
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1
  augroup filetypedetect
  " dlang, from dcov.vim in JesseKPhillips/d.vim
autocmd BufNewFile,BufRead *.lst set filetype=dcov
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1
  augroup filetypedetect
  " dlang, from dd.vim in JesseKPhillips/d.vim
au BufRead,BufNewFile *.dd set filetype=dd
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1
  augroup filetypedetect
  " dlang, from ddoc.vim in JesseKPhillips/d.vim
au BufRead,BufNewFile *.ddoc set filetype=ddoc
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dlang') == -1
  augroup filetypedetect
  " dlang, from dsdl.vim in JesseKPhillips/d.vim
autocmd BufNewFile,BufRead *.sdl set filetype=dsdl
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1
  augroup filetypedetect
  " dockerfile, from Dockerfile.vim in ekalinin/Dockerfile.vim
" vint: -ProhibitAutocmdWithNoGroup

" Dockerfile
autocmd BufRead,BufNewFile [Dd]ockerfile set ft=Dockerfile
autocmd BufRead,BufNewFile Dockerfile* set ft=Dockerfile
autocmd BufRead,BufNewFile [Dd]ockerfile.vim set ft=vim
autocmd BufRead,BufNewFile *.dock set ft=Dockerfile
autocmd BufRead,BufNewFile *.[Dd]ockerfile set ft=Dockerfile
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1
  augroup filetypedetect
  " dockerfile, from docker-compose.vim in ekalinin/Dockerfile.vim
" vint: -ProhibitAutocmdWithNoGroup

" docker-compose.yml
autocmd BufRead,BufNewFile docker-compose*.{yaml,yml}* set ft=yaml.docker-compose
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elm') == -1
  augroup filetypedetect
  " elm, from elm.vim in ElmCast/elm-vim
" detection for Elm (http://elm-lang.org/)

au BufRead,BufNewFile *.elm set filetype=elm
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1
  augroup filetypedetect
  " emberscript, from ember-script.vim in yalesov/vim-ember-script
" Language:    ember-script
" Maintainer:  Yulij Andreevich Lesov <yalesov@gmail.com>>
" URL:         http://github.com/yalesov/vim-ember-script
" Version:     1.0.4
" Last Change: 2016 Jul 6
" License:     ISC

if !exists('g:vim_ember_script')
  let g:vim_ember_script = 1
endif

autocmd BufNewFile,BufRead *.em set filetype=ember-script
autocmd FileType ember-script set tabstop=2|set shiftwidth=2|set expandtab
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emblem') == -1
  augroup filetypedetect
  " emblem, from emblem.vim in yalesov/vim-emblem
" Language:    emblem
" Maintainer:  Yulij Andreevich Lesov <yalesov@gmail.com>
" URL:         http://github.com/yalesov/vim-emblem
" Version:     2.0.1
" Last Change: 2016 Jul 6
" License:     ISC

if !exists('g:vim_emblem')
  let g:vim_emblem = 1
endif

if exists('g:vim_ember_script')
  autocmd BufNewFile,BufRead *.emblem set filetype=emblem
else
  autocmd BufNewFile,BufRead *.em,*.emblem set filetype=emblem
endif
autocmd FileType emblem set tabstop=2|set shiftwidth=2|set expandtab
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'erlang') == -1
  augroup filetypedetect
  " erlang, from erlang.vim in vim-erlang/vim-erlang-runtime
au BufNewFile,BufRead *.erl,*.hrl,rebar.config,*.app,*.app.src,*.yaws,*.xrl,*.escript set ft=erlang
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ferm') == -1
  augroup filetypedetect
  " ferm, from ferm.vim in vim-scripts/ferm.vim
autocmd BufNewFile,BufRead ferm.conf setf ferm 
autocmd BufNewFile,BufRead *.ferm setf ferm
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'flatbuffers') == -1
  augroup filetypedetect
  " flatbuffers, from fbs.vim in dcharbon/vim-flatbuffers
autocmd BufNewFile,BufRead *.fbs setfiletype fbs
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fsharp') == -1
  augroup filetypedetect
  " fsharp, from fsharp.vim in fsharp/vim-fsharp:_BASIC
" F#, fsharp
autocmd BufNewFile,BufRead *.fs,*.fsi,*.fsx set filetype=fsharp
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'glsl') == -1
  augroup filetypedetect
  " glsl, from glsl.vim in tikhomirov/vim-glsl:_NOAFTER
" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

" Extensions supported by Khronos reference compiler (with one exception, ".glsl")
" https://github.com/KhronosGroup/glslang
autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set filetype=glsl

" vim:set sts=2 sw=2 :
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'gmpl') == -1
  augroup filetypedetect
  " gmpl, from gmpl.vim in maelvalais/gmpl.vim
au BufRead,BufNewFile *.mod set filetype=gmpl
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'go') == -1
  augroup filetypedetect
  " go, from gofiletype.vim in fatih/vim-go:_BASIC
" vint: -ProhibitAutocmdWithNoGroup

" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

" Note: should not use augroup in ftdetect (see :help ftdetect)
au BufRead,BufNewFile *.go setfiletype go
au BufRead,BufNewFile *.s setfiletype asm
au BufRead,BufNewFile *.tmpl setfiletype gohtmltmpl

" remove the autocommands for modsim3, and lprolog files so that their
" highlight groups, syntax, etc. will not be loaded. *.MOD is included, so
" that on case insensitive file systems the module2 autocmds will not be
" executed.
au! BufRead,BufNewFile *.mod,*.MOD
" Set the filetype if the first non-comment and non-blank line starts with
" 'module <path>'.
au BufRead,BufNewFile go.mod call s:gomod()

fun! s:gomod()
  for l:i in range(1, line('$'))
    let l:l = getline(l:i)
    if l:l ==# '' || l:l[:1] ==# '//'
      continue
    endif

    if l:l =~# '^module .\+'
      setfiletype gomod
    endif

    break
  endfor
endfun

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 ts=2 et
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1
  augroup filetypedetect
  " graphql, from graphql.vim in jparise/vim-graphql:_ALL
" vint: -ProhibitAutocmdWithNoGroup
au BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'gradle') == -1
  augroup filetypedetect
  " gradle, from gradle.vim in tfnico/vim-gradle
" gradle syntax highlighting
au BufNewFile,BufRead *.gradle set filetype=groovy
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haml') == -1
  augroup filetypedetect
  " haml, from haml.vim in sheerun/vim-haml
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'handlebars') == -1
  augroup filetypedetect
  " handlebars, from mustache.vim in mustache/vim-mustache-handlebars
if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim indent/handlebars.vim
  au  BufNewFile,BufRead *.handlebars,*.hdbs,*.hbs,*.hb set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haproxy') == -1
  augroup filetypedetect
  " haproxy, from haproxy.vim in CH-DanReif/haproxy.vim
au BufRead,BufNewFile haproxy*.c* set ft=haproxy
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1
  augroup filetypedetect
  " haskell, from haskell.vim in neovimhaskell/haskell-vim
au BufRead,BufNewFile *.hsc set filetype=haskell
au BufRead,BufNewFile *.bpk set filetype=haskell
au BufRead,BufNewFile *.hsig set filetype=haskell
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haxe') == -1
  augroup filetypedetect
  " haxe, from haxe.vim in yaymukund/vim-haxe
autocmd BufNewFile,BufRead *.hx setf haxe
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hcl') == -1
  augroup filetypedetect
  " hcl, from hcl.vim in b4b4r07/vim-hcl
autocmd BufNewFile,BufRead *.hcl set filetype=hcl
autocmd BufNewFile,BufRead *.nomad set filetype=hcl
autocmd BufNewFile,BufRead *.tf set filetype=hcl
autocmd BufNewFile,BufRead Appfile set filetype=hcl
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'helm') == -1
  augroup filetypedetect
  " helm, from helm.vim in towolf/vim-helm
autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl set ft=helm
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'hive') == -1
  augroup filetypedetect
  " hive, from hive.vim in zebradil/hive.vim
autocmd BufNewFile,BufRead *.hql set filetype=hive
autocmd BufNewFile,BufRead *.ql set filetype=hive
autocmd BufNewFile,BufRead *.q set filetype=hive
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'i3') == -1
  augroup filetypedetect
  " i3, from i3config.vim in mboughaba/i3config.vim
aug i3config#ft_detect
    au!
    au BufNewFile,BufRead .i3.config,i3.config,*.i3config,*.i3.config set filetype=i3config
aug end
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'idris') == -1
  augroup filetypedetect
  " idris, from idris.vim in idris-hackers/idris-vim
au BufNewFile,BufRead *.idr setf idris
au BufNewFile,BufRead idris-response setf idris
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'idris') == -1
  augroup filetypedetect
  " idris, from lidris.vim in idris-hackers/idris-vim
au BufNewFile,BufRead *.lidr setf lidris
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ion') == -1
  augroup filetypedetect
  " ion, from ion.vim in vmchale/ion-vim
autocmd BufNewFile,BufRead ~/.config/ion/initrc set filetype=ion
autocmd BufNewFile,BufRead *.ion set filetype=ion

autocmd BufNewFile,BufRead,StdinReadPost *
    \ if getline(1) =~ '^#!.*\Wion\s*$' |
    \   set ft=ion |
    \ endif
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jasmine') == -1
  augroup filetypedetect
  " jasmine, from jasmine.vim in glanotte/vim-jasmine
autocmd BufNewFile,BufRead *Spec.js,*_spec.js set filetype=jasmine.javascript syntax=jasmine
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  augroup filetypedetect
  " javascript, from javascript.vim in pangloss/vim-javascript:_JAVASCRIPT
fun! s:SelectJavascript()
  if getline(1) =~# '^#!.*/bin/\%(env\s\+\)\?node\>'
    set ft=javascript
  endif
endfun

autocmd BufNewFile,BufRead *.{js,mjs,jsm,es,es6},Jakefile setfiletype javascript
autocmd BufNewFile,BufRead * call s:SelectJavascript()
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jenkins') == -1
  augroup filetypedetect
  " jenkins, from Jenkinsfile.vim in martinda/Jenkinsfile-vim-syntax
" Jenkinsfile

augroup JenkinsAUGroup
  autocmd BufRead,BufNewFile *Jenkins* set ft=Jenkinsfile
  autocmd BufRead,BufNewFile *jenkins* set ft=Jenkinsfile
augroup END
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'json5') == -1
  augroup filetypedetect
  " json5, from json5.vim in GutenYe/json5.vim
au BufNewFile,BufRead *.json5 setfiletype json5
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'json') == -1
  augroup filetypedetect
  " json, from json.vim in elzr/vim-json
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonl setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonp setlocal filetype=json
autocmd BufNewFile,BufRead *.geojson setlocal filetype=json
autocmd BufNewFile,BufRead *.template setlocal filetype=json
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jst') == -1
  augroup filetypedetect
  " jst, from jst.vim in briancollins/vim-jst
au BufNewFile,BufRead *.ejs set filetype=jst
au BufNewFile,BufRead *.jst set filetype=jst
au BufNewFile,BufRead *.djs set filetype=jst
au BufNewFile,BufRead *.hamljs set filetype=jst
au BufNewFile,BufRead *.ect set filetype=jst
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'kotlin') == -1
  augroup filetypedetect
  " kotlin, from kotlin.vim in udalov/kotlin-vim
autocmd BufNewFile,BufRead *.kt setfiletype kotlin
autocmd BufNewFile,BufRead *.kts setfiletype kotlin
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'less') == -1
  augroup filetypedetect
  " less, from less.vim in groenewege/vim-less:_NOAFTER
autocmd BufNewFile,BufRead *.less setf less
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'lilypond') == -1
  augroup filetypedetect
  " lilypond, from lilypond.vim in anowlcalledjosh/vim-lilypond
"
" Installed As:	vim/ftdetect/lilypond.vim
"
au! BufNewFile,BufRead *.ly,*.ily		set ft=lilypond
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'livescript') == -1
  augroup filetypedetect
  " livescript, from ls.vim in gkz/vim-ls
" Language:    LiveScript
" Maintainer:  George Zahariev
" URL:         http://github.com/gkz/vim-ls
" License:     WTFPL
"
autocmd BufNewFile,BufRead *.ls set filetype=ls
autocmd BufNewFile,BufRead *Slakefile set filetype=ls
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'llvm') == -1
  augroup filetypedetect
  " llvm, from llvm-lit.vim in rhysd/vim-llvm
au BufRead,BufNewFile lit.*cfg set filetype=python
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'llvm') == -1
  augroup filetypedetect
  " llvm, from llvm.vim in rhysd/vim-llvm
au BufRead,BufNewFile *.ll set filetype=llvm
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'llvm') == -1
  augroup filetypedetect
  " llvm, from tablegen.vim in rhysd/vim-llvm
au BufRead,BufNewFile *.td set filetype=tablegen
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'log') == -1
  augroup filetypedetect
  " log, from log.vim in MTDL9/vim-log-highlighting

au BufNewFile,BufRead *.log set filetype=log
au BufNewFile,BufRead *_log set filetype=log
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mako') == -1
  augroup filetypedetect
  " mako, from mako.vim in sophacles/vim-bundle-mako
if !exists("g:mako_detect_lang_from_ext")
  let g:mako_detect_lang_from_ext = 1
endif
if g:mako_detect_lang_from_ext
  au BufNewFile *.*.mako   execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  " it's important to get this before any of the normal BufRead autocmds execute
  " for this file, otherwise a mako tag at the start of the file can cause the
  " filetype to be set to mason
  au BufReadPre *.*.mako   execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
endif
au BufRead,BufNewFile *.mako     set filetype=mako
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'markdown') == -1
  augroup filetypedetect
  " markdown, from markdown.vim in plasticboy/vim-markdown:_SYNTAX
if !has('patch-7.4.480')
    " Before this patch, vim used modula2 for .md.
    au! filetypedetect BufRead,BufNewFile *.md
endif

" markdown filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} setfiletype markdown
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} setfiletype markdown
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mathematica') == -1
  augroup filetypedetect
  " mathematica, from mma.vim in voldikss/vim-mma
autocmd BufNewFile,BufRead *.wl set filetype=mma
autocmd BufNewFile,BufRead *.wls set filetype=mma
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mdx') == -1
  augroup filetypedetect
  " mdx, from mdx.vim in jxnblk/vim-mdx-js
" Vim ftdetect file
"
" Language: MDX
" Maintainer: Brent Jackson <jxnblk@gmail.com>
"

autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'meson') == -1
  augroup filetypedetect
  " meson, from meson.vim in mesonbuild/meson:_ALL:/data/syntax-highlighting/vim/
au BufNewFile,BufRead meson.build set filetype=meson
au BufNewFile,BufRead meson_options.txt set filetype=meson
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'moonscript') == -1
  augroup filetypedetect
  " moonscript, from moon.vim in leafo/moonscript-vim
" Language:    MoonScript
" Maintainer:  leafo <leafot@gmail.com>
" Based On:    CoffeeScript by Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/leafo/moonscript-vim
" License:     WTFPL

autocmd BufNewFile,BufRead *.moon set filetype=moon

function! s:DetectMoon()
    if getline(1) =~ '^#!.*\<moon\>'
        set filetype=moon
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectMoon()
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  augroup filetypedetect
  " nginx, from nginx.vim in chr4/nginx.vim
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile nginx*.conf set ft=nginx
au BufRead,BufNewFile *nginx.conf set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile */nginx/*.conf set ft=nginx
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nim') == -1
  augroup filetypedetect
  " nim, from nim.vim in zah/nim.vim:_BASIC
au BufNewFile,BufRead *.nim,*.nims,*.nimble set filetype=nim
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1
  augroup filetypedetect
  " nix, from nix.vim in LnL7/vim-nix
" Vim filetype detect
" Language:    Nix
" Maintainer:  Daiderd Jordan <daiderd@gmail.com>
" URL:         https://github.com/LnL7/vim-nix

au BufRead,BufNewFile *.nix set filetype=nix
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1
  augroup filetypedetect
  " ocaml, from dune.vim in rgrinberg/vim-ocaml
au BufRead,BufNewFile jbuild,dune,dune-project set ft=dune
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1
  augroup filetypedetect
  " ocaml, from oasis.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead _oasis set filetype=oasis
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1
  augroup filetypedetect
  " ocaml, from ocaml.vim in rgrinberg/vim-ocaml
au BufRead,BufNewFile *.ml,*.mli,*.mll,*.mly,.ocamlinit,*.mlt,*.mlp,*.mlip,*.mli.cppo,*.ml.cppo set ft=ocaml
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1
  augroup filetypedetect
  " ocaml, from ocamlbuild_tags.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead _tags set filetype=ocamlbuild_tags
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1
  augroup filetypedetect
  " ocaml, from omake.vim in rgrinberg/vim-ocaml
au! BufRead,BufNewFile OMakefile,OMakeroot,*.om,OMakeroot.in set ft=omake
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1
  augroup filetypedetect
  " ocaml, from opam.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead opam,*.opam set filetype=opam
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ocaml') == -1
  augroup filetypedetect
  " ocaml, from sexplib.vim in rgrinberg/vim-ocaml
au BufRead,BufNewFile *.sexp set ft=sexplib
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'opencl') == -1
  augroup filetypedetect
  " opencl, from opencl.vim in petRUShka/vim-opencl
au! BufRead,BufNewFile *.cl set filetype=opencl
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1
  augroup filetypedetect
  " perl, from mason-in-html.vim in vim-perl/vim-perl
" Highlight .html files as Mason if they start with Mason tags
autocmd BufRead *.html
    \ if getline(1) =~ '^\(%\|<[%&].*>\)' |
    \     set filetype=mason |
    \ endif
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1
  augroup filetypedetect
  " perl, from perl11.vim in vim-perl/vim-perl
function! s:DetectPerl6()
  let line_no = 1
  let eof     = line('$')
  let in_pod  = 0

  while line_no <= eof
    let line    = getline(line_no)
    let line_no = line_no + 1

    if line =~ '^=\w'
      let in_pod = 1
    elseif line =~ '^=\%(end\|cut\)'
      let in_pod = 0
    elseif !in_pod
      let line = substitute(line, '#.*', '', '')

      if line =~ '^\s*$'
        continue
      endif

      if line =~ '^\s*\%(use\s\+\)\=v6\%(\.\d\%(\.\d\)\=\)\=;'
        set filetype=perl6 " we matched a 'use v6' declaration
      elseif line =~ '^\s*\%(\%(my\|our\)\s\+\)\=\%(unit\s\+\)\=\(module\|class\|role\|enum\|grammar\)'
        set filetype=perl6 " we found a class, role, module, enum, or grammar declaration
      endif

      break " we either found what we needed, or we found a non-POD, non-comment,
            " non-Perl 6 indicating line, so bail out
    endif
  endwhile
endfunction

autocmd BufReadPost *.pl,*.pm,*.t call s:DetectPerl6()
autocmd BufNew,BufNewFile,BufRead *.nqp setf perl6
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pgsql') == -1
  augroup filetypedetect
  " pgsql, from pgsql.vim in lifepillar/pgsql.vim
au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | setfiletype sql
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pony') == -1
  augroup filetypedetect
  " pony, from pony.vim in jakwings/vim-pony
autocmd BufRead,BufNewFile *.pony setf pony
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  augroup filetypedetect
  " powershell, from ps1.vim in PProvost/vim-ps1
" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327
"
au BufNewFile,BufRead   *.ps1   set ft=ps1
au BufNewFile,BufRead   *.psd1  set ft=ps1
au BufNewFile,BufRead   *.psm1  set ft=ps1
au BufNewFile,BufRead   *.pssc  set ft=ps1
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  augroup filetypedetect
  " powershell, from ps1xml.vim in PProvost/vim-ps1
" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327

au BufNewFile,BufRead   *.ps1xml   set ft=ps1xml
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  augroup filetypedetect
  " powershell, from xml.vim in PProvost/vim-ps1
" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327

au BufNewFile,BufRead   *.cdxml    set ft=xml
au BufNewFile,BufRead   *.psc1     set ft=xml
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'protobuf') == -1
  augroup filetypedetect
  " protobuf, from proto.vim in uarun/vim-protobuf
autocmd BufNewFile,BufRead *.proto setfiletype proto
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pug') == -1
  augroup filetypedetect
  " pug, from pug.vim in digitaltoad/vim-pug
" Pug
autocmd BufNewFile,BufReadPost *.pug set filetype=pug

" Jade
autocmd BufNewFile,BufReadPost *.jade set filetype=pug
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1
  augroup filetypedetect
  " puppet, from puppet.vim in rodjek/vim-puppet
au! BufRead,BufNewFile *.pp setfiletype puppet
au! BufRead,BufNewFile *.epp setfiletype embeddedpuppet
au! BufRead,BufNewFile Puppetfile setfiletype ruby
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'purescript') == -1
  augroup filetypedetect
  " purescript, from purescript.vim in purescript-contrib/purescript-vim
au BufNewFile,BufRead *.purs setf purescript
au FileType purescript let &l:commentstring='{--%s--}'
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'python-compiler') == -1
  augroup filetypedetect
  " python-compiler, from python.vim in aliev/vim-compiler-python
" Vim compiler file
" Compiler:	Unit testing tool for Python
" Maintainer:	Ali Aliev <ali@aliev.me>
" Last Change: 2015 Nov 2

autocmd FileType python compiler python
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qmake') == -1
  augroup filetypedetect
  " qmake, from pri.vim in artoj/qmake-syntax-vim
au BufRead,BufNewFile *.pri set filetype=qmake
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qmake') == -1
  augroup filetypedetect
  " qmake, from pro.vim in artoj/qmake-syntax-vim
au BufRead,BufNewFile *.pro set filetype=qmake
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qml') == -1
  augroup filetypedetect
  " qml, from qml.vim in peterhoeg/vim-qml
autocmd BufRead,BufNewFile *.qml setfiletype qml
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'racket') == -1
  augroup filetypedetect
  " racket, from racket.vim in wlangstroth/vim-racket
au BufRead,BufNewFile *.rkt,*.rktl set filetype=racket
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'raml') == -1
  augroup filetypedetect
  " raml, from raml.vim in IN3D/vim-raml
au BufRead,BufNewFile *.raml set ft=raml
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'reason') == -1
  augroup filetypedetect
  " reason, from reason.vim in reasonml-editor/vim-reason-plus
" Copyright (c) 2015-present, Facebook, Inc. All rights reserved.

au BufRead,BufNewFile *.re set filetype=reason
au BufRead,BufNewFile *.rei set filetype=reason
au BufNewFile,BufRead .merlin       set ft=merlin
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ruby') == -1
  augroup filetypedetect
  " ruby, from ruby.vim in vim-ruby/vim-ruby
" Officially distributed filetypes

" Support functions {{{
function! s:setf(filetype) abort
  if &filetype !~# '\<'.a:filetype.'\>'
    let &filetype = a:filetype
  endif
endfunction

func! s:StarSetf(ft)
  if expand("<amatch>") !~ g:ft_ignore_pat
    exe 'setf ' . a:ft
  endif
endfunc
" }}}

" HTML with Ruby - eRuby
au BufNewFile,BufRead *.erb,*.rhtml				call s:setf('eruby')

" Interactive Ruby shell
au BufNewFile,BufRead .irbrc,irbrc				call s:setf('ruby')

" Ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gemspec			call s:setf('ruby')

" Rackup
au BufNewFile,BufRead *.ru					call s:setf('ruby')

" Bundler
au BufNewFile,BufRead Gemfile					call s:setf('ruby')

" Ruby on Rails
au BufNewFile,BufRead *.builder,*.rxml,*.rjs,*.ruby		call s:setf('ruby')

" Rakefile
au BufNewFile,BufRead [rR]akefile,*.rake			call s:setf('ruby')
au BufNewFile,BufRead [rR]akefile*				call s:StarSetf('ruby')

" Rantfile
au BufNewFile,BufRead [rR]antfile,*.rant			call s:setf('ruby')

" vim: nowrap sw=2 sts=2 ts=8 noet fdm=marker:
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ruby') == -1
  augroup filetypedetect
  " ruby, from ruby_extra.vim in vim-ruby/vim-ruby
" All other filetypes

" Support functions {{{
function! s:setf(filetype) abort
  if &filetype !=# a:filetype
    let &filetype = a:filetype
  endif
endfunction
" }}}

" Appraisal
au BufNewFile,BufRead Appraisals		call s:setf('ruby')

" Autotest
au BufNewFile,BufRead .autotest			call s:setf('ruby')

" Axlsx
au BufNewFile,BufRead *.axlsx			call s:setf('ruby')

" Buildr Buildfile
au BufNewFile,BufRead [Bb]uildfile		call s:setf('ruby')

" Capistrano
au BufNewFile,BufRead Capfile,*.cap		call s:setf('ruby')

" Chef
au BufNewFile,BufRead Cheffile			call s:setf('ruby')
au BufNewFile,BufRead Berksfile			call s:setf('ruby')

" CocoaPods
au BufNewFile,BufRead Podfile,*.podspec		call s:setf('ruby')

" Guard
au BufNewFile,BufRead Guardfile,.Guardfile	call s:setf('ruby')

" Jbuilder
au BufNewFile,BufRead *.jbuilder		call s:setf('ruby')

" Kitchen Sink
au BufNewFile,BufRead KitchenSink		call s:setf('ruby')

" Opal
au BufNewFile,BufRead *.opal			call s:setf('ruby')

" Pry config
au BufNewFile,BufRead .pryrc			call s:setf('ruby')

" Puppet librarian
au BufNewFile,BufRead Puppetfile		call s:setf('ruby')

" Rabl
au BufNewFile,BufRead *.rabl			call s:setf('ruby')

" Routefile
au BufNewFile,BufRead [rR]outefile		call s:setf('ruby')

" SimpleCov
au BufNewFile,BufRead .simplecov		call s:setf('ruby')

" Thor
au BufNewFile,BufRead [tT]horfile,*.thor	call s:setf('ruby')

" Vagrant
au BufNewFile,BufRead [vV]agrantfile		call s:setf('ruby')

" vim: nowrap sw=2 sts=2 ts=8 noet fdm=marker:
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rust') == -1
  augroup filetypedetect
  " rust, from rust.vim in rust-lang/rust.vim
" vint: -ProhibitAutocmdWithNoGroup

autocmd BufRead,BufNewFile *.rs call s:set_rust_filetype()

if has('patch-8.0.613')
    autocmd BufRead,BufNewFile Cargo.toml setf FALLBACK cfg
endif

function! s:set_rust_filetype() abort
    if &filetype !=# 'rust'
        set filetype=rust
    endif
endfunction

" vim: set et sw=4 sts=4 ts=8:
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'sbt') == -1
  augroup filetypedetect
  " sbt, from sbt.vim in derekwyatt/vim-sbt
" Vim detect file
" Language:     sbt
" Maintainer:   Derek Wyatt <derek@{myfirstname}{mylastname}.org>
" Last Change:  2012 Jan 19

au BufRead,BufNewFile *.sbt set filetype=sbt.scala
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scss') == -1
  augroup filetypedetect
  " scss, from scss.vim in cakebaker/scss-syntax.vim
au BufRead,BufNewFile *.scss setfiletype scss
au BufEnter *.scss :syntax sync fromstart
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'slim') == -1
  augroup filetypedetect
  " slim, from slim.vim in slim-template/vim-slim
autocmd BufNewFile,BufRead *.slim setfiletype slim
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'slime') == -1
  augroup filetypedetect
  " slime, from slime.vim in slime-lang/vim-slime-syntax
autocmd BufNewFile,BufRead *.slime set filetype=slime
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'smt2') == -1
  augroup filetypedetect
  " smt2, from smt2.vim in bohlender/vim-smt2
autocmd BufRead,BufNewFile *.smt,*.smt2 set filetype=smt2
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'solidity') == -1
  augroup filetypedetect
  " solidity, from solidity.vim in tomlion/vim-solidity
au BufNewFile,BufRead *.sol setf solidity
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'stylus') == -1
  augroup filetypedetect
  " stylus, from stylus.vim in wavded/vim-stylus
" Stylus
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus
autocmd BufNewFile,BufReadPost *.stylus set filetype=stylus
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'svelte') == -1
  augroup filetypedetect
  " svelte, from svelte.vim in evanleck/vim-svelte
au BufRead,BufNewFile *.svelte setfiletype svelte
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'sxhkd') == -1
  augroup filetypedetect
  " sxhkd, from sxhkdrc.vim in baskerville/vim-sxhkdrc
if &compatible || v:version < 603
    finish
endif

autocmd BufNewFile,BufRead sxhkdrc,*.sxhkdrc set ft=sxhkdrc
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'systemd') == -1
  augroup filetypedetect
  " systemd, from systemd.vim in wgwoods/vim-systemd-syntax
au BufNewFile,BufRead *.automount set filetype=systemd
au BufNewFile,BufRead *.mount     set filetype=systemd
au BufNewFile,BufRead *.path      set filetype=systemd
au BufNewFile,BufRead *.service   set filetype=systemd
au BufNewFile,BufRead *.socket    set filetype=systemd
au BufNewFile,BufRead *.swap      set filetype=systemd
au BufNewFile,BufRead *.target    set filetype=systemd
au BufNewFile,BufRead *.timer     set filetype=systemd
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'terraform') == -1
  augroup filetypedetect
  " terraform, from terraform.vim in hashivim/vim-terraform
" By default, Vim associates .tf files with TinyFugue - tell it not to.
autocmd! filetypedetect BufRead,BufNewFile *.tf
autocmd BufRead,BufNewFile *.tf set filetype=terraform
autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
autocmd BufRead,BufNewFile *.tfstate set filetype=json
autocmd BufRead,BufNewFile *.tfstate.backup set filetype=json
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'textile') == -1
  augroup filetypedetect
  " textile, from textile.vim in timcharper/textile.vim
" textile.vim
"
" Tim Harper (tim.theenchanter.com)

" Force filetype to be textile even if already set
" This will override the system ftplugin/changelog 
" set on some distros
au BufRead,BufNewFile *.textile set filetype=textile
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'thrift') == -1
  augroup filetypedetect
  " thrift, from thrift.vim in solarnz/thrift.vim
au BufNewFile,BufRead *.thrift setlocal filetype=thrift
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tmux') == -1
  augroup filetypedetect
  " tmux, from tmux.vim in ericpruitt/tmux.vim:_ALL:/vim/
" Language: tmux(1) configuration file
" URL: https://github.com/ericpruitt/tmux.vim/
" Maintainer: Eric Pruitt <eric.pruitt@gmail.com>
" Last Changed: 2017 Mar 10

autocmd BufNewFile,BufRead {.,}tmux.conf setfiletype tmux
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'toml') == -1
  augroup filetypedetect
  " toml, from toml.vim in cespare/vim-toml
" Go dep and Rust use several TOML config files that are not named with .toml.
autocmd BufNewFile,BufRead *.toml,Gopkg.lock,Cargo.lock,*/.cargo/config,*/.cargo/credentials,Pipfile setf toml
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tptp') == -1
  augroup filetypedetect
  " tptp, from tptp.vim in c-cube/vim-tptp

au BufRead,BufNewFile *.p set filetype=tptp
au BufRead,BufNewFile *.p set syntax=tptp
au BufRead,BufNewFile *.tptp set filetype=tptp
au BufRead,BufNewFile *.tptp set syntax=tptp
au BufRead,BufNewFile *.ax set filetype=tptp
au BufRead,BufNewFile *.ax set syntax=tptp
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'twig') == -1
  augroup filetypedetect
  " twig, from twig.vim in lumiliet/vim-twig

if !exists('g:vim_twig_filetype_detected') && has("autocmd")
  au BufNewFile,BufRead *.twig set filetype=html.twig
  au BufNewFile,BufRead *.html.twig set filetype=html.twig
  au BufNewFile,BufRead *.xml.twig set filetype=xml.twig
endif
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1
  augroup filetypedetect
  " typescript, from tsx.vim in HerringtonDarkholme/yats.vim
autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1
  augroup filetypedetect
  " typescript, from typescript.vim in HerringtonDarkholme/yats.vim
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vala') == -1
  augroup filetypedetect
  " vala, from vala.vim in arrufat/vala.vim
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi,*.valadoc setfiletype vala
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vcl') == -1
  augroup filetypedetect
  " vcl, from vcl.vim in smerrill/vcl-vim-plugin
au BufRead,BufNewFile *.vcl set filetype=vcl
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1
  augroup filetypedetect
  " vifm, from vifm-rename.vim in vifm/vifm.vim
autocmd BufRead,BufNewFile vifm.rename* :set filetype=vifm-rename
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vifm') == -1
  augroup filetypedetect
  " vifm, from vifm.vim in vifm/vifm.vim
autocmd BufRead,BufNewFile vifmrc :set filetype=vifm
autocmd BufRead,BufNewFile *vifm/colors/* :set filetype=vifm
autocmd BufRead,BufNewFile *.vifm :set filetype=vifm
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vm') == -1
  augroup filetypedetect
  " vm, from velocity.vim in lepture/vim-velocity
au BufRead,BufNewFile *.vm set ft=velocity syntax=velocity
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1
  augroup filetypedetect
  " vue, from vue.vim in posva/vim-vue
au BufNewFile,BufRead *.vue,*.wpy setf vue
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'xdc') == -1
  augroup filetypedetect
  " xdc, from xdc.vim in amal-khailtash/vim-xdc-syntax
" xdc
autocmd BufNewFile,BufRead *.xdc setfiletype xdc
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'zephir') == -1
  augroup filetypedetect
  " zephir, from zephir.vim in xwsoul/vim-zephir
autocmd BufNewFile,BufReadPost *.zep set filetype=zephir
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'zig') == -1
  augroup filetypedetect
  " zig, from zig.vim in ziglang/zig.vim
au BufRead,BufNewFile *.zig set filetype=zig
  augroup end
endif

