" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

function! s:SetDefault(name, value)
  if !exists(a:name)
    let {a:name} = a:value
  endif
endfunction

call s:SetDefault('g:markdown_enable_spell_checking', 0)
call s:SetDefault('g:markdown_enable_input_abbreviations', 0)
call s:SetDefault('g:markdown_enable_mappings', 0)

" Enable jsx syntax by default
call s:SetDefault('g:jsx_ext_required', 0)

" Make csv loading faster
call s:SetDefault('g:csv_start', 1)
call s:SetDefault('g:csv_end', 2)

" Disable json concealing by default
call s:SetDefault('g:vim_json_syntax_conceal', 0)

call s:SetDefault('g:filetype_euphoria', 'elixir')

call s:SetDefault('g:python_highlight_builtins', 1)
call s:SetDefault('g:python_highlight_builtin_objs', 1)
call s:SetDefault('g:python_highlight_builtin_types', 1)
call s:SetDefault('g:python_highlight_builtin_funcs', 1)
call s:SetDefault('g:python_highlight_builtin_funcs_kwarg', 1)
call s:SetDefault('g:python_highlight_exceptions', 1)
call s:SetDefault('g:python_highlight_string_formatting', 1)
call s:SetDefault('g:python_highlight_string_format', 1)
call s:SetDefault('g:python_highlight_string_templates', 1)
call s:SetDefault('g:python_highlight_indent_errors', 1)
call s:SetDefault('g:python_highlight_space_errors', 1)
call s:SetDefault('g:python_highlight_doctests', 1)
call s:SetDefault('g:python_highlight_func_calls', 1)
call s:SetDefault('g:python_highlight_class_vars', 1)
call s:SetDefault('g:python_highlight_operators', 1)
call s:SetDefault('g:python_highlight_file_headers_as_comments', 1)
call s:SetDefault('g:python_slow_sync', 1)

" visualbasic
au BufNewFile,BufRead *.vb set ft=vbnet
  
" julia
au BufNewFile,BufRead *.jl set ft=julia

" coffeescript
au BufNewFile,BufRead *.coffee set ft=coffee
au BufNewFile,BufRead *Cakefile set ft=coffee
au BufNewFile,BufRead *.coffeekup,*.ck set ft=coffee
au BufNewFile,BufRead *._coffee set ft=coffee
au BufNewFile,BufRead *.litcoffee set ft=litcoffee
au BufNewFile,BufRead *.coffee.md set ft=litcoffee

" elixir
au BufNewFile,BufRead *.ex,*.exs set ft=elixir
au BufNewFile,BufRead *.eex,*.leex set ft=eelixir
au BufNewFile,BufRead mix.lock set ft=elixir

" fish
au BufNewFile,BufRead *.fish set ft=fish
au BufNewFile,BufRead ~/.config/fish/fish_{read_,}history set ft=yaml
  
" git
au BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
au BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
au BufNewFile,BufRead */.config/git/config set ft=gitconfig
au BufNewFile,BufRead *.git/modules/**/config set ft=gitconfig
au BufNewFile,BufRead git-rebase-todo set ft=gitrebase
au BufNewFile,BufRead .gitsendemail.* set ft=gitsendemail

" plantuml
au BufNewFile,BufRead *.pu,*.uml,*.plantuml,*.puml set ft=plantuml

" scala
au BufNewFile,BufRead *.scala,*.sc set ft=scala
au BufNewFile,BufRead *.sbt set ft=sbt.scala

" swift
au BufNewFile,BufRead *.swift set ft=swift

"jinja
au BufNewFile,BufRead *.jinja2,*.j2,*.jinja,*.nunjucks,*.nunjs,*.njk set ft=jinja
au BufNewFile,BufRead *.html.jinja2,*.html.j2,*.html.jinja,*.htm.jinja2,*.htm.j2,*.htm.jinja set ft=jinja.html

"jsx
au BufNewFile,BufRead *.jsx set ft=javascriptreact

"fsharp
au BufNewFile,BufRead *.fs,*.fsi,*.fsx set ft=fsharp
" acpiasl, from asl.vim in martinlroth/vim-acpi-asl
au BufNewFile,BufRead *.asl set ft=asl
au BufNewFile,BufRead *.dsl set ft=asl

" apiblueprint, from apiblueprint.vim in sheerun/apiblueprint.vim
au BufNewFile,BufRead *.apib set ft=apiblueprint

" applescript, from applescript.vim in mityu/vim-applescript:_SYNTAX

au BufNewFile,BufRead *.scpt set ft=applescript
au BufNewFile,BufRead *.applescript set ft=applescript

" vim: foldmethod=marker

" arduino, from arduino.vim in sudar/vim-arduino-syntax
au BufNewFile,BufRead *.ino,*.pde set ft=arduino

" asciidoc, from asciidoc.vim in asciidoc/vim-asciidoc
au BufNewFile,BufRead *.asciidoc,*.adoc
	\ set ft=asciidoc

" blade, from blade.vim in jwalton512/vim-blade
au BufNewFile,BufRead *.blade.php set ft=blade

" brewfile, from brewfile.vim in bfontaine/Brewfile.vim
au BufNewFile,BufRead Brewfile,.Brewfile set ft=ruby syntax=brewfile

" caddyfile, from caddyfile.vim in isobit/vim-caddyfile
au BufNewFile,BufRead Caddyfile set ft=caddyfile

" carp, from carp.vim in hellerve/carp-vim
au BufNewFile,BufRead *.carp set ft=carp

" cjsx, from cjsx.vim in mtscout6/vim-cjsx
au BufNewFile,BufRead *.csx,*.cjsx set ft=coffee

" clojure, from clojure.vim in guns/vim-clojure-static
au BufNewFile,BufRead *.clj,*.cljs,*.edn,*.cljx,*.cljc,{build,profile}.boot set ft=clojure

" cql, from cql.vim in elubow/cql-vim
au  BufNewFile,BufRead *.cql set ft=cql

" cryptol, from cryptol.vim in victoredwardocallaghan/cryptol.vim
au BufNewFile,BufRead *.cry set ft=cryptol
au BufNewFile,BufRead *.cyl set ft=cryptol
au BufNewFile,BufRead *.lcry set ft=cryptol
au BufNewFile,BufRead *.lcyl set ft=cryptol

" crystal, from crystal.vim in rhysd/vim-crystal
au BufNewFile,BufRead *.cr set ft=crystal
au BufNewFile,BufRead Projectfile set ft=crystal

" crystal, from ecrystal.vim in rhysd/vim-crystal
au BufNewFile,BufRead *.ecr set ft=ecrystal

" csv, from csv.vim in chrisbra/csv.vim
au BufNewFile,BufRead *.csv,*.dat,*.tsv,*.tab set ft=csv

" cucumber, from cucumber.vim in tpope/vim-cucumber
au BufNewFile,BufRead *.feature,*.story set ft=cucumber

" cue, from cuesheet.vim in mgrabovsky/vim-cuesheet
au BufNewFile,BufRead *.cue set ft=cuesheet

" dart, from dart.vim in dart-lang/dart-vim-plugin
au BufNewFile,BufRead *.dart set ft=dart

" dhall, from dhall.vim in vmchale/dhall-vim
au BufNewFile,BufRead *.dhall set ft=dhall

" dlang, from d.vim in JesseKPhillips/d.vim
au BufNewFile,BufRead *.d set ft=d

" dlang, from dcov.vim in JesseKPhillips/d.vim
au BufNewFile,BufRead *.lst set ft=dcov

" dlang, from dd.vim in JesseKPhillips/d.vim
au BufNewFile,BufRead *.dd set ft=dd

" dlang, from ddoc.vim in JesseKPhillips/d.vim
au BufNewFile,BufRead *.ddoc set ft=ddoc

" dlang, from dsdl.vim in JesseKPhillips/d.vim
au BufNewFile,BufRead *.sdl set ft=dsdl

" dockerfile, from Dockerfile.vim in ekalinin/Dockerfile.vim
" vint: -ProhibitAutocmdWithNoGroup

" Dockerfile
au BufNewFile,BufRead [Dd]ockerfile set ft=Dockerfile
au BufNewFile,BufRead Dockerfile* set ft=Dockerfile
au BufNewFile,BufRead [Dd]ockerfile.vim set ft=vim
au BufNewFile,BufRead *.dock set ft=Dockerfile
au BufNewFile,BufRead *.[Dd]ockerfile set ft=Dockerfile

" dockerfile, from docker-compose.vim in ekalinin/Dockerfile.vim
au BufNewFile,BufRead docker-compose*.{yaml,yml}* set ft=yaml.docker-compose

" elm, from elm.vim in andys8/vim-elm-syntax
" detection for Elm (https://elm-lang.org)

au BufNewFile,BufRead *.elm set ft=elm

" emberscript, from ember-script.vim in yalesov/vim-ember-script
au BufNewFile,BufRead *.em set ft=ember-script

" emblem, from emblem.vim in yalesov/vim-emblem
au BufNewFile,BufRead *.emblem set ft=emblem

" erlang, from erlang.vim in vim-erlang/vim-erlang-runtime
au BufNewFile,BufRead *.erl,*.hrl,rebar.config,*.app,*.app.src,*.yaws,*.xrl,*.escript set ft=erlang

" ferm, from ferm.vim in vim-scripts/ferm.vim
au BufNewFile,BufRead ferm.conf set ft=ferm 
au BufNewFile,BufRead *.ferm set ft=ferm

" flatbuffers, from fbs.vim in dcharbon/vim-flatbuffers
au BufNewFile,BufRead *.fbs set ft=fbs

" gdscript, from gdscript3.vim in calviken/vim-gdscript3
au BufNewFile,BufRead *.gd set ft=gdscript3

" gdscript, from gsl.vim in calviken/vim-gdscript3
au BufNewFile,BufRead *.shader set ft=gsl

" glsl, from glsl.vim in tikhomirov/vim-glsl:_NOAFTER
au BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set ft=glsl

" gmpl, from gmpl.vim in maelvalais/gmpl.vim
au BufNewFile,BufRead *.mod set ft=gmpl

" go, from gofiletype.vim in fatih/vim-go:_BASIC
au BufNewFile,BufRead *.go set ft=go
au BufNewFile,BufRead *.s set ft=asm
au BufNewFile,BufRead *.tmpl set ft=gohtmltmpl

" go.mod
au BufNewFile,BufRead go.mod set ft=gomod

" graphql
au BufNewFile,BufRead *.graphql,*.graphqls,*.gql set ft=graphql

" gradle, from gradle.vim in tfnico/vim-gradle
au BufNewFile,BufRead *.gradle set ft=groovy

" haml, from haml.vim in sheerun/vim-haml
au BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc set ft=haml

" handlebars, from mustache.vim in mustache/vim-mustache-handlebars
au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set ft=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim indent/handlebars.vim
au  BufNewFile,BufRead *.handlebars,*.hdbs,*.hbs,*.hb set ft=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

" haproxy, from haproxy.vim in CH-DanReif/haproxy.vim
au BufNewFile,BufRead haproxy*.c* set ft=haproxy

" haskell, from haskell.vim in neovimhaskell/haskell-vim
au BufNewFile,BufRead *.hsc set ft=haskell
au BufNewFile,BufRead *.bpk set ft=haskell
au BufNewFile,BufRead *.hsig set ft=haskell

" haxe, from haxe.vim in yaymukund/vim-haxe
au BufNewFile,BufRead *.hx set ft=haxe

" hcl, from hcl.vim in b4b4r07/vim-hcl
au BufNewFile,BufRead *.hcl set ft=hcl
au BufNewFile,BufRead *.nomad set ft=hcl
au BufNewFile,BufRead *.tf set ft=hcl
au BufNewFile,BufRead Appfile set ft=hcl

" helm, from helm.vim in towolf/vim-helm
au BufNewFile,BufRead */templates/*.yaml,*/templates/*.tpl set ft=helm

" hive, from hive.vim in zebradil/hive.vim
au BufNewFile,BufRead *.hql set ft=hive
au BufNewFile,BufRead *.ql set ft=hive
au BufNewFile,BufRead *.q set ft=hive

" i3, from i3config.vim in mboughaba/i3config.vim
au BufNewFile,BufRead .i3.config,i3.config,*.i3config,*.i3.config set ft=i3config

" idris, from idris.vim in idris-hackers/idris-vim
au BufNewFile,BufRead *.idr set ft=idris
au BufNewFile,BufRead idris-response set ft=idris

" idris, from lidris.vim in idris-hackers/idris-vim
au BufNewFile,BufRead *.lidr set ft=lidris

" ion, from ion.vim in vmchale/ion-vim
au BufNewFile,BufRead ~/.config/ion/initrc set ft=ion
au BufNewFile,BufRead *.ion set ft=ion

" javascript, from flow.vim in pangloss/vim-javascript:_JAVASCRIPT
au BufNewFile,BufRead *.flow set ft=flow

" javascript, from javascript.vim in pangloss/vim-javascript:_JAVASCRIPT
au BufNewFile,BufRead *.{js,mjs,cjs,jsm,es,es6},Jakefile set ft=javascript

" jenkins, from Jenkinsfile.vim in martinda/Jenkinsfile-vim-syntax
au BufNewFile,BufRead Jenkinsfile set ft=Jenkinsfile
au BufNewFile,BufRead Jenkinsfile* set ft=Jenkinsfile
au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
au BufNewFile,BufRead *.Jenkinsfile set ft=Jenkinsfile

" json5, from json5.vim in GutenYe/json5.vim
au BufNewFile,BufRead *.json5 set ft=json5

" json, from json.vim in elzr/vim-json
au BufNewFile,BufRead *.json set ft=json
au BufNewFile,BufRead *.jsonl set ft=json
au BufNewFile,BufRead *.jsonp set ft=json
au BufNewFile,BufRead *.geojson set ft=json
au BufNewFile,BufRead *.template set ft=json

" jst, from jst.vim in briancollins/vim-jst
au BufNewFile,BufRead *.ejs set ft=jst
au BufNewFile,BufRead *.jst set ft=jst
au BufNewFile,BufRead *.djs set ft=jst
au BufNewFile,BufRead *.hamljs set ft=jst
au BufNewFile,BufRead *.ect set ft=jst

" kotlin, from kotlin.vim in udalov/kotlin-vim
au BufNewFile,BufRead *.kt set ft=kotlin
au BufNewFile,BufRead *.kts set ft=kotlin

" less, from less.vim in groenewege/vim-less:_NOAFTER
au BufNewFile,BufRead *.less set ft=less

" lilypond, from lilypond.vim in anowlcalledjosh/vim-lilypond
au BufNewFile,BufRead *.ly,*.ily set ft=lilypond

" livescript, from ls.vim in gkz/vim-ls
au BufNewFile,BufRead *.ls set ft=ls
au BufNewFile,BufRead *Slakefile set ft=ls

" llvm, from llvm.vim in rhysd/vim-llvm
au BufNewFile,BufRead *.ll set ft=llvm

" llvm, from llvm-lit.vim in rhysd/vim-llvm
au BufNewFile,BufRead lit.*cfg set ft=python

" llvm, from tablegen.vim in rhysd/vim-llvm
au BufNewFile,BufRead *.td set ft=tablegen

" log, from log.vim in MTDL9/vim-log-highlighting
au BufNewFile,BufRead *.log set ft=log
au BufNewFile,BufRead *_log set ft=log

" mako, from mako.vim in sophacles/vim-bundle-mako
au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
au BufNewFile,BufRead *.mako set ft=mako

" markdown, from markdown.vim in plasticboy/vim-markdown:_NOAFTER
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} set ft=markdown
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} set ft=markdown

" mathematica, from mma.vim in voldikss/vim-mma
au BufNewFile,BufRead *.wl set ft=mma
au BufNewFile,BufRead *.wls set ft=mma
au BufNewFile,BufRead *.nb set ft=mma
au BufNewFile,BufRead *.m set ft=mma

" mdx, from mdx.vim in jxnblk/vim-mdx-js
au BufNewFile,BufRead *.mdx set ft=markdown.mdx

" meson, from meson.vim in mesonbuild/meson:_ALL:/data/syntax-highlighting/vim/
au BufNewFile,BufRead meson.build set ft=meson
au BufNewFile,BufRead meson_options.txt set ft=meson
au BufNewFile,BufRead *.wrap set ft=dosini

" moonscript, from moon.vim in leafo/moonscript-vim
au BufNewFile,BufRead *.moon set ft=moon

" nginx, from nginx.vim in chr4/nginx.vim
au BufNewFile,BufRead *.nginx set ft=nginx
au BufNewFile,BufRead nginx*.conf set ft=nginx
au BufNewFile,BufRead *nginx.conf set ft=nginx
au BufNewFile,BufRead */etc/nginx/* set ft=nginx
au BufNewFile,BufRead */usr/local/nginx/conf/* set ft=nginx
au BufNewFile,BufRead */nginx/*.conf set ft=nginx

" nim, from nim.vim in zah/nim.vim:_BASIC
au BufNewFile,BufRead *.nim,*.nims,*.nimble set ft=nim

" nix, from nix.vim in LnL7/vim-nix
au BufNewFile,BufRead *.nix set ft=nix

" ocaml, from dune.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead jbuild,dune,dune-project,dune-workspace set ft=dune

" ocaml, from oasis.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead _oasis set ft=oasis

" ocaml, from ocaml.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead *.ml,*.mli,*.mll,*.mly,.ocamlinit,*.mlt,*.mlp,*.mlip,*.mli.cppo,*.ml.cppo set ft=ocaml

" ocaml, from ocamlbuild_tags.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead _tags set ft=ocamlbuild_tags

" ocaml, from omake.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead OMakefile,OMakeroot,*.om,OMakeroot.in set ft=omake

" ocaml, from opam.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead opam,*.opam,*.opam.template set ft=opam

" ocaml, from sexplib.vim in rgrinberg/vim-ocaml
au BufNewFile,BufRead *.sexp set ft=sexplib

" opencl, from opencl.vim in petRUShka/vim-opencl
au BufNewFile,BufRead *.cl set ft=opencl

" perl, from perl11.vim in vim-perl/vim-perl
au BufNew,BufNewFile,BufRead *.nqp set ft=perl6

" pgsql, from pgsql.vim in lifepillar/pgsql.vim
au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql

" pony, from pony.vim in jakwings/vim-pony
au BufNewFile,BufRead *.pony set ft=pony

" powershell, from ps1.vim in PProvost/vim-ps1
au BufNewFile,BufRead *.ps1 set ft=ps1
au BufNewFile,BufRead *.psd1 set ft=ps1
au BufNewFile,BufRead *.psm1 set ft=ps1
au BufNewFile,BufRead *.pssc set ft=ps1
au BufNewFile,BufRead *.ps1xml set ft=ps1xml
au BufNewFile,BufRead *.cdxml set ft=xml
au BufNewFile,BufRead *.psc1 set ft=xml

" protobuf, from proto.vim in uarun/vim-protobuf
au BufNewFile,BufRead *.proto set ft=proto

" pug, from pug.vim in digitaltoad/vim-pug
au BufNewFile,BufRead *.pug set ft=pug

" Jade
au BufNewFile,BufRead *.jade set ft=pug

" puppet, from puppet.vim in rodjek/vim-puppet
au BufNewFile,BufRead *.pp set ft=puppet
au BufNewFile,BufRead *.epp set ft=embeddedpuppet
au BufNewFile,BufRead Puppetfile set ft=ruby

" purescript, from purescript.vim in purescript-contrib/purescript-vim
au BufNewFile,BufRead *.purs set ft=purescript

" qmake, from pri.vim in artoj/qmake-syntax-vim
au BufNewFile,BufRead *.pri set ft=qmake

" qmake, from pro.vim in artoj/qmake-syntax-vim
au BufNewFile,BufRead *.pro set ft=qmake

" qml, from qml.vim in peterhoeg/vim-qml
au BufNewFile,BufRead *.qml set ft=qml

" racket, from racket.vim in wlangstroth/vim-racket
au BufNewFile,BufRead *.rkt,*.rktl set ft=racket

" raku, from raku.vim in Raku/vim-raku
au BufNewFile,BufRead *.pm6,*.p6,*.t6,*.pod6,*.raku,*.rakumod,*.rakudoc,*.rakutest set ft=raku

" raml, from raml.vim in IN3D/vim-raml
au BufNewFile,BufRead *.raml set ft=raml

" razor, from razor.vim in adamclerk/vim-razor
au BufNewFile,BufRead *.cshtml set ft=razor

" reason, from reason.vim in reasonml-editor/vim-reason-plus
au BufNewFile,BufRead *.re set ft=reason
au BufNewFile,BufRead *.rei set ft=reason
au BufNewFile,BufRead .merlin set ft=merlin

" ruby, from ruby.vim in vim-ruby/vim-ruby
au BufNewFile,BufRead *.erb,*.rhtml set ft=eruby
au BufNewFile,BufRead .irbrc,irbrc set ft=ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gemspec set ft=ruby
au BufNewFile,BufRead *.ru set ft=ruby
au BufNewFile,BufRead Gemfile set ft=ruby
au BufNewFile,BufRead *.builder,*.rxml,*.rjs,*.ruby set ft=ruby
au BufNewFile,BufRead [rR]akefile,*.rake set ft=ruby
au BufNewFile,BufRead [rR]antfile,*.rant set ft=ruby
au BufNewFile,BufRead Appraisals set ft=ruby
au BufNewFile,BufRead .autotest set ft=ruby
au BufNewFile,BufRead *.axlsx set ft=ruby
au BufNewFile,BufRead [Bb]uildfile set ft=ruby
au BufNewFile,BufRead Capfile,*.cap set ft=ruby
au BufNewFile,BufRead Cheffile set ft=ruby
au BufNewFile,BufRead Berksfile set ft=ruby
au BufNewFile,BufRead Podfile,*.podspec set ft=ruby
au BufNewFile,BufRead Guardfile,.Guardfile set ft=ruby
au BufNewFile,BufRead *.jbuilder set ft=ruby
au BufNewFile,BufRead KitchenSink set ft=ruby
au BufNewFile,BufRead *.opal set ft=ruby
au BufNewFile,BufRead .pryrc set ft=ruby
au BufNewFile,BufRead Puppetfile set ft=ruby
au BufNewFile,BufRead *.rabl set ft=ruby
au BufNewFile,BufRead [rR]outefile set ft=ruby
au BufNewFile,BufRead .simplecov set ft=ruby
au BufNewFile,BufRead *.rbi set ft=ruby
au BufNewFile,BufRead [tT]horfile,*.thor set ft=ruby
au BufNewFile,BufRead [vV]agrantfile set ft=ruby

" rust, from rust.vim in rust-lang/rust.vim
au BufNewFile,BufRead *.rs set ft=rust

" sbt, from sbt.vim in derekwyatt/vim-sbt
au BufNewFile,BufRead *.sbt set ft=sbt.scala

" scss, from scss.vim in cakebaker/scss-syntax.vim
au BufNewFile,BufRead *.scss set ft=scss

" slim, from slim.vim in slim-template/vim-slim
au BufNewFile,BufRead *.slim set ft=slim

" slime, from slime.vim in slime-lang/vim-slime-syntax
au BufNewFile,BufRead *.slime set ft=slime

" smt2, from smt2.vim in bohlender/vim-smt2
au BufNewFile,BufRead *.smt,*.smt2 set ft=smt2

" solidity, from solidity.vim in tomlion/vim-solidity
au BufNewFile,BufRead *.sol setf solidity

" stylus, from stylus.vim in wavded/vim-stylus
" Stylus
au BufNewFile,BufRead *.styl set ft=stylus
au BufNewFile,BufRead *.stylus set ft=stylus

" svelte, from svelte.vim in evanleck/vim-svelte
au BufNewFile,BufRead *.svelte set ft=svelte

au BufNewFile,BufRead sxhkdrc,*.sxhkdrc set ft=sxhkdrc

" systemd, from systemd.vim in wgwoods/vim-systemd-syntax
au BufNewFile,BufRead *.automount set ft=systemd
au BufNewFile,BufRead *.mount set ft=systemd
au BufNewFile,BufRead *.path set ft=systemd
au BufNewFile,BufRead *.service set ft=systemd
au BufNewFile,BufRead *.socket set ft=systemd
au BufNewFile,BufRead *.swap set ft=systemd
au BufNewFile,BufRead *.target set ft=systemd
au BufNewFile,BufRead *.timer set ft=systemd

" terraform, from terraform.vim in hashivim/vim-terraform
au BufNewFile,BufRead *.tf set ft=terraform
au BufNewFile,BufRead *.tfvars set ft=terraform
au BufNewFile,BufRead *.tfstate set ft=json
au BufNewFile,BufRead *.tfstate.backup set ft=json

" textile, from textile.vim in timcharper/textile.vim
au BufNewFile,BufRead *.textile set ft=textile

" thrift, from thrift.vim in solarnz/thrift.vim
au BufNewFile,BufRead *.thrift set ft=thrift

" tmux, from tmux.vim in ericpruitt/tmux.vim:_ALL:/vim/
au BufNewFile,BufRead {.,}tmux.conf set ft=tmux

" toml, from toml.vim in cespare/vim-toml
au BufNewFile,BufRead *.toml,Gopkg.lock,Cargo.lock,*/.cargo/config,*/.cargo/credentials,Pipfile setf toml

" tptp, from tptp.vim in c-cube/vim-tptp
au BufNewFile,BufRead *.p set ft=tptp
au BufNewFile,BufRead *.p set syntax=tptp
au BufNewFile,BufRead *.tptp set ft=tptp
au BufNewFile,BufRead *.tptp set syntax=tptp
au BufNewFile,BufRead *.ax set ft=tptp
au BufNewFile,BufRead *.ax set syntax=tptp

" twig, from twig.vim in lumiliet/vim-twig
au BufNewFile,BufRead *.twig set ft=html.twig
au BufNewFile,BufRead *.html.twig set ft=html.twig
au BufNewFile,BufRead *.xml.twig set ft=xml.twig

" typescript, from typescript.vim in HerringtonDarkholme/yats.vim
au BufNewFile,BufRead *.ts set ft=typescript

" typescript, from typescriptreact.vim in HerringtonDarkholme/yats.vim
au BufNewFile,BufRead *.tsx set ft=typescriptreact

" v, from vlang.vim in ollykel/v-vim
au BufNewFile,BufRead *.v set ft=vlang
au BufNewFile,BufRead *.v set syntax=vlang

" vala, from vala.vim in arrufat/vala.vim
au BufNewFile,BufRead *.vala,*.vapi,*.valadoc set ft=vala

" vcl, from vcl.vim in smerrill/vcl-vim-plugin
au BufNewFile,BufRead *.vcl set ft=vcl

" vifm, from vifm.vim in vifm/vifm.vim
au BufNewFile,BufRead vifmrc set ft=vifm
au BufNewFile,BufRead *vifm/colors/* set ft=vifm
au BufNewFile,BufRead *.vifm set ft=vifm

" vifm, from vifm-rename.vim in vifm/vifm.vim
au BufNewFile,BufRead vifm.rename* set ft=vifm-rename

" vm, from velocity.vim in lepture/vim-velocity
au BufNewFile,BufRead *.vm set ft=velocity syntax=velocity

" vue, from vue.vim in posva/vim-vue
au BufNewFile,BufRead *.vue,*.wpy setf vue

" xdc, from xdc.vim in amal-khailtash/vim-xdc-syntax
au BufNewFile,BufRead *.xdc set ft=xdc

" zephir, from zephir.vim in xwsoul/vim-zephir
au BufNewFile,BufRead *.zep set ft=zephir

" zig, from zig.vim in ziglang/zig.vim
au BufNewFile,BufRead *.zig set ft=zig
au BufNewFile,BufRead *.zir set ft=zir

" ledger
au BufNewFile,BufRead *.ldg,*.ledger,*.journal set ft=ledger

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save
