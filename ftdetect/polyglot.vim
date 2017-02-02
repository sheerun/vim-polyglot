augroup filetypedetect
" Enable jsx syntax by default
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 0
endif

" Disable json concealing by default
if !exists('g:vim_json_syntax_conceal')
  let g:vim_json_syntax_conceal = 0
endif

let g:filetype_euphoria = 'elixir'
" ftdetect/ansible.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ansible') == -1
  
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

endif

" ftdetect/arduino.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'arduino') == -1
  
au BufRead,BufNewFile *.ino,*.pde set filetype=arduino

endif

" ftdetect/blade.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'blade') == -1
  
autocmd BufNewFile,BufRead *.blade.php set filetype=blade

endif

" ftdetect/cjsx.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cjsx') == -1
  
augroup CJSX
  au!
  autocmd BufNewFile,BufRead *.csx,*.cjsx set filetype=coffee
augroup END

endif

" ftdetect/clojure.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'clojure') == -1
  
autocmd BufNewFile,BufRead *.clj,*.cljs,*.edn,*.cljx,*.cljc,{build,profile}.boot setlocal filetype=clojure

endif

" ftdetect/coffee.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'coffee-script') == -1
  
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

endif

" ftdetect/cql.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cql') == -1
  
if has("autocmd")
  au  BufNewFile,BufRead *.cql set filetype=cql
endif

endif

" ftdetect/cryptol.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cryptol') == -1
  
" Copyright © 2013 Edward O'Callaghan. All Rights Reserved.
"  Normal Cryptol Program;
au! BufRead,BufNewFile *.cry set filetype=cryptol
au! BufRead,BufNewFile *.cyl set filetype=cryptol
"  Literate Cryptol Program;
au! BufRead,BufNewFile *.lcry set filetype=cryptol
au! BufRead,BufNewFile *.lcyl set filetype=cryptol
" Also in LaTeX *.tex which is outside our coverage scope.

endif

" ftdetect/crystal.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'crystal') == -1
  
autocmd BufNewFile,BufReadPost *.cr setlocal filetype=crystal
autocmd BufNewFile,BufReadPost Projectfile setlocal filetype=crystal
autocmd BufNewFile,BufReadPost *.ecr setlocal filetype=eruby

endif

" ftdetect/cucumber.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cucumber') == -1
  
" Cucumber
autocmd BufNewFile,BufReadPost *.feature,*.story set filetype=cucumber

endif

" ftdetect/dart.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dart') == -1
  
autocmd BufRead,BufNewFile *.dart set filetype=dart

endif

" ftdetect/dockerfile.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dockerfile') == -1
  
au BufNewFile,BufRead Dockerfile set filetype=dockerfile

endif

" ftdetect/elixir.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elixir') == -1
  
au BufRead,BufNewFile *.ex,*.exs call s:setf('elixir')
au BufRead,BufNewFile *.eex call s:setf('eelixir')
au BufRead,BufNewFile * call s:DetectElixir()

au FileType elixir,eelixir setl sw=2 sts=2 et iskeyword+=!,?

function! s:setf(filetype) abort
  let &filetype = a:filetype
endfunction

function! s:DetectElixir()
  if getline(1) =~ '^#!.*\<elixir\>'
    call s:setf('elixir')
  endif
endfunction

endif

" ftdetect/elm.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'elm') == -1
  
au BufNewFile,BufRead *.elm		set filetype=elm

endif

" ftdetect/ember-script.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emberscript') == -1
  
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

endif

" ftdetect/emblem.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'emblem') == -1
  
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

endif

" ftdetect/erlang.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'erlang') == -1
  
au BufNewFile,BufRead *.erl,*.hrl,rebar.config,*.app,*.app.src,*.yaws,*.xrl set ft=erlang

endif

" ftdetect/fish.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fish') == -1
  
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

endif

" ftdetect/git.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'git') == -1
  
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

endif

" ftdetect/glsl.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'glsl') == -1
  
" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

autocmd! BufNewFile,BufRead *.glsl,*.geom,*.vert,*.frag,*.gsh,*.vsh,*.fsh,*.vs,*.fs,*.gs,*.tcs,*.tes,*.tesc,*.tese,*.comp set filetype=glsl

" vim:set sts=2 sw=2 :

endif

" ftdetect/gofiletype.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'go') == -1
  
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

endif

" ftdetect/haml.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haml') == -1
  
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss

endif

" ftdetect/haskell.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haskell') == -1
  
au BufRead,BufNewFile *.hsc set filetype=haskell
au BufRead,BufNewFile *.bpk set filetype=haskell
au BufRead,BufNewFile *.hsig set filetype=haskell

endif

" ftdetect/haxe.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'haxe') == -1
  
autocmd BufNewFile,BufRead *.hx setf haxe

endif

" ftdetect/i3.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'i3') == -1
  
augroup i3_ftdetect
  au!
  au BufRead,BufNewFile *i3/config set ft=i3
augroup END

endif

" ftdetect/jasmine.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jasmine') == -1
  
autocmd BufNewFile,BufRead *Spec.js,*_spec.js set filetype=jasmine.javascript syntax=jasmine

endif

" ftdetect/javascript.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'javascript') == -1
  
au BufNewFile,BufRead *.js setf javascript
au BufNewFile,BufRead *.jsm setf javascript
au BufNewFile,BufRead Jakefile setf javascript
au BufNewFile,BufRead *.es6 setf javascript

fun! s:SelectJavascript()
  if getline(1) =~# '^#!.*/bin/\%(env\s\+\)\?node\>'
    set ft=javascript
  endif
endfun
au BufNewFile,BufRead * call s:SelectJavascript()

endif
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jsx') == -1
  
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

if g:jsx_pragma_required
  " Look for the @jsx pragma.  It must be included in a docblock comment before
  " anything else in the file (except whitespace).
  let s:jsx_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@jsx\_.\{-}\*\/'
  let b:jsx_pragma_found = search(s:jsx_pragma_pattern, 'npw')
endif

" Whether to set the JSX filetype on *.js files.
fu! <SID>EnableJSX()
  if g:jsx_pragma_required && !b:jsx_pragma_found | return 0 | endif
  if g:jsx_ext_required && !exists('b:jsx_ext_found') | return 0 | endif
  return 1
endfu

autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.js
  \ if <SID>EnableJSX() | set filetype=javascript.jsx | endif

endif

" ftdetect/json.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'json') == -1
  
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonp setlocal filetype=json
autocmd BufNewFile,BufRead *.geojson setlocal filetype=json

endif

" ftdetect/jst.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jst') == -1
  
au BufNewFile,BufRead *.ejs set filetype=jst
au BufNewFile,BufRead *.jst set filetype=jst
au BufNewFile,BufRead *.djs set filetype=jst
au BufNewFile,BufRead *.hamljs set filetype=jst
au BufNewFile,BufRead *.ect set filetype=jst

endif

" ftdetect/julia.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'julia') == -1
  
" NOTE: this line fixes an issue with the default system-wide lisp ftplugin
"       which doesn't define b:undo_ftplugin
"       (*.jt files are recognized as lisp)
au BufRead,BufNewFile *.jl		let b:undo_ftplugin = "setlocal comments< define< formatoptions< iskeyword< lisp<"

au BufRead,BufNewFile *.jl		set filetype=julia

endif

" ftdetect/kotlin.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'kotlin') == -1
  
autocmd BufNewFile,BufRead *.kt setfiletype kotlin
autocmd BufNewFile,BufRead *.kts setfiletype kotlin

endif

" ftdetect/less.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'less') == -1
  
autocmd BufNewFile,BufRead *.less setf less

endif

" ftdetect/liquid.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'liquid') == -1
  
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

endif

" ftdetect/ls.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'livescript') == -1
  
" Language:    LiveScript
" Maintainer:  George Zahariev
" URL:         http://github.com/gkz/vim-ls
" License:     WTFPL
"
autocmd BufNewFile,BufRead *.ls set filetype=ls
autocmd BufNewFile,BufRead *Slakefile set filetype=ls

endif

" ftdetect/mako.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'mako') == -1
  
au BufRead,BufNewFile *.mako     set filetype=mako

endif

" ftdetect/markdown.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'markdown') == -1
  
" markdown filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} set filetype=markdown

endif

" ftdetect/mason-in-html.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1
  
" Highlight .html files as Mason if they start with Mason tags
autocmd BufRead *.html
    \ if getline(1) =~ '^\(%\|<[%&].*>\)' |
    \     set filetype=mason |
    \ endif

endif

" ftdetect/mustache.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'handlebars') == -1
  
if has("autocmd")
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  au  BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif

endif

" ftdetect/nginx.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nginx') == -1
  
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx

endif

" ftdetect/nim.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nim') == -1
  
au BufNewFile,BufRead *.nim,*.nims set filetype=nim


endif

" ftdetect/nix.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nix') == -1
  
autocmd BufNewFile,BufRead *.nix setfiletype nix

endif

" ftdetect/opencl.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'opencl') == -1
  
au! BufRead,BufNewFile *.cl set filetype=opencl

endif

" ftdetect/perl11.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'perl') == -1
  
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

endif

" ftdetect/pgsql.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pgsql') == -1
  
" postgreSQL
au BufNewFile,BufRead *.pgsql           setf pgsql

endif

" ftdetect/plantuml.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'plantuml') == -1
  
" Vim ftdetect file
" Language:     PlantUML
" Maintainer:   Aaron C. Meadows < language name at shadowguarddev dot com>
" Version:      0.1

if did_filetype()
  finish
endif

autocmd BufRead,BufNewFile * :if getline(1) =~ '^.*startuml.*$'| setfiletype plantuml | set filetype=plantuml | endif
autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml setfiletype plantuml | set filetype=plantuml

endif

" ftdetect/proto.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'protobuf') == -1
  
autocmd BufNewFile,BufRead *.proto setfiletype proto

endif

" ftdetect/ps1.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  
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

endif

" ftdetect/ps1xml.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  
" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327

au BufNewFile,BufRead   *.ps1xml   set ft=ps1xml

endif

" ftdetect/pug.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'pug') == -1
  
" Pug
autocmd BufNewFile,BufReadPost *.pug set filetype=pug

" Jade
autocmd BufNewFile,BufReadPost *.jade set filetype=pug

endif

" ftdetect/puppet.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'puppet') == -1
  
au! BufRead,BufNewFile *.pp setfiletype puppet
au! BufRead,BufNewFile Puppetfile setfiletype ruby

endif

" ftdetect/purescript.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'purescript') == -1
  
au BufNewFile,BufRead *.purs setf purescript
au FileType purescript let &l:commentstring='{--%s--}'

endif

" ftdetect/python.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'python-compiler') == -1
  
" Vim compiler file
" Compiler:	Unit testing tool for Python
" Maintainer:	Ali Aliev <ali@aliev.me>
" Last Change: 2015 Nov 2

autocmd FileType python compiler python

endif

" ftdetect/qml.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qml') == -1
  
autocmd BufRead,BufNewFile *.qml setfiletype qml

endif

" ftdetect/raml.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'raml') == -1
  
au BufRead,BufNewFile *.raml set ft=raml

endif

" ftdetect/ruby.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ruby') == -1
  
" Officially distributed filetypes

" Support functions {{{
function! s:setf(filetype) abort
  if &filetype !=# a:filetype
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

endif

" ftdetect/ruby_extra.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'ruby') == -1
  
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

endif

" ftdetect/rust.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'rust') == -1
  
au BufRead,BufNewFile *.rs set filetype=rust

endif

" ftdetect/sbt.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'sbt') == -1
  
" Vim detect file
" Language:     sbt
" Maintainer:   Derek Wyatt <derek@{myfirstname}{mylastname}.org>
" Last Change:  2012 Jan 19

au BufRead,BufNewFile *.sbt set filetype=sbt.scala

endif

" ftdetect/scala.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scala') == -1
  
fun! s:DetectScala()
    if getline(1) =~# '^#!\(/usr\)\?/bin/env\s\+scalas\?'
        set filetype=scala
    endif
endfun

au BufRead,BufNewFile *.scala set filetype=scala
au BufRead,BufNewFile * call s:DetectScala()

" Install vim-sbt for additional syntax highlighting.
au BufRead,BufNewFile *.sbt setfiletype sbt.scala

endif

" ftdetect/scss.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'scss') == -1
  
au BufRead,BufNewFile *.scss setfiletype scss
au BufEnter *.scss :syntax sync fromstart

endif

" ftdetect/slim.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'slim') == -1
  
autocmd BufNewFile,BufRead *.slim setfiletype slim

endif

" ftdetect/solidity.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'solidity') == -1
  
au BufNewFile,BufRead *.sol setf solidity

endif

" ftdetect/stylus.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'stylus') == -1
  
" Stylus
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus
autocmd BufNewFile,BufReadPost *.stylus set filetype=stylus

endif

" ftdetect/swift.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'swift') == -1
  
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

endif

" ftdetect/systemd.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'systemd') == -1
  
au BufNewFile,BufRead *.automount set filetype=systemd
au BufNewFile,BufRead *.mount     set filetype=systemd
au BufNewFile,BufRead *.path      set filetype=systemd
au BufNewFile,BufRead *.service   set filetype=systemd
au BufNewFile,BufRead *.socket    set filetype=systemd
au BufNewFile,BufRead *.swap      set filetype=systemd
au BufNewFile,BufRead *.target    set filetype=systemd
au BufNewFile,BufRead *.timer     set filetype=systemd

endif

" ftdetect/terraform.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'terraform') == -1
  
au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript

endif

" ftdetect/textile.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'textile') == -1
  
" textile.vim
"
" Tim Harper (tim.theenchanter.com)

" Force filetype to be textile even if already set
" This will override the system ftplugin/changelog 
" set on some distros
au BufRead,BufNewFile *.textile set filetype=textile

endif

" ftdetect/thrift.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'thrift') == -1
  
au BufNewFile,BufRead *.thrift setlocal filetype=thrift

endif

" ftdetect/tmux.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'tmux') == -1
  
autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux

endif

" ftdetect/toml.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'toml') == -1
  
" Rust uses several TOML config files that are not named with .toml.
autocmd BufNewFile,BufRead *.toml,Cargo.lock,.cargo/config set filetype=toml

endif

" ftdetect/typescript.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'typescript') == -1
  
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript

endif

" ftdetect/vala.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vala') == -1
  
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi,*.valadoc setfiletype vala

endif

" ftdetect/vcl.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vcl') == -1
  
au BufRead,BufNewFile *.vcl set filetype=vcl

endif

" ftdetect/velocity.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vm') == -1
  
au BufRead,BufNewFile *.vm set ft=velocity syntax=velocity

endif

" ftdetect/vue.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1
  
au BufNewFile,BufRead *.vue setf vue.html.javascript.css

endif

" ftdetect/xml.vim
if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'powershell') == -1
  
" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Version:            2.10
" Project Repository: https://github.com/PProvost/vim-ps1
" Vim Script Page:    http://www.vim.org/scripts/script.php?script_id=1327

au BufNewFile,BufRead   *.cdxml    set ft=xml
au BufNewFile,BufRead   *.psc1     set ft=xml

endif

augroup END
