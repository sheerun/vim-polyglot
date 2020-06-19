" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

if !exists('g:polyglot_disabled')
  let g:polyglot_disabled = []
endif

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

if index(g:polyglot_disabled, 'acpiasl') == -1
  au BufNewFile,BufRead *.asl set ft=asl
  au BufNewFile,BufRead *.dsl set ft=asl
endif

if index(g:polyglot_disabled, 'apiblueprint') == -1
  au BufNewFile,BufRead *.apib set ft=apiblueprint
endif

if index(g:polyglot_disabled, 'applescript') == -1
  au BufNewFile,BufRead *.scpt set ft=applescript
  au BufNewFile,BufRead *.applescript set ft=applescript
endif

if index(g:polyglot_disabled, 'arduino') == -1
  au BufNewFile,BufRead *.ino,*.pde set ft=arduino
endif

if index(g:polyglot_disabled, 'asciidoc') == -1
  au BufNewFile,BufRead *.asciidoc,*.adoc set ft=asciidoc
endif

if index(g:polyglot_disabled, 'blade') == -1
  au BufNewFile,BufRead *.blade.php set ft=blade
endif

if index(g:polyglot_disabled, 'brewfile') == -1
  au BufNewFile,BufRead Brewfile,.Brewfile set ft=ruby syn=brewfile
endif

if index(g:polyglot_disabled, 'caddyfile') == -1
  au BufNewFile,BufRead Caddyfile set ft=caddyfile
endif

if index(g:polyglot_disabled, 'carp') == -1
  au BufNewFile,BufRead *.carp set ft=carp
endif

if index(g:polyglot_disabled, 'cjsx') == -1
  au BufNewFile,BufRead *.csx,*.cjsx set ft=coffee
endif

if index(g:polyglot_disabled, 'clojure') == -1
  au BufNewFile,BufRead *.clj,*.cljs,*.edn,*.cljx,*.cljc,{build,profile}.boot set ft=clojure
endif

if index(g:polyglot_disabled, 'coffee-script') == -1
  au BufNewFile,BufRead *.coffee set ft=coffee
  au BufNewFile,BufRead *Cakefile set ft=coffee
  au BufNewFile,BufRead *.coffeekup,*.ck set ft=coffee
  au BufNewFile,BufRead *._coffee set ft=coffee
  au BufNewFile,BufRead *.litcoffee set ft=litcoffee
  au BufNewFile,BufRead *.coffee.md set ft=litcoffee
endif

if index(g:polyglot_disabled, 'cql') == -1
  au  BufNewFile,BufRead *.cql set ft=cql
endif

if index(g:polyglot_disabled, 'cryptol') == -1
  au BufNewFile,BufRead *.cry set ft=cryptol
  au BufNewFile,BufRead *.cyl set ft=cryptol
  au BufNewFile,BufRead *.lcry set ft=cryptol
  au BufNewFile,BufRead *.lcyl set ft=cryptol
endif

if index(g:polyglot_disabled, 'crystal') == -1
  au BufNewFile,BufRead *.cr set ft=crystal
  au BufNewFile,BufRead Projectfile set ft=crystal
  au BufNewFile,BufRead *.ecr set ft=ecrystal
endif

if index(g:polyglot_disabled, 'csv') == -1
  au BufNewFile,BufRead *.csv,*.dat,*.tsv,*.tab set ft=csv
endif

if index(g:polyglot_disabled, 'cucumber') == -1
  au BufNewFile,BufRead *.feature,*.story set ft=cucumber
endif

if index(g:polyglot_disabled, 'cue') == -1
  au BufNewFile,BufRead *.cue set ft=cuesheet
endif

if index(g:polyglot_disabled, 'dart') == -1
  au BufNewFile,BufRead *.dart set ft=dart
endif

if index(g:polyglot_disabled, 'dhall') == -1
  au BufNewFile,BufRead *.dhall set ft=dhall
endif

if index(g:polyglot_disabled, 'dlang') == -1
  au BufNewFile,BufRead *.d set ft=d
  au BufNewFile,BufRead *.lst set ft=dcov
  au BufNewFile,BufRead *.dd set ft=dd
  au BufNewFile,BufRead *.ddoc set ft=ddoc
  au BufNewFile,BufRead *.sdl set ft=dsdl
endif

if index(g:polyglot_disabled, 'dockerfile') == -1
  au BufNewFile,BufRead [Dd]ockerfile set ft=Dockerfile
  au BufNewFile,BufRead Dockerfile* set ft=Dockerfile
  au BufNewFile,BufRead [Dd]ockerfile.vim set ft=vim
  au BufNewFile,BufRead *.dock set ft=Dockerfile
  au BufNewFile,BufRead *.[Dd]ockerfile set ft=Dockerfile
  au BufNewFile,BufRead docker-compose*.{yaml,yml}* set ft=yaml.docker-compose
endif

if index(g:polyglot_disabled, 'elixir') == -1
  au BufNewFile,BufRead *.ex,*.exs set ft=elixir
  au BufNewFile,BufRead *.eex,*.leex set ft=eelixir
  au BufNewFile,BufRead mix.lock set ft=elixir
endif

if index(g:polyglot_disabled, 'elm') == -1
  au BufNewFile,BufRead *.elm set ft=elm
endif

if index(g:polyglot_disabled, 'emberscript') == -1
  au BufNewFile,BufRead *.em set ft=ember-script
endif

if index(g:polyglot_disabled, 'emblem') == -1
  au BufNewFile,BufRead *.emblem set ft=emblem
endif

if index(g:polyglot_disabled, 'erlang') == -1
  au BufNewFile,BufRead *.erl,*.hrl,rebar.config,*.app,*.app.src,*.yaws,*.xrl,*.escript set ft=erlang
endif

if index(g:polyglot_disabled, 'ferm') == -1
  au BufNewFile,BufRead ferm.conf set ft=ferm 
  au BufNewFile,BufRead *.ferm set ft=ferm
endif

if index(g:polyglot_disabled, 'fish') == -1
  au BufNewFile,BufRead *.fish set ft=fish
  au BufNewFile,BufRead ~/.config/fish/fish_{read_,}history set ft=yaml
endif

if index(g:polyglot_disabled, 'flatbuffers') == -1
  au BufNewFile,BufRead *.fbs set ft=fbs
endif

if index(g:polyglot_disabled, 'fsharp') == -1
  au BufNewFile,BufRead *.fs,*.fsi,*.fsx set ft=fsharp
endif

if index(g:polyglot_disabled, 'gdscript') == -1
  au BufNewFile,BufRead *.gd set ft=gdscript3
  au BufNewFile,BufRead *.shader set ft=gsl
endif

if index(g:polyglot_disabled, 'git') == -1
  au BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
  au BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
  au BufNewFile,BufRead */.config/git/config set ft=gitconfig
  au BufNewFile,BufRead *.git/modules/**/config set ft=gitconfig
  au BufNewFile,BufRead git-rebase-todo set ft=gitrebase
  au BufNewFile,BufRead .gitsendemail.* set ft=gitsendemail
endif

if index(g:polyglot_disabled, 'glsl') == -1
  au BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set ft=glsl
endif

if index(g:polyglot_disabled, 'gmpl') == -1
  au BufNewFile,BufRead *.mod set ft=gmpl
endif

if index(g:polyglot_disabled, 'go') == -1
  au BufNewFile,BufRead *.go set ft=go
  au BufNewFile,BufRead *.s set ft=asm
  au BufNewFile,BufRead *.tmpl set ft=gohtmltmpl
  au BufNewFile,BufRead go.mod set ft=gomod
endif

if index(g:polyglot_disabled, 'graphql') == -1
  au BufNewFile,BufRead *.graphql,*.graphqls,*.gql set ft=graphql
endif

if index(g:polyglot_disabled, 'gradle') == -1
  au BufNewFile,BufRead *.gradle set ft=groovy
endif

if index(g:polyglot_disabled, 'haml') == -1
  au BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc set ft=haml
endif

if index(g:polyglot_disabled, 'handlebars') == -1
  au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set ft=html.mustache syn=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim indent/handlebars.vim
  au  BufNewFile,BufRead *.handlebars,*.hdbs,*.hbs,*.hb set ft=html.handlebars syn=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif

if index(g:polyglot_disabled, 'haproxy') == -1
  au BufNewFile,BufRead haproxy*.c* set ft=haproxy
endif

if index(g:polyglot_disabled, 'haskell') == -1
  au BufNewFile,BufRead *.hsc set ft=haskell
  au BufNewFile,BufRead *.bpk set ft=haskell
  au BufNewFile,BufRead *.hsig set ft=haskell
endif

if index(g:polyglot_disabled, 'haxe') == -1
  au BufNewFile,BufRead *.hx set ft=haxe
endif

if index(g:polyglot_disabled, 'hcl') == -1
  au BufNewFile,BufRead *.hcl set ft=hcl
  au BufNewFile,BufRead *.nomad set ft=hcl
  au BufNewFile,BufRead *.tf set ft=hcl
  au BufNewFile,BufRead Appfile set ft=hcl
endif

if index(g:polyglot_disabled, 'helm') == -1
  au BufNewFile,BufRead */templates/*.yaml,*/templates/*.tpl set ft=helm
endif

if index(g:polyglot_disabled, 'hive') == -1
  au BufNewFile,BufRead *.hql set ft=hive
  au BufNewFile,BufRead *.ql set ft=hive
  au BufNewFile,BufRead *.q set ft=hive
endif

if index(g:polyglot_disabled, 'i3') == -1
  au BufNewFile,BufRead .i3.config,i3.config,*.i3config,*.i3.config set ft=i3config
endif

if index(g:polyglot_disabled, 'icalendar') == -1
  au BufNewFile,BufRead *.ics set ft=icalendar
endif

if index(g:polyglot_disabled, 'idris') == -1
  au BufNewFile,BufRead *.idr set ft=idris
  au BufNewFile,BufRead idris-response set ft=idris
  au BufNewFile,BufRead *.lidr set ft=lidris
endif

if index(g:polyglot_disabled, 'ion') == -1
  au BufNewFile,BufRead ~/.config/ion/initrc set ft=ion
  au BufNewFile,BufRead *.ion set ft=ion
endif

if index(g:polyglot_disabled, 'javascript') == -1
  au BufNewFile,BufRead *.flow set ft=flow
  au BufNewFile,BufRead *.{js,mjs,cjs,jsm,es,es6},Jakefile set ft=javascript
endif

if index(g:polyglot_disabled, 'jenkins') == -1
  au BufNewFile,BufRead Jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* set ft=Jenkinsfile
  au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead *.Jenkinsfile set ft=Jenkinsfile
endif

if index(g:polyglot_disabled, 'jinja') == -1
  au BufNewFile,BufRead *.jinja2,*.j2,*.jinja,*.nunjucks,*.nunjs,*.njk set ft=jinja
  au BufNewFile,BufRead *.html.jinja2,*.html.j2,*.html.jinja,*.htm.jinja2,*.htm.j2,*.htm.jinja set ft=jinja.html
endif

if index(g:polyglot_disabled, 'json5') == -1
  au BufNewFile,BufRead *.json5 set ft=json5
endif

if index(g:polyglot_disabled, 'json') == -1
  au BufNewFile,BufRead *.json set ft=json
  au BufNewFile,BufRead *.jsonl set ft=json
  au BufNewFile,BufRead *.jsonp set ft=json
  au BufNewFile,BufRead *.geojson set ft=json
  au BufNewFile,BufRead *.template set ft=json
endif

if index(g:polyglot_disabled, 'jst') == -1
  au BufNewFile,BufRead *.ejs set ft=jst
  au BufNewFile,BufRead *.jst set ft=jst
  au BufNewFile,BufRead *.djs set ft=jst
  au BufNewFile,BufRead *.hamljs set ft=jst
  au BufNewFile,BufRead *.ect set ft=jst
endif

if index(g:polyglot_disabled, 'jsx') == -1
  au BufNewFile,BufRead *.jsx set ft=javascriptreact
endif

if index(g:polyglot_disabled, 'julia') == -1
  au BufNewFile,BufRead *.jl set ft=julia
endif

if index(g:polyglot_disabled, 'kotlin') == -1
  au BufNewFile,BufRead *.kt set ft=kotlin
  au BufNewFile,BufRead *.kts set ft=kotlin
endif

if index(g:polyglot_disabled, 'ledger') == -1
  au BufNewFile,BufRead *.ldg,*.ledger,*.journal set ft=ledger
endif

if index(g:polyglot_disabled, 'less') == -1
  au BufNewFile,BufRead *.less set ft=less
endif

if index(g:polyglot_disabled, 'lilypond') == -1
  au BufNewFile,BufRead *.ly,*.ily set ft=lilypond
endif

if index(g:polyglot_disabled, 'livescript') == -1
  au BufNewFile,BufRead *.ls set ft=ls
  au BufNewFile,BufRead *Slakefile set ft=ls
endif

if index(g:polyglot_disabled, 'llvm') == -1
  au BufNewFile,BufRead *.ll set ft=llvm
endif

if index(g:polyglot_disabled, 'llvm') == -1
  au BufNewFile,BufRead lit.*cfg set ft=python
  au BufNewFile,BufRead *.td set ft=tablegen
endif

if index(g:polyglot_disabled, 'log') == -1
  au BufNewFile,BufRead *.log set ft=log
  au BufNewFile,BufRead *_log set ft=log
endif

if index(g:polyglot_disabled, 'mako') == -1
  au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mako set ft=mako
endif

if index(g:polyglot_disabled, 'markdown') == -1
  au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} set ft=markdown
  au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} set ft=markdown
endif

if index(g:polyglot_disabled, 'mathematica') == -1
  au BufNewFile,BufRead *.wl set ft=mma
  au BufNewFile,BufRead *.wls set ft=mma
  au BufNewFile,BufRead *.nb set ft=mma
  au BufNewFile,BufRead *.m set ft=mma
endif

if index(g:polyglot_disabled, 'mdx') == -1
  au BufNewFile,BufRead *.mdx set ft=markdown.mdx
endif

if index(g:polyglot_disabled, 'meson') == -1
  au BufNewFile,BufRead meson.build set ft=meson
  au BufNewFile,BufRead meson_options.txt set ft=meson
  au BufNewFile,BufRead *.wrap set ft=dosini
endif

if index(g:polyglot_disabled, 'moonscript') == -1
  au BufNewFile,BufRead *.moon set ft=moon
endif

if index(g:polyglot_disabled, 'nginx') == -1
  au BufNewFile,BufRead *.nginx set ft=nginx
  au BufNewFile,BufRead nginx*.conf set ft=nginx
  au BufNewFile,BufRead *nginx.conf set ft=nginx
  au BufNewFile,BufRead */etc/nginx/* set ft=nginx
  au BufNewFile,BufRead */usr/local/nginx/conf/* set ft=nginx
  au BufNewFile,BufRead */nginx/*.conf set ft=nginx
endif

if index(g:polyglot_disabled, 'nim') == -1
  au BufNewFile,BufRead *.nim,*.nims,*.nimble set ft=nim
endif

if index(g:polyglot_disabled, 'nix') == -1
  au BufNewFile,BufRead *.nix set ft=nix
endif

if index(g:polyglot_disabled, 'ocaml') == -1
  au BufNewFile,BufRead jbuild,dune,dune-project,dune-workspace set ft=dune
  au BufNewFile,BufRead _oasis set ft=oasis
  au BufNewFile,BufRead *.ml,*.mli,*.mll,*.mly,.ocamlinit,*.mlt,*.mlp,*.mlip,*.mli.cppo,*.ml.cppo set ft=ocaml
  au BufNewFile,BufRead _tags set ft=ocamlbuild_tags
  au BufNewFile,BufRead OMakefile,OMakeroot,*.om,OMakeroot.in set ft=omake
  au BufNewFile,BufRead opam,*.opam,*.opam.template set ft=opam
  au BufNewFile,BufRead *.sexp set ft=sexplib
endif

if index(g:polyglot_disabled, 'opencl') == -1
  au BufNewFile,BufRead *.cl set ft=opencl
endif

if index(g:polyglot_disabled, 'perl') == -1
  au BufNew,BufNewFile,BufRead *.nqp set ft=perl6
endif

if index(g:polyglot_disabled, 'pgsql') == -1
  au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql
endif

if index(g:polyglot_disabled, 'plantuml') == -1
  au BufNewFile,BufRead *.pu,*.uml,*.plantuml,*.puml set ft=plantuml
endif

if index(g:polyglot_disabled, 'pony') == -1
  au BufNewFile,BufRead *.pony set ft=pony
endif

if index(g:polyglot_disabled, 'powershell') == -1
  au BufNewFile,BufRead *.ps1 set ft=ps1
  au BufNewFile,BufRead *.psd1 set ft=ps1
  au BufNewFile,BufRead *.psm1 set ft=ps1
  au BufNewFile,BufRead *.pssc set ft=ps1
  au BufNewFile,BufRead *.ps1xml set ft=ps1xml
  au BufNewFile,BufRead *.cdxml set ft=xml
  au BufNewFile,BufRead *.psc1 set ft=xml
endif

if index(g:polyglot_disabled, 'protobuf') == -1
  au BufNewFile,BufRead *.proto set ft=proto
endif

if index(g:polyglot_disabled, 'pug') == -1
  au BufNewFile,BufRead *.pug set ft=pug
  au BufNewFile,BufRead *.jade set ft=pug
endif

if index(g:polyglot_disabled, 'puppet') == -1
  au BufNewFile,BufRead *.pp set ft=puppet
  au BufNewFile,BufRead *.epp set ft=embeddedpuppet
  au BufNewFile,BufRead Puppetfile set ft=ruby
endif

if index(g:polyglot_disabled, 'purescript') == -1
  au BufNewFile,BufRead *.purs set ft=purescript
endif

if index(g:polyglot_disabled, 'qmake') == -1
  au BufNewFile,BufRead *.pri set ft=qmake
endif

if index(g:polyglot_disabled, 'qmake') == -1
  au BufNewFile,BufRead *.pro set ft=qmake
endif

if index(g:polyglot_disabled, 'qml') == -1
  au BufNewFile,BufRead *.qml set ft=qml
endif

if index(g:polyglot_disabled, 'racket') == -1
  au BufNewFile,BufRead *.rkt,*.rktl set ft=racket
endif

if index(g:polyglot_disabled, 'raku') == -1
  au BufNewFile,BufRead *.pm6,*.p6,*.t6,*.pod6,*.raku,*.rakumod,*.rakudoc,*.rakutest set ft=raku
endif

if index(g:polyglot_disabled, 'raml') == -1
  au BufNewFile,BufRead *.raml set ft=raml
endif

if index(g:polyglot_disabled, 'razor') == -1
  au BufNewFile,BufRead *.cshtml set ft=razor
endif

if index(g:polyglot_disabled, 'reason') == -1
  au BufNewFile,BufRead *.re set ft=reason
  au BufNewFile,BufRead *.rei set ft=reason
  au BufNewFile,BufRead .merlin set ft=merlin
endif

if index(g:polyglot_disabled, 'ruby') == -1
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
endif

" Declared after ruby so that the more general *.rb
" doesn't override
if index(g:polyglot_disabled, 'rspec') == -1
  au BufNewFile,BufRead *_spec.rb set ft=rspec
endif

if index(g:polyglot_disabled, 'rust') == -1
  au BufNewFile,BufRead *.rs set ft=rust
endif

if index(g:polyglot_disabled, 'scala') == -1
  au BufNewFile,BufRead *.scala,*.sc set ft=scala
  au BufNewFile,BufRead *.sbt set ft=sbt.scala
  au BufNewFile,BufRead *.sbt set ft=sbt.scala
endif

if index(g:polyglot_disabled, 'scss') == -1
  au BufNewFile,BufRead *.scss set ft=scss
endif

if index(g:polyglot_disabled, 'slim') == -1
  au BufNewFile,BufRead *.slim set ft=slim
endif

if index(g:polyglot_disabled, 'slime') == -1
  au BufNewFile,BufRead *.slime set ft=slime
endif

if index(g:polyglot_disabled, 'smt2') == -1
  au BufNewFile,BufRead *.smt,*.smt2 set ft=smt2
endif

if index(g:polyglot_disabled, 'solidity') == -1
  au BufNewFile,BufRead *.sol set ft=solidity
endif

if index(g:polyglot_disabled, 'stylus') == -1
  au BufNewFile,BufRead *.styl set ft=stylus
  au BufNewFile,BufRead *.stylus set ft=stylus
endif

if index(g:polyglot_disabled, 'svelte') == -1
  au BufNewFile,BufRead *.svelte set ft=svelte
endif

if index(g:polyglot_disabled, 'swift') == -1
  au BufNewFile,BufRead *.swift set ft=swift
endif

if index(g:polyglot_disabled, 'sxhkd') == -1
  au BufNewFile,BufRead sxhkdrc,*.sxhkdrc set ft=sxhkdrc
endif

if index(g:polyglot_disabled, 'systemd') == -1
  au BufNewFile,BufRead *.automount set ft=systemd
  au BufNewFile,BufRead *.mount set ft=systemd
  au BufNewFile,BufRead *.path set ft=systemd
  au BufNewFile,BufRead *.service set ft=systemd
  au BufNewFile,BufRead *.socket set ft=systemd
  au BufNewFile,BufRead *.swap set ft=systemd
  au BufNewFile,BufRead *.target set ft=systemd
  au BufNewFile,BufRead *.timer set ft=systemd
endif

if index(g:polyglot_disabled, 'terraform') == -1
  au BufNewFile,BufRead *.tf set ft=terraform
  au BufNewFile,BufRead *.tfvars set ft=terraform
  au BufNewFile,BufRead *.tfstate set ft=json
  au BufNewFile,BufRead *.tfstate.backup set ft=json
endif

if index(g:polyglot_disabled, 'textile') == -1
  au BufNewFile,BufRead *.textile set ft=textile
endif

if index(g:polyglot_disabled, 'thrift') == -1
  au BufNewFile,BufRead *.thrift set ft=thrift
endif

if index(g:polyglot_disabled, 'tmux') == -1
  au BufNewFile,BufRead {.,}tmux.conf set ft=tmux
endif

if index(g:polyglot_disabled, 'toml') == -1
  au BufNewFile,BufRead *.toml,Gopkg.lock,Cargo.lock,*/.cargo/config,*/.cargo/credentials,Pipfile set ft=toml
endif

if index(g:polyglot_disabled, 'tptp') == -1
  au BufNewFile,BufRead *.p set ft=tptp
  au BufNewFile,BufRead *.tptp set ft=tptp
  au BufNewFile,BufRead *.ax set ft=tptp
endif

if index(g:polyglot_disabled, 'twig') == -1
  au BufNewFile,BufRead *.twig set ft=html.twig
  au BufNewFile,BufRead *.html.twig set ft=html.twig
  au BufNewFile,BufRead *.xml.twig set ft=xml.twig
endif

if index(g:polyglot_disabled, 'typescript') == -1
  au BufNewFile,BufRead *.ts set ft=typescript
  au BufNewFile,BufRead *.tsx set ft=typescriptreact
endif

if index(g:polyglot_disabled, 'v') == -1
  au BufNewFile,BufRead *.v set ft=vlang
endif

if index(g:polyglot_disabled, 'vala') == -1
  au BufNewFile,BufRead *.vala,*.vapi,*.valadoc set ft=vala
endif

if index(g:polyglot_disabled, 'vbnet') == -1
  au BufNewFile,BufRead *.vb set ft=vbnet
endif

if index(g:polyglot_disabled, 'vcl') == -1
  au BufNewFile,BufRead *.vcl set ft=vcl
endif

if index(g:polyglot_disabled, 'vifm') == -1
  au BufNewFile,BufRead vifmrc set ft=vifm
  au BufNewFile,BufRead *vifm/colors/* set ft=vifm
  au BufNewFile,BufRead *.vifm set ft=vifm
  au BufNewFile,BufRead vifm.rename* set ft=vifm-rename
endif

if index(g:polyglot_disabled, 'vm') == -1
  au BufNewFile,BufRead *.vm set ft=velocity
endif

if index(g:polyglot_disabled, 'vue') == -1
  au BufNewFile,BufRead *.vue,*.wpy set ft=vue
endif

if index(g:polyglot_disabled, 'xdc') == -1
  au BufNewFile,BufRead *.xdc set ft=xdc
endif

if index(g:polyglot_disabled, 'zephir') == -1
  au BufNewFile,BufRead *.zep set ft=zephir
endif

if index(g:polyglot_disabled, 'zig') == -1
  au BufNewFile,BufRead *.zig set ft=zig
  au BufNewFile,BufRead *.zir set ft=zir
endif

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save
