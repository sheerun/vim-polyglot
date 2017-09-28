" Enable jsx syntax by default
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 0
endif

" Disable json concealing by default
if !exists('g:vim_json_syntax_conceal')
  let g:vim_json_syntax_conceal = 0
endif

let g:filetype_euphoria = 'elixir'
augroup filetypedetect
" apiblueprint:sheerun/apiblueprint.vim
autocmd BufReadPost,BufNewFile *.apib set filetype=apiblueprint
autocmd FileType apiblueprint set syntax=apiblueprint
autocmd FileType apiblueprint set makeprg=drafter\ -l\ %
augroup END

augroup filetypedetect
" applescript:vim-scripts/applescript.vim
augroup END

augroup filetypedetect
" asciidoc:asciidoc/vim-asciidoc
autocmd BufNewFile,BufRead *.asciidoc,*.adoc
	\ set ft=asciidoc
augroup END

augroup filetypedetect
" yaml:stephpy/vim-yaml
augroup END

augroup filetypedetect
" ansible:pearofducks/ansible-vim
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

:au BufNewFile,BufRead * if s:isAnsible() | set ft=ansible | en
:au BufNewFile,BufRead *.j2 set ft=ansible_template
:au BufNewFile,BufRead hosts set ft=ansible_hosts
augroup END

augroup filetypedetect
" arduino:sudar/vim-arduino-syntax
au BufRead,BufNewFile *.ino,*.pde set filetype=arduino
augroup END

augroup filetypedetect
" autohotkey:hnamikaw/vim-autohotkey
augroup END

augroup filetypedetect
" blade:jwalton512/vim-blade
autocmd BufNewFile,BufRead *.blade.php set filetype=blade
augroup END

augroup filetypedetect
" c++11:octol/vim-cpp-enhanced-highlight
augroup END

augroup filetypedetect
" c/c++:vim-jp/vim-cpp
augroup END

augroup filetypedetect
" caddyfile:isobit/vim-caddyfile
au BufNewFile,BufRead Caddyfile set ft=caddyfile
augroup END

augroup filetypedetect
" cjsx:mtscout6/vim-cjsx
augroup CJSX
  au!
  autocmd BufNewFile,BufRead *.csx,*.cjsx set filetype=coffee
augroup END
augroup END

augroup filetypedetect
" clojure:guns/vim-clojure-static
autocmd BufNewFile,BufRead *.clj,*.cljs,*.edn,*.cljx,*.cljc,{build,profile}.boot setlocal filetype=clojure
augroup END

augroup filetypedetect
" coffee-script:kchmck/vim-coffee-script
" Language:    CoffeeScript
" Maintainer:  Mick Koch <mick@kochm.co>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
autocmd BufNewFile,BufRead *._coffee set filetype=coffee

function! s:DetectCoffee()
    if getline(1) =~ '^#!.*\<coffee\>'
        set filetype=coffee
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectCoffee()
augroup END

augroup filetypedetect
" coffee-script:kchmck/vim-coffee-script
" Language:   Literate CoffeeScript
" Maintainer: Michael Smith <michael@diglumi.com>
" URL:        https://github.com/mintplant/vim-literate-coffeescript
" License:    MIT

autocmd BufNewFile,BufRead *.litcoffee set filetype=litcoffee
autocmd BufNewFile,BufRead *.coffee.md set filetype=litcoffee

augroup END

augroup filetypedetect
" cryptol:victoredwardocallaghan/cryptol.vim
" Copyright © 2013 Edward O'Callaghan. All Rights Reserved.
"  Normal Cryptol Program;
au! BufRead,BufNewFile *.cry set filetype=cryptol
au! BufRead,BufNewFile *.cyl set filetype=cryptol
"  Literate Cryptol Program;
au! BufRead,BufNewFile *.lcry set filetype=cryptol
au! BufRead,BufNewFile *.lcyl set filetype=cryptol
" Also in LaTeX *.tex which is outside our coverage scope.
augroup END

augroup filetypedetect
" crystal:rhysd/vim-crystal
autocmd BufNewFile,BufReadPost *.cr setlocal filetype=crystal
autocmd BufNewFile,BufReadPost Projectfile setlocal filetype=crystal
autocmd BufNewFile,BufReadPost *.ecr setlocal filetype=eruby
augroup END

augroup filetypedetect
" cql:elubow/cql-vim
if has("autocmd")
  au  BufNewFile,BufRead *.cql set filetype=cql
endif
augroup END

augroup filetypedetect
" cucumber:tpope/vim-cucumber
" Cucumber
autocmd BufNewFile,BufReadPost *.feature,*.story set filetype=cucumber
augroup END

augroup filetypedetect
" dart:dart-lang/dart-vim-plugin
autocmd BufRead,BufNewFile *.dart set filetype=dart
augroup END

augroup filetypedetect
" dockerfile:docker/docker::/contrib/syntax/vim/
augroup END

augroup filetypedetect
" elixir:elixir-lang/vim-elixir
au BufRead,BufNewFile *.ex,*.exs call s:setf('elixir')
au BufRead,BufNewFile *.eex call s:setf('eelixir')
au BufRead,BufNewFile * call s:DetectElixir()

function! s:setf(filetype) abort
  let &filetype = a:filetype
endfunction

function! s:DetectElixir()
  if getline(1) =~ '^#!.*\<elixir\>'
    call s:setf('elixir')
  endif
endfunction
augroup END

augroup filetypedetect
" elm:ElmCast/elm-vim
" detection for Elm (http://elm-lang.org/)

au BufRead,BufNewFile *.elm set filetype=elm
augroup END

augroup filetypedetect
" emberscript:yalesov/vim-ember-script
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
augroup END

augroup filetypedetect
" emblem:yalesov/vim-emblem
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
augroup END

augroup filetypedetect
" erlang:vim-erlang/vim-erlang-runtime
au BufNewFile,BufRead *.erl,*.hrl,rebar.config,*.app,*.app.src,*.yaws,*.xrl set ft=erlang
augroup END

augroup filetypedetect
" fish:dag/vim-fish
autocmd BufRead,BufNewFile *.fish setfiletype fish

" Detect fish scripts by the shebang line.
autocmd BufRead *
            \ if getline(1) =~# '\v^#!%(\f*/|/usr/bin/env\s*<)fish>' |
            \     setlocal filetype=fish |
            \ endif

" Move cursor to first empty line when using funced.
autocmd BufRead fish_funced_*_*.fish call search('^$')

" Fish histories are YAML documents.
autocmd BufRead,BufNewFile ~/.config/fish/fish_{read_,}history setfiletype yaml

" Universal variable storages should not be hand edited.
autocmd BufRead,BufNewFile ~/.config/fish/fishd.* setlocal readonly

" Mimic `funced` when manually creating functions.
autocmd BufNewFile ~/.config/fish/functions/*.fish
            \ call append(0, ['function '.expand('%:t:r'),
                             \'',
                             \'end']) |
            \ 2
augroup END

augroup filetypedetect
" fsharp:fsharp/vim-fsharp:_BASIC
" F#, fsharp
autocmd BufNewFile,BufRead *.fs,*.fsi,*.fsx set filetype=fsharp
augroup END

augroup filetypedetect
" git:tpope/vim-git
" Git
autocmd BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
autocmd BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
autocmd BufNewFile,BufRead */.config/git/config                          set ft=gitconfig
autocmd BufNewFile,BufRead *.git/modules/**/config                       set ft=gitconfig
autocmd BufNewFile,BufRead git-rebase-todo                               set ft=gitrebase
autocmd BufNewFile,BufRead .gitsendemail.*                               set ft=gitsendemail
autocmd BufNewFile,BufRead *.git/**
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   set ft=git |
      \ endif

" This logic really belongs in scripts.vim
autocmd BufNewFile,BufRead,StdinReadPost *
      \ if getline(1) =~ '^\(commit\|tree\|object\) \x\{40\}\>\|^tag \S\+$' |
      \   set ft=git |
      \ endif
autocmd BufNewFile,BufRead *
      \ if getline(1) =~ '^From \x\{40\} Mon Sep 17 00:00:00 2001$' |
      \   set filetype=gitsendemail |
      \ endif
augroup END

augroup filetypedetect
" gmpl:maelvalais/gmpl.vim
au BufRead,BufNewFile *.mod set filetype=gmpl
augroup END

augroup filetypedetect
" openscad:sirtaj/vim-openscad
au BufRead,BufNewFile *.scad    setfiletype openscad
an 50.80.265 &Syntax.NO.OpenSCAD :cal SetSyn("openscad")<CR>
augroup END

augroup filetypedetect
" glsl:tikhomirov/vim-glsl
" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

" Extensions supported by Khronos reference compiler (with one exception, ".glsl")
" https://github.com/KhronosGroup/glslang
autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set filetype=glsl

" vim:set sts=2 sw=2 :
augroup END

augroup filetypedetect
" gnuplot:vim-scripts/gnuplot-syntax-highlighting
augroup END

augroup filetypedetect
" go:fatih/vim-go:_BASIC
" We take care to preserve the user's fileencodings and fileformats,
" because those settings are global (not buffer local), yet we want
" to override them for loading Go files, which are defined to be UTF-8.
let s:current_fileformats = ''
let s:current_fileencodings = ''

" define fileencodings to open as utf-8 encoding even if it's ascii.
function! s:gofiletype_pre(type)
  let s:current_fileformats = &g:fileformats
  let s:current_fileencodings = &g:fileencodings
  set fileencodings=utf-8 fileformats=unix
  let &l:filetype = a:type
endfunction

" restore fileencodings as others
function! s:gofiletype_post()
  let &g:fileformats = s:current_fileformats
  let &g:fileencodings = s:current_fileencodings
endfunction

au BufNewFile *.go setfiletype go | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.go call s:gofiletype_pre("go")
au BufReadPost *.go call s:gofiletype_post()

au BufNewFile *.s setfiletype asm | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.s call s:gofiletype_pre("asm")
au BufReadPost *.s call s:gofiletype_post()

au BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl

" vim: sw=2 ts=2 et
augroup END

augroup filetypedetect
" groovy:vim-scripts/groovy.vim
augroup END

augroup filetypedetect
" haml:sheerun/vim-haml
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss
augroup END

augroup filetypedetect
" handlebars:mustache/vim-mustache-handlebars
if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  au  BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
augroup END

augroup filetypedetect
" haskell:neovimhaskell/haskell-vim
au BufRead,BufNewFile *.hsc set filetype=haskell
au BufRead,BufNewFile *.bpk set filetype=haskell
au BufRead,BufNewFile *.hsig set filetype=haskell
augroup END

augroup filetypedetect
" haxe:yaymukund/vim-haxe
autocmd BufNewFile,BufRead *.hx setf haxe
augroup END

augroup filetypedetect
" html5:othree/html5.vim
augroup END

augroup filetypedetect
" i3:PotatoesMaster/i3-vim-syntax
augroup i3_ftdetect
  au!
  au BufRead,BufNewFile *i3/config set ft=i3
augroup END
augroup END

augroup filetypedetect
" jasmine:glanotte/vim-jasmine
autocmd BufNewFile,BufRead *Spec.js,*_spec.js set filetype=jasmine.javascript syntax=jasmine
augroup END

augroup filetypedetect
" javascript:pangloss/vim-javascript:_JAVASCRIPT
au BufNewFile,BufRead *.{js,mjs,jsm,es,es6},Jakefile setf javascript

fun! s:SourceFlowSyntax()
  if !exists('javascript_plugin_flow') && !exists('b:flow_active') &&
        \ search('\v\C%^\_s*%(//\s*|/\*[ \t\n*]*)\@flow>','nw')
    runtime extras/flow.vim
    let b:flow_active = 1
  endif
endfun
au FileType javascript au BufRead,BufWritePost <buffer> call s:SourceFlowSyntax()

fun! s:SelectJavascript()
  if getline(1) =~# '^#!.*/bin/\%(env\s\+\)\?node\>'
    set ft=javascript
  endif
endfun
au BufNewFile,BufRead * call s:SelectJavascript()
augroup END

augroup filetypedetect
" jenkins:martinda/Jenkinsfile-vim-syntax
" Jenkinsfile
autocmd BufRead,BufNewFile Jenkinsfile set ft=Jenkinsfile
autocmd BufRead,BufNewFile Jenkinsfile* setf Jenkinsfile
autocmd BufRead,BufNewFile *.jenkinsfile set ft=Jenkinsfile
autocmd BufRead,BufNewFile *.jenkinsfile setf Jenkinsfile
augroup END

augroup filetypedetect
" json:elzr/vim-json
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonp setlocal filetype=json
autocmd BufNewFile,BufRead *.geojson setlocal filetype=json
augroup END

augroup filetypedetect
" jst:briancollins/vim-jst
au BufNewFile,BufRead *.ejs set filetype=jst
au BufNewFile,BufRead *.jst set filetype=jst
au BufNewFile,BufRead *.djs set filetype=jst
au BufNewFile,BufRead *.hamljs set filetype=jst
au BufNewFile,BufRead *.ect set filetype=jst
augroup END

augroup filetypedetect
" jsx:mxw/vim-jsx:_ALL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftdetect file
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Whether the .jsx extension is required.
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 1
endif

" Whether the @jsx pragma is required.
if !exists('g:jsx_pragma_required')
  let g:jsx_pragma_required = 0
endif

let s:jsx_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@jsx\_.\{-}\*\/'

" Whether to set the JSX filetype on *.js files.
fu! <SID>EnableJSX()
  if g:jsx_pragma_required && !exists('b:jsx_ext_found')
    " Look for the @jsx pragma.  It must be included in a docblock comment
    " before anything else in the file (except whitespace).
    let b:jsx_pragma_found = search(s:jsx_pragma_pattern, 'npw')
  endif

  if g:jsx_pragma_required && !b:jsx_pragma_found | return 0 | endif
  if g:jsx_ext_required && !exists('b:jsx_ext_found') | return 0 | endif
  return 1
endfu

autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.js
  \ if <SID>EnableJSX() | set filetype=javascript.jsx | endif
augroup END

augroup filetypedetect
" julia:dcjones/julia-minimalist-vim
" NOTE: this line fixes an issue with the default system-wide lisp ftplugin
"       which doesn't define b:undo_ftplugin
"       (*.jt files are recognized as lisp)
au BufRead,BufNewFile *.jl		let b:undo_ftplugin = "setlocal comments< define< formatoptions< iskeyword< lisp<"

au BufRead,BufNewFile *.jl		set filetype=julia
augroup END

augroup filetypedetect
" kotlin:udalov/kotlin-vim
autocmd BufNewFile,BufRead *.kt setfiletype kotlin
autocmd BufNewFile,BufRead *.kts setfiletype kotlin
augroup END

augroup filetypedetect
" latex:LaTeX-Box-Team/LaTeX-Box
augroup END

augroup filetypedetect
" less:groenewege/vim-less
autocmd BufNewFile,BufRead *.less setf less
augroup END

augroup filetypedetect
" liquid:tpope/vim-liquid
" Liquid
au BufNewFile,BufRead *.liquid					set ft=liquid

au BufNewFile,BufRead */_layouts/*.html,*/_includes/*.html	set ft=liquid
au BufNewFile,BufRead *.html,*.xml,*.textile
      \ if getline(1) == '---' | set ft=liquid | endif
au BufNewFile,BufRead *.markdown,*.mkd,*.mkdn,*.md
      \ if getline(1) == '---' |
      \   let b:liquid_subtype = 'markdown' |
      \   set ft=liquid |
      \ endif

" Set subtype for Shopify alternate templates
au BufNewFile,BufRead */templates/**.liquid,*/layout/**.liquid,*/snippets/**.liquid
      \ let b:liquid_subtype = 'html' |
      \ set ft=liquid |
augroup END

augroup filetypedetect
" livescript:gkz/vim-ls
" Language:    LiveScript
" Maintainer:  George Zahariev
" URL:         http://github.com/gkz/vim-ls
" License:     WTFPL
"
autocmd BufNewFile,BufRead *.ls set filetype=ls
autocmd BufNewFile,BufRead *Slakefile set filetype=ls
augroup END

augroup filetypedetect
" lua:tbastos/vim-lua
augroup END

augroup filetypedetect
" mako:sophacles/vim-bundle-mako
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
augroup END

augroup filetypedetect
" markdown:plasticboy/vim-markdown:_SYNTAX
" markdown filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} set filetype=markdown
augroup END

augroup filetypedetect
" mathematica:rsmenon/vim-mathematica
augroup END

augroup filetypedetect
" nginx:chr4/nginx.vim
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile nginx*.conf set ft=nginx
au BufRead,BufNewFile *nginx.conf set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
augroup END

augroup filetypedetect
" nim:zah/nim.vim:_BASIC
au BufNewFile,BufRead *.nim,*.nims set filetype=nim

augroup END

augroup filetypedetect
" nix:spwhitt/vim-nix
autocmd BufNewFile,BufRead *.nix setfiletype nix
augroup END

augroup filetypedetect
" objc:b4winckler/vim-objc
augroup END

augroup filetypedetect
" ocaml:jrk/vim-ocaml
augroup END

augroup filetypedetect
" octave:vim-scripts/octave.vim--
augroup END

augroup filetypedetect
" opencl:petRUShka/vim-opencl
au! BufRead,BufNewFile *.cl set filetype=opencl
augroup END

augroup filetypedetect
" perl:vim-perl/vim-perl
" Highlight .html files as Mason if they start with Mason tags
autocmd BufRead *.html
    \ if getline(1) =~ '^\(%\|<[%&].*>\)' |
    \     set filetype=mason |
    \ endif
augroup END

augroup filetypedetect
" perl:vim-perl/vim-perl
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
augroup END

augroup filetypedetect
" pgsql:exu/pgsql.vim
" postgreSQL
au BufNewFile,BufRead *.pgsql           setf pgsql
augroup END

augroup filetypedetect
" php:StanAngeloff/php.vim
augroup END

augroup filetypedetect
" plantuml:aklt/plantuml-syntax
if did_filetype()
  finish
endif

autocmd BufRead,BufNewFile * :if getline(1) =~ '^.*startuml.*$'| setfiletype plantuml | set filetype=plantuml | endif
autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml setfiletype plantuml | set filetype=plantuml
augroup END

augroup filetypedetect
" powershell:PProvost/vim-ps1
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
augroup END

augroup filetypedetect
" powershell:PProvost/vim-ps1
" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327

au BufNewFile,BufRead   *.ps1xml   set ft=ps1xml
augroup END

augroup filetypedetect
" powershell:PProvost/vim-ps1
" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327

au BufNewFile,BufRead   *.cdxml    set ft=xml
au BufNewFile,BufRead   *.psc1     set ft=xml
augroup END

augroup filetypedetect
" protobuf:uarun/vim-protobuf
autocmd BufNewFile,BufRead *.proto setfiletype proto
augroup END

augroup filetypedetect
" pug:digitaltoad/vim-pug
" Pug
autocmd BufNewFile,BufReadPost *.pug set filetype=pug

" Jade
autocmd BufNewFile,BufReadPost *.jade set filetype=pug
augroup END

augroup filetypedetect
" puppet:voxpupuli/vim-puppet
au! BufRead,BufNewFile *.pp setfiletype puppet
au! BufRead,BufNewFile Puppetfile setfiletype ruby
augroup END

augroup filetypedetect
" purescript:purescript-contrib/purescript-vim
au BufNewFile,BufRead *.purs setf purescript
au FileType purescript let &l:commentstring='{--%s--}'
augroup END

augroup filetypedetect
" python:mitsuhiko/vim-python-combined
augroup END

augroup filetypedetect
" python-compiler:aliev/vim-compiler-python
" Vim compiler file
" Compiler:	Unit testing tool for Python
" Maintainer:	Ali Aliev <ali@aliev.me>
" Last Change: 2015 Nov 2

autocmd FileType python compiler python
augroup END

augroup filetypedetect
" qml:peterhoeg/vim-qml
autocmd BufRead,BufNewFile *.qml setfiletype qml
augroup END

augroup filetypedetect
" r-lang:vim-scripts/R.vim
augroup END

augroup filetypedetect
" racket:wlangstroth/vim-racket
au BufRead,BufNewFile *.rkt,*.rktl  set filetype=racket
augroup END

augroup filetypedetect
" raml:IN3D/vim-raml
au BufRead,BufNewFile *.raml set ft=raml
augroup END

augroup filetypedetect
" ragel:jneen/ragel.vim
augroup END

augroup filetypedetect
" rspec:sheerun/rspec.vim
augroup END

augroup filetypedetect
" ruby:vim-ruby/vim-ruby
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
augroup END

augroup filetypedetect
" ruby:vim-ruby/vim-ruby
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
augroup END

augroup filetypedetect
" rust:rust-lang/rust.vim
au BufRead,BufNewFile *.rs set filetype=rust
augroup END

augroup filetypedetect
" sbt:derekwyatt/vim-sbt
" Vim detect file
" Language:     sbt
" Maintainer:   Derek Wyatt <derek@{myfirstname}{mylastname}.org>
" Last Change:  2012 Jan 19

au BufRead,BufNewFile *.sbt set filetype=sbt.scala
augroup END

augroup filetypedetect
" scala:derekwyatt/vim-scala
fun! s:DetectScala()
    if getline(1) =~# '^#!\(/usr\)\?/bin/env\s\+scalas\?'
        set filetype=scala
    endif
endfun

au BufRead,BufNewFile *.scala set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()

" Install vim-sbt for additional syntax highlighting.
au BufRead,BufNewFile *.sbt setfiletype sbt.scala
augroup END

augroup filetypedetect
" scss:cakebaker/scss-syntax.vim
au BufRead,BufNewFile *.scss setfiletype scss
au BufEnter *.scss :syntax sync fromstart
augroup END

augroup filetypedetect
" slim:slim-template/vim-slim
autocmd BufNewFile,BufRead *.slim setfiletype slim
augroup END

augroup filetypedetect
" solidity:tomlion/vim-solidity
au BufNewFile,BufRead *.sol setf solidity
augroup END

augroup filetypedetect
" stylus:wavded/vim-stylus
" Stylus
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus
autocmd BufNewFile,BufReadPost *.stylus set filetype=stylus
augroup END

augroup filetypedetect
" swift:keith/swift.vim
autocmd BufNewFile,BufRead *.swift set filetype=swift
autocmd BufRead * call s:Swift()
function! s:Swift()
  if !empty(&filetype)
    return
  endif

  let line = getline(1)
  if line =~ "^#!.*swift"
    setfiletype swift
  endif
endfunction
augroup END

augroup filetypedetect
" sxhkd:baskerville/vim-sxhkdrc
if &compatible || v:version < 603
    finish
endif

autocmd BufNewFile,BufRead sxhkdrc,*.sxhkdrc set ft=sxhkdrc
augroup END

augroup filetypedetect
" systemd:kurayama/systemd-vim-syntax
au BufNewFile,BufRead *.automount set filetype=systemd
au BufNewFile,BufRead *.mount     set filetype=systemd
au BufNewFile,BufRead *.path      set filetype=systemd
au BufNewFile,BufRead *.service   set filetype=systemd
au BufNewFile,BufRead *.socket    set filetype=systemd
au BufNewFile,BufRead *.swap      set filetype=systemd
au BufNewFile,BufRead *.target    set filetype=systemd
au BufNewFile,BufRead *.timer     set filetype=systemd
augroup END

augroup filetypedetect
" terraform:hashivim/vim-terraform
au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript
augroup END

augroup filetypedetect
" textile:timcharper/textile.vim
" textile.vim
"
" Tim Harper (tim.theenchanter.com)

" Force filetype to be textile even if already set
" This will override the system ftplugin/changelog 
" set on some distros
au BufRead,BufNewFile *.textile set filetype=textile
augroup END

augroup filetypedetect
" thrift:solarnz/thrift.vim
au BufNewFile,BufRead *.thrift setlocal filetype=thrift
augroup END

augroup filetypedetect
" tmux:keith/tmux.vim
autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux
augroup END

augroup filetypedetect
" tomdoc:wellbredgrapefruit/tomdoc.vim
augroup END

augroup filetypedetect
" toml:cespare/vim-toml
" Rust uses several TOML config files that are not named with .toml.
autocmd BufNewFile,BufRead *.toml,Cargo.lock,*/.cargo/config set filetype=toml
augroup END

augroup filetypedetect
" twig:lumiliet/vim-twig

if !exists('g:vim_twig_filetype_detected') && has("autocmd")
  au BufNewFile,BufRead *.twig set filetype=html.twig
  au BufNewFile,BufRead *.html.twig set filetype=html.twig
  au BufNewFile,BufRead *.xml.twig set filetype=xml.twig
endif
augroup END

augroup filetypedetect
" typescript:leafgarland/typescript-vim
" use `set filetype` to override default filetype=xml for *.ts files
autocmd BufNewFile,BufRead *.ts  set filetype=typescript
" use `setfiletype` to not override any other plugins like ianks/vim-tsx
autocmd BufNewFile,BufRead *.tsx setfiletype typescript
augroup END

augroup filetypedetect
" vala:arrufat/vala.vim
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi,*.valadoc setfiletype vala
augroup END

augroup filetypedetect
" vbnet:vim-scripts/vbnet.vim
augroup END

augroup filetypedetect
" vcl:smerrill/vcl-vim-plugin
au BufRead,BufNewFile *.vcl set filetype=vcl
augroup END

augroup filetypedetect
" vifm:vifm/vifm.vim
autocmd BufRead,BufNewFile vifm.rename* :set filetype=vifm-rename
augroup END

augroup filetypedetect
" vifm:vifm/vifm.vim
autocmd BufRead,BufNewFile vifmrc :set filetype=vifm
autocmd BufRead,BufNewFile *vifm/colors/* :set filetype=vifm
augroup END

augroup filetypedetect
" vue:posva/vim-vue
au BufNewFile,BufRead *.vue setf vue
augroup END

augroup filetypedetect
" vm:lepture/vim-velocity
au BufRead,BufNewFile *.vm set ft=velocity syntax=velocity
augroup END

augroup filetypedetect
" xls:vim-scripts/XSLT-syntax
augroup END

augroup filetypedetect
" yard:sheerun/vim-yardoc
augroup END

