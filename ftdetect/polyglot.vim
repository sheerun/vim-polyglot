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
  au BufRead,BufNewFile *.ex,*.exs call s:setf('elixir')
  au BufRead,BufNewFile *.eex call s:setf('eelixir')

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
  autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml setfiletype plantuml | set filetype=plantuml

  " scala
  au BufRead,BufNewFile *.scala,*.sc set filetype=scala
  au BufRead,BufNewFile *.sbt setfiletype sbt.scala

  " swift
  autocmd BufNewFile,BufRead *.swift set filetype=swift
augroup END

" Fix for https://github.com/sheerun/vim-polyglot/issues/236#issuecomment-387984954
if (!exists('g:graphql_javascript_tags'))
  let g:graphql_javascript_tags = ['gql', 'graphql', 'Relay.QL']
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

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'asciidoc') == -1
  augroup filetypedetect
  " asciidoc, from asciidoc.vim in asciidoc/vim-asciidoc
autocmd BufNewFile,BufRead *.asciidoc,*.adoc
	\ set ft=asciidoc
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

au BufNewFile,BufRead * if s:isAnsible() | set ft=yaml.ansible | en
au BufNewFile,BufRead *.j2 call s:setupTemplate()
au BufNewFile,BufRead hosts set ft=ansible_hosts
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'arduino') == -1
  augroup filetypedetect
  " arduino, from arduino.vim in sudar/vim-arduino-syntax
au BufRead,BufNewFile *.ino,*.pde set filetype=arduino
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
autocmd BufNewFile,BufReadPost *.cr setlocal filetype=crystal
autocmd BufNewFile,BufReadPost Projectfile setlocal filetype=crystal
autocmd BufNewFile,BufReadPost *.ecr setlocal filetype=eruby
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

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'cucumber') == -1
  augroup filetypedetect
  " cucumber, from cucumber.vim in tpope/vim-cucumber
" Cucumber
autocmd BufNewFile,BufReadPost *.feature,*.story set filetype=cucumber
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'dart') == -1
  augroup filetypedetect
  " dart, from dart.vim in dart-lang/dart-vim-plugin
autocmd BufRead,BufNewFile *.dart set filetype=dart
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

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'fsharp') == -1
  augroup filetypedetect
  " fsharp, from fsharp.vim in fsharp/vim-fsharp:_BASIC
" F#, fsharp
autocmd BufNewFile,BufRead *.fs,*.fsi,*.fsx set filetype=fsharp
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'gmpl') == -1
  augroup filetypedetect
  " gmpl, from gmpl.vim in maelvalais/gmpl.vim
au BufRead,BufNewFile *.mod set filetype=gmpl
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'glsl') == -1
  augroup filetypedetect
  " glsl, from glsl.vim in tikhomirov/vim-glsl
" Language: OpenGL Shading Language
" Maintainer: Sergey Tikhomirov <sergey@tikhomirov.io>

" Extensions supported by Khronos reference compiler (with one exception, ".glsl")
" https://github.com/KhronosGroup/glslang
autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set filetype=glsl

" vim:set sts=2 sw=2 :
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'go') == -1
  augroup filetypedetect
  " go, from gofiletype.vim in fatih/vim-go:_BASIC
" vint: -ProhibitAutocmdWithNoGroup

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

" Note: should not use augroup in ftdetect (see :help ftdetect)
au BufNewFile *.go setfiletype go | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.go call s:gofiletype_pre("go")
au BufReadPost *.go call s:gofiletype_post()

au BufNewFile *.s setfiletype asm | setlocal fileencoding=utf-8 fileformat=unix
au BufRead *.s call s:gofiletype_pre("asm")
au BufReadPost *.s call s:gofiletype_post()

au BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl

" vim: sw=2 ts=2 et
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'graphql') == -1
  augroup filetypedetect
  " graphql, from graphql.vim in jparise/vim-graphql
au BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql
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
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  au  BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
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

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'i3') == -1
  augroup filetypedetect
  " i3, from i3.vim in PotatoesMaster/i3-vim-syntax
augroup i3_ftdetect
  au!
  au BufRead,BufNewFile *i3/config,*sway/config set ft=i3
augroup END
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

augroup javascript_syntax_detection
  autocmd!
  autocmd BufNewFile,BufRead *.{js,mjs,jsm,es,es6},Jakefile setfiletype javascript
  autocmd BufNewFile,BufRead * call s:SelectJavascript()
augroup END
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jenkins') == -1
  augroup filetypedetect
  " jenkins, from Jenkinsfile.vim in martinda/Jenkinsfile-vim-syntax
" Jenkinsfile
autocmd BufRead,BufNewFile Jenkinsfile set ft=Jenkinsfile
autocmd BufRead,BufNewFile Jenkinsfile* setf Jenkinsfile
autocmd BufRead,BufNewFile *.jenkinsfile set ft=Jenkinsfile
autocmd BufRead,BufNewFile *.jenkinsfile setf Jenkinsfile
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

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'json5') == -1
  augroup filetypedetect
  " json5, from json5.vim in GutenYe/json5.vim
au BufNewFile,BufRead *.json5 setfiletype json5
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

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'jsx') == -1
  augroup filetypedetect
  " jsx, from javascript.vim in mxw/vim-jsx:_ALL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftdetect file
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Whether the .jsx extension is required.
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 0
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
  " less, from less.vim in groenewege/vim-less
autocmd BufNewFile,BufRead *.less setf less
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'liquid') == -1
  augroup filetypedetect
  " liquid, from liquid.vim in tpope/vim-liquid
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
" markdown filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} set filetype=markdown
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
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'nim') == -1
  augroup filetypedetect
  " nim, from nim.vim in zah/nim.vim:_BASIC
au BufNewFile,BufRead *.nim,*.nims set filetype=nim
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
  " pgsql, from pgsql.vim in exu/pgsql.vim
" postgreSQL
au BufNewFile,BufRead *.pgsql           setf pgsql
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
  " puppet, from puppet.vim in voxpupuli/vim-puppet
au! BufRead,BufNewFile *.pp setfiletype puppet
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

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'qml') == -1
  augroup filetypedetect
  " qml, from qml.vim in peterhoeg/vim-qml
autocmd BufRead,BufNewFile *.qml setfiletype qml
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'racket') == -1
  augroup filetypedetect
  " racket, from racket.vim in wlangstroth/vim-racket
au BufRead,BufNewFile *.rkt,*.rktl  set filetype=racket
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'raml') == -1
  augroup filetypedetect
  " raml, from raml.vim in IN3D/vim-raml
au BufRead,BufNewFile *.raml set ft=raml
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
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile Cargo.toml if &filetype == "" | set filetype=cfg | endif

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
au BufRead,BufNewFile *.tf setlocal filetype=terraform
au BufRead,BufNewFile *.tfvars setlocal filetype=terraform
au BufRead,BufNewFile *.tfstate setlocal filetype=javascript
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
  " tmux, from tmux.vim in keith/tmux.vim
autocmd BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'toml') == -1
  augroup filetypedetect
  " toml, from toml.vim in cespare/vim-toml
" Go dep and Rust use several TOML config files that are not named with .toml.
autocmd BufNewFile,BufRead *.toml,Gopkg.lock,Cargo.lock,*/.cargo/config,Pipfile set filetype=toml
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
  " typescript, from typescript.vim in leafgarland/typescript-vim
" use `set filetype` to override default filetype=xml for *.ts files
autocmd BufNewFile,BufRead *.ts  set filetype=typescript
" use `setfiletype` to not override any other plugins like ianks/vim-tsx
autocmd BufNewFile,BufRead *.tsx setfiletype typescript
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
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vue') == -1
  augroup filetypedetect
  " vue, from vue.vim in posva/vim-vue
au BufNewFile,BufRead *.vue,*.wpy setf vue
  augroup end
endif

if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'vm') == -1
  augroup filetypedetect
  " vm, from velocity.vim in lepture/vim-velocity
au BufRead,BufNewFile *.vm set ft=velocity syntax=velocity
  augroup end
endif

