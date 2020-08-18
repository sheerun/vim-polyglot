if index(g:polyglot_disabled, 'acpiasl') == -1
  au BufNewFile,BufRead *.asl set ft=asl
  au BufNewFile,BufRead *.dsl set ft=asl
endif

if index(g:polyglot_disabled, 'apiblueprint') == -1
  au BufNewFile,BufRead *.apib set ft=apiblueprint
endif

if index(g:polyglot_disabled, 'applescript') == -1
  au BufNewFile,BufRead *.applescript set ft=applescript
  au BufNewFile,BufRead *.scpt set ft=applescript
endif

if index(g:polyglot_disabled, 'arduino') == -1
  au BufNewFile,BufRead *.ino set ft=arduino
  au BufNewFile,BufRead *.pde set ft=arduino
endif

if index(g:polyglot_disabled, 'asciidoc') == -1
  au BufNewFile,BufRead *.adoc set ft=asciidoc
  au BufNewFile,BufRead *.asc set ft=asciidoc
  au BufNewFile,BufRead *.asciidoc set ft=asciidoc
endif

if index(g:polyglot_disabled, 'blade') == -1
  au BufNewFile,BufRead *.blade set ft=blade
  au BufNewFile,BufRead *.blade.php set ft=blade
endif

if index(g:polyglot_disabled, 'caddyfile') == -1
  au BufNewFile,BufRead *Caddyfile set ft=caddyfile
endif

if index(g:polyglot_disabled, 'carp') == -1
  au BufNewFile,BufRead *.carp set ft=carp
endif

if index(g:polyglot_disabled, 'coffee-script') == -1
  au BufNewFile,BufRead *._coffee set ft=coffee
  au BufNewFile,BufRead *.cake set ft=coffee
  au BufNewFile,BufRead *.cjsx set ft=coffee
  au BufNewFile,BufRead *.ck set ft=coffee
  au BufNewFile,BufRead *.coffee set ft=coffee
  au BufNewFile,BufRead *.coffeekup set ft=coffee
  au BufNewFile,BufRead *.iced set ft=coffee
  au BufNewFile,BufRead Cakefile set ft=coffee
endif

if index(g:polyglot_disabled, 'coffee-script') == -1
  au BufNewFile,BufRead *.coffee.md set ft=litcoffee
  au BufNewFile,BufRead *.litcoffee set ft=litcoffee
endif

if index(g:polyglot_disabled, 'clojure') == -1
  au BufNewFile,BufRead *.boot set ft=clojure
  au BufNewFile,BufRead *.cl2 set ft=clojure
  au BufNewFile,BufRead *.clj set ft=clojure
  au BufNewFile,BufRead *.cljc set ft=clojure
  au BufNewFile,BufRead *.cljs set ft=clojure
  au BufNewFile,BufRead *.cljs.hl set ft=clojure
  au BufNewFile,BufRead *.cljscm set ft=clojure
  au BufNewFile,BufRead *.cljx set ft=clojure
  au BufNewFile,BufRead *.hic set ft=clojure
  au BufNewFile,BufRead riemann.config set ft=clojure
endif

if index(g:polyglot_disabled, 'cql') == -1
  au BufNewFile,BufRead *.cql set ft=cql
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
endif

if index(g:polyglot_disabled, 'crystal') == -1
  au BufNewFile,BufRead *.ecr set ft=ecrystal
endif

if index(g:polyglot_disabled, 'csv') == -1
  au BufNewFile,BufRead *.csv set ft=csv
  au BufNewFile,BufRead *.dat set ft=csv
  au BufNewFile,BufRead *.tab set ft=csv
  au BufNewFile,BufRead *.tsv set ft=csv
endif

if index(g:polyglot_disabled, 'cucumber') == -1
  au BufNewFile,BufRead *.feature set ft=cucumber
  au BufNewFile,BufRead *.story set ft=cucumber
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
  au BufNewFile,BufRead *.di set ft=d
endif

if index(g:polyglot_disabled, 'dlang') == -1
  au BufNewFile,BufRead *.lst set ft=dcov
endif

if index(g:polyglot_disabled, 'dlang') == -1
  au BufNewFile,BufRead *.dd set ft=dd
endif

if index(g:polyglot_disabled, 'dlang') == -1
  au BufNewFile,BufRead *.ddoc set ft=ddoc
endif

if index(g:polyglot_disabled, 'dlang') == -1
  au BufNewFile,BufRead *.sdl set ft=dsdl
endif

if index(g:polyglot_disabled, 'dockerfile') == -1
  au BufNewFile,BufRead *.Dockerfile set ft=Dockerfile
  au BufNewFile,BufRead *.dock set ft=Dockerfile
  au BufNewFile,BufRead *.dockerfile set ft=Dockerfile
  au BufNewFile,BufRead Dockerfile set ft=Dockerfile
  au BufNewFile,BufRead dockerfile set ft=Dockerfile
  au BufNewFile,BufRead Dockerfile* set ft=Dockerfile
endif

if index(g:polyglot_disabled, 'dockerfile') == -1
  au BufNewFile,BufRead docker-compose*.yaml set ft=yaml.docker-compose
  au BufNewFile,BufRead docker-compose*.yml set ft=yaml.docker-compose
endif

if index(g:polyglot_disabled, 'elixir') == -1
  au BufNewFile,BufRead *.ex set ft=elixir
  au BufNewFile,BufRead *.exs set ft=elixir
  au BufNewFile,BufRead mix.lock set ft=elixir
endif

if index(g:polyglot_disabled, 'elixir') == -1
  au BufNewFile,BufRead *.eex set ft=elixir
  au BufNewFile,BufRead *.leex set ft=elixir
endif

if index(g:polyglot_disabled, 'elm') == -1
  au BufNewFile,BufRead *.elm set ft=elm
endif

if index(g:polyglot_disabled, 'emberscript') == -1
  au BufNewFile,BufRead *.em set ft=ember-script
  au BufNewFile,BufRead *.emberscript set ft=ember-script
endif

if index(g:polyglot_disabled, 'emblem') == -1
  au BufNewFile,BufRead *.emblem set ft=emblem
endif

if index(g:polyglot_disabled, 'erlang') == -1
  au BufNewFile,BufRead *.app set ft=erlang
  au BufNewFile,BufRead *.app.src set ft=erlang
  au BufNewFile,BufRead *.erl set ft=erlang
  au BufNewFile,BufRead *.es set ft=erlang
  au BufNewFile,BufRead *.escript set ft=erlang
  au BufNewFile,BufRead *.hrl set ft=erlang
  au BufNewFile,BufRead *.xrl set ft=erlang
  au BufNewFile,BufRead *.yaws set ft=erlang
  au BufNewFile,BufRead *.yrl set ft=erlang
  au BufNewFile,BufRead Emakefile set ft=erlang
  au BufNewFile,BufRead rebar.config set ft=erlang
  au BufNewFile,BufRead rebar.config.lock set ft=erlang
  au BufNewFile,BufRead rebar.lock set ft=erlang
endif

if index(g:polyglot_disabled, 'ferm') == -1
  au BufNewFile,BufRead *.ferm set ft=ferm
  au BufNewFile,BufRead ferm.conf set ft=ferm
endif

if index(g:polyglot_disabled, 'fish') == -1
  au BufNewFile,BufRead *.fish set ft=fish
endif

if index(g:polyglot_disabled, 'yaml') == -1
  au BufNewFile,BufRead *.mir set ft=yaml
  au BufNewFile,BufRead *.reek set ft=yaml
  au BufNewFile,BufRead *.rviz set ft=yaml
  au BufNewFile,BufRead *.sublime-syntax set ft=yaml
  au BufNewFile,BufRead *.syntax set ft=yaml
  au BufNewFile,BufRead *.yaml set ft=yaml
  au BufNewFile,BufRead *.yaml-tmlanguage set ft=yaml
  au BufNewFile,BufRead *.yaml.sed set ft=yaml
  au BufNewFile,BufRead *.yml set ft=yaml
  au BufNewFile,BufRead *.yml.mysql set ft=yaml
  au BufNewFile,BufRead .clang-format set ft=yaml
  au BufNewFile,BufRead .clang-tidy set ft=yaml
  au BufNewFile,BufRead .gemrc set ft=yaml
  au BufNewFile,BufRead glide.lock set ft=yaml
  au BufNewFile,BufRead yarn.lock set ft=yaml
  au BufNewFile,BufRead fish_history set ft=yaml
  au BufNewFile,BufRead fish_read_history set ft=yaml
endif

if index(g:polyglot_disabled, 'flatbuffers') == -1
  au BufNewFile,BufRead *.fbs set ft=fbs
endif

if index(g:polyglot_disabled, 'fsharp') == -1
  au BufNewFile,BufRead *.fs set ft=fsharp
  au BufNewFile,BufRead *.fsi set ft=fsharp
  au BufNewFile,BufRead *.fsx set ft=fsharp
endif

if index(g:polyglot_disabled, 'gdscript') == -1
  au BufNewFile,BufRead *.gd set ft=gdscript3
endif

if index(g:polyglot_disabled, 'glsl') == -1
  au BufNewFile,BufRead *.comp set ft=glsl
  au BufNewFile,BufRead *.fp set ft=glsl
  au BufNewFile,BufRead *.frag set ft=glsl
  au BufNewFile,BufRead *.frg set ft=glsl
  au BufNewFile,BufRead *.fs set ft=glsl
  au BufNewFile,BufRead *.fsh set ft=glsl
  au BufNewFile,BufRead *.fshader set ft=glsl
  au BufNewFile,BufRead *.geo set ft=glsl
  au BufNewFile,BufRead *.geom set ft=glsl
  au BufNewFile,BufRead *.glsl set ft=glsl
  au BufNewFile,BufRead *.glslf set ft=glsl
  au BufNewFile,BufRead *.glslv set ft=glsl
  au BufNewFile,BufRead *.gs set ft=glsl
  au BufNewFile,BufRead *.gshader set ft=glsl
  au BufNewFile,BufRead *.shader set ft=glsl
  au BufNewFile,BufRead *.tesc set ft=glsl
  au BufNewFile,BufRead *.tese set ft=glsl
  au BufNewFile,BufRead *.vert set ft=glsl
  au BufNewFile,BufRead *.vrx set ft=glsl
  au BufNewFile,BufRead *.vsh set ft=glsl
  au BufNewFile,BufRead *.vshader set ft=glsl
endif

if index(g:polyglot_disabled, 'git') == -1
  au BufNewFile,BufRead *.gitconfig set ft=gitconfig
  au BufNewFile,BufRead .gitconfig set ft=gitconfig
  au BufNewFile,BufRead .gitmodules set ft=gitconfig
  au BufNewFile,BufRead *.git/config set ft=gitconfig
  au BufNewFile,BufRead */.config/git/config set ft=gitconfig
  au BufNewFile,BufRead *.git/modules/**/config set ft=gitconfig
  au BufNewFile,BufRead gitconfig set ft=gitconfig
endif

if index(g:polyglot_disabled, 'git') == -1
  au BufNewFile,BufRead git-rebase-todo set ft=gitrebase
endif

if index(g:polyglot_disabled, 'git') == -1
  au BufNewFile,BufRead .gitsendemail.* set ft=gitsendemail
endif

if index(g:polyglot_disabled, 'git') == -1
  au BufNewFile,BufRead COMMIT_EDIT_MSG set ft=gitcommit
  au BufNewFile,BufRead TAG_EDIT_MSG set ft=gitcommit
  au BufNewFile,BufRead MERGE_MSG set ft=gitcommit
  au BufNewFile,BufRead MSG set ft=gitcommit
endif

if index(g:polyglot_disabled, 'gmpl') == -1
  au BufNewFile,BufRead *.mod set ft=gmpl
endif

if index(g:polyglot_disabled, 'go') == -1
  au BufNewFile,BufRead *.go set ft=go
endif

if index(g:polyglot_disabled, 'go') == -1
  au BufNewFile,BufRead go.mod set ft=gomod
endif

if index(g:polyglot_disabled, 'go') == -1
  au BufNewFile,BufRead *.tmpl set ft=gohtmltmpl
endif

if index(g:polyglot_disabled, 'assembly') == -1
  au BufNewFile,BufRead *.a51 set ft=asm
  au BufNewFile,BufRead *.asm set ft=asm
  au BufNewFile,BufRead *.i set ft=asm
  au BufNewFile,BufRead *.inc set ft=asm
  au BufNewFile,BufRead *.nasm set ft=asm
endif

if index(g:polyglot_disabled, 'graphql') == -1
  au BufNewFile,BufRead *.gql set ft=graphql
  au BufNewFile,BufRead *.graphql set ft=graphql
  au BufNewFile,BufRead *.graphqls set ft=graphql
endif

if index(g:polyglot_disabled, 'gradle') == -1
  au BufNewFile,BufRead *.gradle set ft=groovy
endif

if index(g:polyglot_disabled, 'haml') == -1
  au BufNewFile,BufRead *.haml set ft=haml
  au BufNewFile,BufRead *.haml.deface set ft=haml
  au BufNewFile,BufRead *.hamlbars set ft=haml
  au BufNewFile,BufRead *.hamlc set ft=haml
endif

if index(g:polyglot_disabled, 'handlebars') == -1
  au BufNewFile,BufRead *.handlebars set ft=mustache
  au BufNewFile,BufRead *.hbs set ft=mustache
  au BufNewFile,BufRead *.hjs set ft=mustache
  au BufNewFile,BufRead *.hulk set ft=mustache
  au BufNewFile,BufRead *.mustache set ft=mustache
  au BufNewFile,BufRead *.njk set ft=mustache
endif

if index(g:polyglot_disabled, 'jinja') == -1
  au BufNewFile,BufRead *.jinja set ft=jinja.html
  au BufNewFile,BufRead *.jinja2 set ft=jinja.html
endif

if index(g:polyglot_disabled, 'haproxy') == -1
  au BufNewFile,BufRead *.cfg set ft=haproxy
  au BufNewFile,BufRead haproxy.cfg set ft=haproxy
endif

if index(g:polyglot_disabled, 'haskell') == -1
  au BufNewFile,BufRead *.bpk set ft=haskell
  au BufNewFile,BufRead *.hs set ft=haskell
  au BufNewFile,BufRead *.hs-boot set ft=haskell
  au BufNewFile,BufRead *.hsc set ft=haskell
  au BufNewFile,BufRead *.hsig set ft=haskell
endif

if index(g:polyglot_disabled, 'haxe') == -1
  au BufNewFile,BufRead *.hx set ft=haxe
  au BufNewFile,BufRead *.hxsl set ft=haxe
endif

if index(g:polyglot_disabled, 'hcl') == -1
  au BufNewFile,BufRead *.hcl set ft=hcl
  au BufNewFile,BufRead *.nomad set ft=hcl
  au BufNewFile,BufRead *.tf set ft=hcl
  au BufNewFile,BufRead *.tfvars set ft=hcl
  au BufNewFile,BufRead *.workflow set ft=hcl
  au BufNewFile,BufRead Appfile set ft=hcl
endif

if index(g:polyglot_disabled, 'helm') == -1
  au BufNewFile,BufRead */templates/*.yaml set ft=helm
  au BufNewFile,BufRead */templates/*.tpl set ft=helm
endif

if index(g:polyglot_disabled, 'hive') == -1
  au BufNewFile,BufRead *.hql set ft=hive
  au BufNewFile,BufRead *.q set ft=hive
endif

if index(g:polyglot_disabled, 'i3') == -1
  au BufNewFile,BufRead *.i3.config set ft=i3config
  au BufNewFile,BufRead i3.config set ft=i3config
endif

if index(g:polyglot_disabled, 'hive') == -1
  au BufNewFile,BufRead *.hql set ft=hive
  au BufNewFile,BufRead *.q set ft=hive
endif

if index(g:polyglot_disabled, 'icalendar') == -1
  au BufNewFile,BufRead *.ics set ft=icalendar
endif

if index(g:polyglot_disabled, 'idris') == -1
  au BufNewFile,BufRead *.idr set ft=idris
  au BufNewFile,BufRead *.lidr set ft=idris
  au BufNewFile,BufRead idris-response set ft=idris
endif

if index(g:polyglot_disabled, 'ion') == -1
  au BufNewFile,BufRead *.ion set ft=ion
  au BufNewFile,BufRead ~/.config/ion/initrc set ft=ion
endif

if index(g:polyglot_disabled, 'javascript') == -1
  au BufNewFile,BufRead *._js set ft=javascript
  au BufNewFile,BufRead *.bones set ft=javascript
  au BufNewFile,BufRead *.cjs set ft=javascript
  au BufNewFile,BufRead *.es set ft=javascript
  au BufNewFile,BufRead *.es6 set ft=javascript
  au BufNewFile,BufRead *.frag set ft=javascript
  au BufNewFile,BufRead *.gs set ft=javascript
  au BufNewFile,BufRead *.jake set ft=javascript
  au BufNewFile,BufRead *.js set ft=javascript
  au BufNewFile,BufRead *.jsb set ft=javascript
  au BufNewFile,BufRead *.jscad set ft=javascript
  au BufNewFile,BufRead *.jsfl set ft=javascript
  au BufNewFile,BufRead *.jsm set ft=javascript
  au BufNewFile,BufRead *.jss set ft=javascript
  au BufNewFile,BufRead *.mjs set ft=javascript
  au BufNewFile,BufRead *.njs set ft=javascript
  au BufNewFile,BufRead *.pac set ft=javascript
  au BufNewFile,BufRead *.sjs set ft=javascript
  au BufNewFile,BufRead *.ssjs set ft=javascript
  au BufNewFile,BufRead *.xsjs set ft=javascript
  au BufNewFile,BufRead *.xsjslib set ft=javascript
  au BufNewFile,BufRead Jakefile set ft=javascript
endif

if index(g:polyglot_disabled, 'javascript') == -1
  au BufNewFile,BufRead *.flow set ft=flow
endif

if index(g:polyglot_disabled, 'jenkins') == -1
  au BufNewFile,BufRead *.Jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* set ft=Jenkinsfile
endif

if index(g:polyglot_disabled, 'json5') == -1
  au BufNewFile,BufRead *.json5 set ft=json5
endif

if index(g:polyglot_disabled, 'json') == -1
  au BufNewFile,BufRead *.JSON-tmLanguage set ft=json
  au BufNewFile,BufRead *.avsc set ft=json
  au BufNewFile,BufRead *.geojson set ft=json
  au BufNewFile,BufRead *.gltf set ft=json
  au BufNewFile,BufRead *.har set ft=json
  au BufNewFile,BufRead *.ice set ft=json
  au BufNewFile,BufRead *.json set ft=json
  au BufNewFile,BufRead *.jsonl set ft=json
  au BufNewFile,BufRead *.jsonp set ft=json
  au BufNewFile,BufRead *.mcmeta set ft=json
  au BufNewFile,BufRead *.template set ft=json
  au BufNewFile,BufRead *.tfstate set ft=json
  au BufNewFile,BufRead *.tfstate.backup set ft=json
  au BufNewFile,BufRead *.topojson set ft=json
  au BufNewFile,BufRead *.webapp set ft=json
  au BufNewFile,BufRead *.webmanifest set ft=json
  au BufNewFile,BufRead *.yy set ft=json
  au BufNewFile,BufRead *.yyp set ft=json
  au BufNewFile,BufRead .arcconfig set ft=json
  au BufNewFile,BufRead .htmlhintrc set ft=json
  au BufNewFile,BufRead .tern-config set ft=json
  au BufNewFile,BufRead .tern-project set ft=json
  au BufNewFile,BufRead .watchmanconfig set ft=json
  au BufNewFile,BufRead composer.lock set ft=json
  au BufNewFile,BufRead mcmod.info set ft=json
endif

if index(g:polyglot_disabled, 'jst') == -1
  au BufNewFile,BufRead *.djs set ft=jst
  au BufNewFile,BufRead *.ect set ft=jst
  au BufNewFile,BufRead *.ejs set ft=jst
  au BufNewFile,BufRead *.hamljs set ft=jst
  au BufNewFile,BufRead *.jst set ft=jst
endif

if index(g:polyglot_disabled, 'jsx') == -1
  au BufNewFile,BufRead *.jsx set ft=javascriptreact
endif

if index(g:polyglot_disabled, 'julia') == -1
  au BufNewFile,BufRead *.jl set ft=julia
endif

if index(g:polyglot_disabled, 'kotlin') == -1
  au BufNewFile,BufRead *.kt set ft=kotlin
  au BufNewFile,BufRead *.ktm set ft=kotlin
  au BufNewFile,BufRead *.kts set ft=kotlin
endif

if index(g:polyglot_disabled, 'ledger') == -1
  au BufNewFile,BufRead *.journal set ft=ledger
  au BufNewFile,BufRead *.ldg set ft=ledger
  au BufNewFile,BufRead *.ledger set ft=ledger
endif

if index(g:polyglot_disabled, 'less') == -1
  au BufNewFile,BufRead *.less set ft=less
endif

if index(g:polyglot_disabled, 'lilypond') == -1
  au BufNewFile,BufRead *.ily set ft=lilypond
  au BufNewFile,BufRead *.ly set ft=lilypond
endif

if index(g:polyglot_disabled, 'livescript') == -1
  au BufNewFile,BufRead *._ls set ft=livescript
  au BufNewFile,BufRead *.ls set ft=livescript
  au BufNewFile,BufRead Slakefile set ft=livescript
endif

if index(g:polyglot_disabled, 'llvm') == -1
  au BufNewFile,BufRead *.ll set ft=llvm
endif

if index(g:polyglot_disabled, 'llvm') == -1
  au BufNewFile,BufRead *.td set ft=tablegen
endif
