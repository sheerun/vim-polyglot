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

if !exists('g:python_highlight_all')
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
endif

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
  au BufNewFile,BufRead *.asc setf asciidoc
  au BufNewFile,BufRead *.asciidoc set ft=asciidoc
endif

if index(g:polyglot_disabled, 'autohotkey') == -1
  au BufNewFile,BufRead *.ahk set ft=autohotkey
  au BufNewFile,BufRead *.ahkl set ft=autohotkey
endif

if index(g:polyglot_disabled, 'c/c++') == -1
  au BufNewFile,BufRead *.c set ft=c
  au BufNewFile,BufRead *.cats set ft=c
  au BufNewFile,BufRead *.h setf c
  au BufNewFile,BufRead *.idc set ft=c
  au BufNewFile,BufRead *.c++ set ft=cpp
  au BufNewFile,BufRead *.cc set ft=cpp
  au BufNewFile,BufRead *.cp setf cpp
  au BufNewFile,BufRead *.cpp set ft=cpp
  au BufNewFile,BufRead *.cxx set ft=cpp
  au BufNewFile,BufRead *.h setf cpp
  au BufNewFile,BufRead *.h++ set ft=cpp
  au BufNewFile,BufRead *.hh setf cpp
  au BufNewFile,BufRead *.hpp set ft=cpp
  au BufNewFile,BufRead *.hxx set ft=cpp
  au BufNewFile,BufRead *.inc setf cpp
  au BufNewFile,BufRead *.inl set ft=cpp
  au BufNewFile,BufRead *.ino set ft=cpp
  au BufNewFile,BufRead *.ipp set ft=cpp
  au BufNewFile,BufRead *.re setf cpp
  au BufNewFile,BufRead *.tcc set ft=cpp
  au BufNewFile,BufRead *.tpp set ft=cpp
endif

if index(g:polyglot_disabled, 'c++11') == -1
endif

if index(g:polyglot_disabled, 'caddyfile') == -1
  au BufNewFile,BufRead Caddyfile set ft=caddyfile
endif

if index(g:polyglot_disabled, 'carp') == -1
  au BufNewFile,BufRead *.carp set ft=carp
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

if index(g:polyglot_disabled, 'cmake') == -1
  au BufNewFile,BufRead *.cmake set ft=cmake
  au BufNewFile,BufRead *.cmake.in set ft=cmake
  au BufNewFile,BufRead CMakeLists.txt set ft=cmake
endif

if index(g:polyglot_disabled, 'coffee-script') == -1
  au BufNewFile,BufRead *._coffee set ft=coffee
  au BufNewFile,BufRead *.cake setf coffee
  au BufNewFile,BufRead *.cjsx set ft=coffee
  au BufNewFile,BufRead *.coffee set ft=coffee
  au BufNewFile,BufRead *.coffeekup set ft=coffee
  au BufNewFile,BufRead *.iced set ft=coffee
  au BufNewFile,BufRead Cakefile set ft=coffee
  au BufNewFile,BufRead *.coffee.md set ft=litcoffee
  au BufNewFile,BufRead *.litcoffee set ft=litcoffee
endif

if index(g:polyglot_disabled, 'cjsx') == -1
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
  au BufNewFile,BufRead *.csv set ft=csv
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
  au BufNewFile,BufRead *.d setf d
  au BufNewFile,BufRead *.di set ft=d
  au BufNewFile,BufRead *.lst set ft=dcov
  au BufNewFile,BufRead *.dd set ft=dd
  au BufNewFile,BufRead *.ddoc set ft=ddoc
  au BufNewFile,BufRead *.sdl set ft=dsdl
endif

if index(g:polyglot_disabled, 'dockerfile') == -1
  au BufNewFile,BufRead *.Dockerfile set ft=Dockerfile
  au BufNewFile,BufRead *.dock set ft=Dockerfile
  au BufNewFile,BufRead *.dockerfile set ft=Dockerfile
  au BufNewFile,BufRead Dockerfile set ft=Dockerfile
  au BufNewFile,BufRead Dockerfile* set ft=Dockerfile
  au BufNewFile,BufRead dockerfile set ft=Dockerfile
  au BufNewFile,BufRead docker-compose*.yaml set ft=yaml.docker-compose
  au BufNewFile,BufRead docker-compose*.yml set ft=yaml.docker-compose
endif

if index(g:polyglot_disabled, 'elixir') == -1
  au BufNewFile,BufRead *.ex set ft=elixir
  au BufNewFile,BufRead *.exs set ft=elixir
  au BufNewFile,BufRead mix.lock set ft=elixir
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
  au BufNewFile,BufRead *.es setf erlang
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

if index(g:polyglot_disabled, 'fennel') == -1
  au BufNewFile,BufRead *.fnl set ft=fennel
endif

if index(g:polyglot_disabled, 'ferm') == -1
  au BufNewFile,BufRead *.ferm set ft=ferm
  au BufNewFile,BufRead ferm.conf set ft=ferm
endif

if index(g:polyglot_disabled, 'fish') == -1
  au BufNewFile,BufRead *.fish set ft=fish
endif

if index(g:polyglot_disabled, 'flatbuffers') == -1
  au BufNewFile,BufRead *.fbs set ft=fbs
endif

if index(g:polyglot_disabled, 'fsharp') == -1
  au BufNewFile,BufRead *.fs setf fsharp
  au BufNewFile,BufRead *.fsi set ft=fsharp
  au BufNewFile,BufRead *.fsx set ft=fsharp
endif

if index(g:polyglot_disabled, 'gdscript') == -1
  au BufNewFile,BufRead *.gd setf gdscript3
endif

if index(g:polyglot_disabled, 'git') == -1
  au BufNewFile,BufRead *.gitconfig set ft=gitconfig
  au BufNewFile,BufRead *.git/config set ft=gitconfig
  au BufNewFile,BufRead *.git/modules/**/config set ft=gitconfig
  au BufNewFile,BufRead */.config/git/config set ft=gitconfig
  au BufNewFile,BufRead {.,}gitconfig set ft=gitconfig
  au BufNewFile,BufRead {.,}gitmodules set ft=gitconfig
  au BufNewFile,BufRead gitconfig set ft=gitconfig
  au BufNewFile,BufRead git-rebase-todo set ft=gitrebase
  au BufNewFile,BufRead {.,}gitsendemail.* set ft=gitsendemail
  au BufNewFile,BufRead COMMIT_EDIT_MSG set ft=gitcommit
  au BufNewFile,BufRead MERGE_MSG set ft=gitcommit
  au BufNewFile,BufRead MSG set ft=gitcommit
  au BufNewFile,BufRead TAG_EDIT_MSG set ft=gitcommit
endif

if index(g:polyglot_disabled, 'glsl') == -1
  au BufNewFile,BufRead *.comp set ft=glsl
  au BufNewFile,BufRead *.fp set ft=glsl
  au BufNewFile,BufRead *.frag setf glsl
  au BufNewFile,BufRead *.frg set ft=glsl
  au BufNewFile,BufRead *.fs setf glsl
  au BufNewFile,BufRead *.fsh set ft=glsl
  au BufNewFile,BufRead *.fshader set ft=glsl
  au BufNewFile,BufRead *.geo set ft=glsl
  au BufNewFile,BufRead *.geom set ft=glsl
  au BufNewFile,BufRead *.glsl set ft=glsl
  au BufNewFile,BufRead *.glslf set ft=glsl
  au BufNewFile,BufRead *.glslv set ft=glsl
  au BufNewFile,BufRead *.gs setf glsl
  au BufNewFile,BufRead *.gshader set ft=glsl
  au BufNewFile,BufRead *.shader setf glsl
  au BufNewFile,BufRead *.tesc set ft=glsl
  au BufNewFile,BufRead *.tese set ft=glsl
  au BufNewFile,BufRead *.vert set ft=glsl
  au BufNewFile,BufRead *.vrx set ft=glsl
  au BufNewFile,BufRead *.vsh set ft=glsl
  au BufNewFile,BufRead *.vshader set ft=glsl
endif

if index(g:polyglot_disabled, 'gmpl') == -1
  au BufNewFile,BufRead *.mod setf gmpl
endif

if index(g:polyglot_disabled, 'gnuplot') == -1
  au BufNewFile,BufRead *.gnu set ft=gnuplot
  au BufNewFile,BufRead *.gnuplot set ft=gnuplot
  au BufNewFile,BufRead *.gp set ft=gnuplot
  au BufNewFile,BufRead *.p setf gnuplot
  au BufNewFile,BufRead *.plot set ft=gnuplot
  au BufNewFile,BufRead *.plt set ft=gnuplot
endif

if index(g:polyglot_disabled, 'go') == -1
  au BufNewFile,BufRead *.go set ft=go
  au BufNewFile,BufRead go.mod set ft=gomod
  au BufNewFile,BufRead *.tmpl set ft=gohtmltmpl
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

if index(g:polyglot_disabled, 'haproxy') == -1
  au BufNewFile,BufRead *.cfg setf haproxy
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
  au BufNewFile,BufRead *.workflow setf hcl
  au BufNewFile,BufRead Appfile set ft=hcl
endif

if index(g:polyglot_disabled, 'hive') == -1
  au BufNewFile,BufRead *.hql set ft=hive
  au BufNewFile,BufRead *.q setf hive
  au BufNewFile,BufRead *.hql set ft=hive
  au BufNewFile,BufRead *.q setf hive
endif

if index(g:polyglot_disabled, 'html5') == -1
  au BufNewFile,BufRead *.htm set ft=html
  au BufNewFile,BufRead *.html set ft=html
  au BufNewFile,BufRead *.html.hl set ft=html
  au BufNewFile,BufRead *.inc setf html
  au BufNewFile,BufRead *.st setf html
  au BufNewFile,BufRead *.xht set ft=html
  au BufNewFile,BufRead *.xhtml set ft=html
endif

if index(g:polyglot_disabled, 'i3') == -1
  au BufNewFile,BufRead *.i3.config set ft=i3config
  au BufNewFile,BufRead *.i3config set ft=i3config
  au BufNewFile,BufRead i3.config set ft=i3config
  au BufNewFile,BufRead i3config set ft=i3config
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
  au BufNewFile,BufRead *.es setf javascript
  au BufNewFile,BufRead *.es6 set ft=javascript
  au BufNewFile,BufRead *.frag setf javascript
  au BufNewFile,BufRead *.gs setf javascript
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
  au BufNewFile,BufRead *.flow set ft=flow
endif

if index(g:polyglot_disabled, 'jenkins') == -1
  au BufNewFile,BufRead *.Jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
  au BufNewFile,BufRead Jenkinsfile* set ft=Jenkinsfile
endif

if index(g:polyglot_disabled, 'jinja') == -1
  au BufNewFile,BufRead *.j2 set ft=jinja.html
  au BufNewFile,BufRead *.jinja set ft=jinja.html
  au BufNewFile,BufRead *.jinja2 set ft=jinja.html
endif

if index(g:polyglot_disabled, 'jq') == -1
  au BufNewFile,BufRead *.jq set ft=jq
  au BufNewFile,BufRead {.,}jqrc set ft=jq
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
  au BufNewFile,BufRead *.ice setf json
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
  au BufNewFile,BufRead *.yy setf json
  au BufNewFile,BufRead *.yyp set ft=json
  au BufNewFile,BufRead {.,}arcconfig set ft=json
  au BufNewFile,BufRead {.,}htmlhintrc set ft=json
  au BufNewFile,BufRead {.,}tern-config set ft=json
  au BufNewFile,BufRead {.,}tern-project set ft=json
  au BufNewFile,BufRead {.,}watchmanconfig set ft=json
  au BufNewFile,BufRead composer.lock set ft=json
  au BufNewFile,BufRead mcmod.info set ft=json
endif

if index(g:polyglot_disabled, 'jsonnet') == -1
  au BufNewFile,BufRead *.jsonnet set ft=jsonnet
  au BufNewFile,BufRead *.libsonnet set ft=jsonnet
endif

if index(g:polyglot_disabled, 'jst') == -1
  au BufNewFile,BufRead *.ect set ft=jst
  au BufNewFile,BufRead *.ejs set ft=jst
  au BufNewFile,BufRead *.jst set ft=jst
endif

if !(index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'typescript') != -1 || index(g:polyglot_disabled, 'jsx') != -1)
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
  au BufNewFile,BufRead *.ls setf livescript
  au BufNewFile,BufRead Slakefile set ft=livescript
endif

if index(g:polyglot_disabled, 'llvm') == -1
  au BufNewFile,BufRead *.ll set ft=llvm
  au BufNewFile,BufRead *.td set ft=tablegen
endif

if index(g:polyglot_disabled, 'log') == -1
  au BufNewFile,BufRead *.log set ft=log
  au BufNewFile,BufRead *_log set ft=log
endif

if index(g:polyglot_disabled, 'lua') == -1
  au BufNewFile,BufRead *.fcgi setf lua
  au BufNewFile,BufRead *.lua set ft=lua
  au BufNewFile,BufRead *.nse set ft=lua
  au BufNewFile,BufRead *.p8 set ft=lua
  au BufNewFile,BufRead *.pd_lua set ft=lua
  au BufNewFile,BufRead *.rbxs set ft=lua
  au BufNewFile,BufRead *.rockspec set ft=lua
  au BufNewFile,BufRead *.wlua set ft=lua
  au BufNewFile,BufRead {.,}luacheckrc set ft=lua
endif

if index(g:polyglot_disabled, 'mako') == -1
  au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mako set ft=mako
  au BufNewFile *.*.mao execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufReadPre *.*mao execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
  au BufNewFile,BufRead *.mao set ft=mako
endif

if index(g:polyglot_disabled, 'mathematica') == -1
  au BufNewFile,BufRead *.cdf set ft=mma
  au BufNewFile,BufRead *.m setf mma
  au BufNewFile,BufRead *.ma set ft=mma
  au BufNewFile,BufRead *.mathematica set ft=mma
  au BufNewFile,BufRead *.mt set ft=mma
  au BufNewFile,BufRead *.nb setf mma
  au BufNewFile,BufRead *.nbp set ft=mma
  au BufNewFile,BufRead *.wl set ft=mma
  au BufNewFile,BufRead *.wlt set ft=mma
endif

if index(g:polyglot_disabled, 'markdown') == -1
  au BufNewFile,BufRead *.markdown set ft=markdown
  au BufNewFile,BufRead *.md setf markdown
  au BufNewFile,BufRead *.mdown set ft=markdown
  au BufNewFile,BufRead *.mdwn set ft=markdown
  au BufNewFile,BufRead *.mkd set ft=markdown
  au BufNewFile,BufRead *.mkdn set ft=markdown
  au BufNewFile,BufRead *.mkdown set ft=markdown
  au BufNewFile,BufRead *.ronn set ft=markdown
  au BufNewFile,BufRead *.workbook set ft=markdown
  au BufNewFile,BufRead contents.lr set ft=markdown
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
  au BufNewFile,BufRead *.nginxconf set ft=nginx
  au BufNewFile,BufRead *.vhost setf nginx
  au BufNewFile,BufRead */etc/nginx/* set ft=nginx
  au BufNewFile,BufRead */nginx/*.conf set ft=nginx
  au BufNewFile,BufRead */usr/local/nginx/conf/* set ft=nginx
  au BufNewFile,BufRead *nginx.conf set ft=nginx
  au BufNewFile,BufRead nginx*.conf set ft=nginx
  au BufNewFile,BufRead nginx.conf set ft=nginx
endif

if index(g:polyglot_disabled, 'nim') == -1
  au BufNewFile,BufRead *.nim set ft=nim
  au BufNewFile,BufRead *.nim.cfg set ft=nim
  au BufNewFile,BufRead *.nimble set ft=nim
  au BufNewFile,BufRead *.nimrod set ft=nim
  au BufNewFile,BufRead *.nims set ft=nim
  au BufNewFile,BufRead nim.cfg set ft=nim
endif

if index(g:polyglot_disabled, 'nix') == -1
  au BufNewFile,BufRead *.nix set ft=nix
endif

if index(g:polyglot_disabled, 'objc') == -1
  au BufNewFile,BufRead *.h setf objc
  au BufNewFile,BufRead *.m setf objc
endif

if index(g:polyglot_disabled, 'ocaml') == -1
  au BufNewFile,BufRead *.eliom set ft=ocaml
  au BufNewFile,BufRead *.eliomi set ft=ocaml
  au BufNewFile,BufRead *.ml set ft=ocaml
  au BufNewFile,BufRead *.ml.cppo set ft=ocaml
  au BufNewFile,BufRead *.ml4 set ft=ocaml
  au BufNewFile,BufRead *.mli set ft=ocaml
  au BufNewFile,BufRead *.mli.cppo set ft=ocaml
  au BufNewFile,BufRead *.mlip set ft=ocaml
  au BufNewFile,BufRead *.mll set ft=ocaml
  au BufNewFile,BufRead *.mlp set ft=ocaml
  au BufNewFile,BufRead *.mlt set ft=ocaml
  au BufNewFile,BufRead *.mly set ft=ocaml
  au BufNewFile,BufRead *.om set ft=omake
  au BufNewFile,BufRead OMakefile set ft=omake
  au BufNewFile,BufRead OMakeroot set ft=omake
  au BufNewFile,BufRead Omakeroot.in set ft=omake
  au BufNewFile,BufRead *.opam set ft=opam
  au BufNewFile,BufRead *.opam.template set ft=opam
  au BufNewFile,BufRead opam set ft=opam
  au BufNewFile,BufRead _oasis set ft=oasis
endif

if index(g:polyglot_disabled, 'octave') == -1
  au BufNewFile,BufRead *.oct set ft=octave
endif

if index(g:polyglot_disabled, 'opencl') == -1
  au BufNewFile,BufRead *.cl setf opencl
  au BufNewFile,BufRead *.opencl set ft=opencl
endif

if index(g:polyglot_disabled, 'perl') == -1
  au BufNewFile,BufRead *.al set ft=perl
  au BufNewFile,BufRead *.cgi setf perl
  au BufNewFile,BufRead *.fcgi setf perl
  au BufNewFile,BufRead *.perl set ft=perl
  au BufNewFile,BufRead *.ph set ft=perl
  au BufNewFile,BufRead *.pl setf perl
  au BufNewFile,BufRead *.plx set ft=perl
  au BufNewFile,BufRead *.pm setf perl
  au BufNewFile,BufRead *.psgi set ft=perl
  au BufNewFile,BufRead *.t setf perl
  au BufNewFile,BufRead Makefile.PL set ft=perl
  au BufNewFile,BufRead Rexfile set ft=perl
  au BufNewFile,BufRead ack set ft=perl
  au BufNewFile,BufRead cpanfile set ft=perl
endif

if index(g:polyglot_disabled, 'sql') == -1
  au BufNewFile,BufRead *.bdy set ft=sql
  au BufNewFile,BufRead *.ddl setf sql
  au BufNewFile,BufRead *.fnc set ft=sql
  au BufNewFile,BufRead *.pck set ft=sql
  au BufNewFile,BufRead *.pkb set ft=sql
  au BufNewFile,BufRead *.pks set ft=sql
  au BufNewFile,BufRead *.plb set ft=sql
  au BufNewFile,BufRead *.pls set ft=sql
  au BufNewFile,BufRead *.plsql set ft=sql
  au BufNewFile,BufRead *.prc setf sql
  au BufNewFile,BufRead *.spc set ft=sql
  au BufNewFile,BufRead *.sql setf sql
  au BufNewFile,BufRead *.tpb set ft=sql
  au BufNewFile,BufRead *.tps set ft=sql
  au BufNewFile,BufRead *.trg set ft=sql
  au BufNewFile,BufRead *.vw set ft=sql
endif

if index(g:polyglot_disabled, 'pgsql') == -1
  au BufNewFile,BufRead *.pgsql set ft=sql
endif

if index(g:polyglot_disabled, 'cql') == -1
  au BufNewFile,BufRead *.cql set ft=cql
endif

if index(g:polyglot_disabled, 'php') == -1
  au BufNewFile,BufRead *.aw set ft=php
  au BufNewFile,BufRead *.ctp set ft=php
  au BufNewFile,BufRead *.fcgi setf php
  au BufNewFile,BufRead *.inc setf php
  au BufNewFile,BufRead *.php setf php
  au BufNewFile,BufRead *.php3 set ft=php
  au BufNewFile,BufRead *.php4 set ft=php
  au BufNewFile,BufRead *.php5 set ft=php
  au BufNewFile,BufRead *.phps set ft=php
  au BufNewFile,BufRead *.phpt set ft=php
  au BufNewFile,BufRead {.,}php set ft=php
  au BufNewFile,BufRead {.,}php_cs set ft=php
  au BufNewFile,BufRead {.,}php_cs.dist set ft=php
  au BufNewFile,BufRead Phakefile set ft=php
endif

if index(g:polyglot_disabled, 'blade') == -1
  au BufNewFile,BufRead *.blade set ft=blade
  au BufNewFile,BufRead *.blade.php set ft=blade
endif

if index(g:polyglot_disabled, 'plantuml') == -1
  au BufNewFile,BufRead *.iuml set ft=plantuml
  au BufNewFile,BufRead *.plantuml set ft=plantuml
  au BufNewFile,BufRead *.pu set ft=plantuml
  au BufNewFile,BufRead *.puml set ft=plantuml
  au BufNewFile,BufRead *.uml set ft=plantuml
endif

if index(g:polyglot_disabled, 'pony') == -1
  au BufNewFile,BufRead *.pony set ft=pony
endif

if index(g:polyglot_disabled, 'powershell') == -1
  au BufNewFile,BufRead *.ps1 set ft=powershell
  au BufNewFile,BufRead *.psd1 set ft=powershell
  au BufNewFile,BufRead *.psm1 set ft=powershell
  au BufNewFile,BufRead *.pssc set ft=powershell
  au BufNewFile,BufRead *.ps1xml set ft=ps1xml
endif

if index(g:polyglot_disabled, 'protobuf') == -1
  au BufNewFile,BufRead *.proto set ft=proto
endif

if index(g:polyglot_disabled, 'pug') == -1
  au BufNewFile,BufRead *.jade set ft=pug
  au BufNewFile,BufRead *.pug set ft=pug
endif

if index(g:polyglot_disabled, 'puppet') == -1
  au BufNewFile,BufRead *.pp setf puppet
  au BufNewFile,BufRead Modulefile set ft=puppet
  au BufNewFile,BufRead *.epp set ft=embeddedpuppet
endif

if index(g:polyglot_disabled, 'purescript') == -1
  au BufNewFile,BufRead *.purs set ft=purescript
endif

if index(g:polyglot_disabled, 'python') == -1
  au BufNewFile,BufRead *.cgi setf python
  au BufNewFile,BufRead *.fcgi setf python
  au BufNewFile,BufRead *.gyp set ft=python
  au BufNewFile,BufRead *.gypi set ft=python
  au BufNewFile,BufRead *.lmi set ft=python
  au BufNewFile,BufRead *.py set ft=python
  au BufNewFile,BufRead *.py3 set ft=python
  au BufNewFile,BufRead *.pyde set ft=python
  au BufNewFile,BufRead *.pyi set ft=python
  au BufNewFile,BufRead *.pyp set ft=python
  au BufNewFile,BufRead *.pyt set ft=python
  au BufNewFile,BufRead *.pyw set ft=python
  au BufNewFile,BufRead *.rpy setf python
  au BufNewFile,BufRead *.smk set ft=python
  au BufNewFile,BufRead *.spec setf python
  au BufNewFile,BufRead *.tac set ft=python
  au BufNewFile,BufRead *.wsgi set ft=python
  au BufNewFile,BufRead *.xpy set ft=python
  au BufNewFile,BufRead {.,}gclient set ft=python
  au BufNewFile,BufRead DEPS set ft=python
  au BufNewFile,BufRead SConscript set ft=python
  au BufNewFile,BufRead SConstruct set ft=python
  au BufNewFile,BufRead Snakefile set ft=python
  au BufNewFile,BufRead wscript set ft=python
endif

if index(g:polyglot_disabled, 'python-indent') == -1
endif

if index(g:polyglot_disabled, 'python-compiler') == -1
endif

if index(g:polyglot_disabled, 'requirements') == -1
  au BufNewFile,BufRead *.pip set ft=requirements
  au BufNewFile,BufRead *require.{txt,in} set ft=requirements
  au BufNewFile,BufRead *requirements.{txt,in} set ft=requirements
  au BufNewFile,BufRead constraints.{txt,in} set ft=requirements
endif

if index(g:polyglot_disabled, 'qmake') == -1
  au BufNewFile,BufRead *.pri set ft=qmake
  au BufNewFile,BufRead *.pro setf qmake
endif

if index(g:polyglot_disabled, 'qml') == -1
  au BufNewFile,BufRead *.qbs set ft=qml
  au BufNewFile,BufRead *.qml set ft=qml
endif

if index(g:polyglot_disabled, 'r-lang') == -1
  au BufNewFile,BufRead *.S set ft=r
  au BufNewFile,BufRead *.r setf r
  au BufNewFile,BufRead *.rsx set ft=r
  au BufNewFile,BufRead *.s setf r
  au BufNewFile,BufRead {.,}Rprofile set ft=r
  au BufNewFile,BufRead expr-dist set ft=r
  au BufNewFile,BufRead *.rd set ft=rhelp
endif

if index(g:polyglot_disabled, 'racket') == -1
  au BufNewFile,BufRead *.rkt set ft=racket
  au BufNewFile,BufRead *.rktd set ft=racket
  au BufNewFile,BufRead *.rktl set ft=racket
  au BufNewFile,BufRead *.scrbl set ft=racket
endif

if index(g:polyglot_disabled, 'ragel') == -1
  au BufNewFile,BufRead *.rl set ft=ragel
endif

if index(g:polyglot_disabled, 'raku') == -1
  au BufNewFile,BufRead *.6pl set ft=raku
  au BufNewFile,BufRead *.6pm set ft=raku
  au BufNewFile,BufRead *.nqp set ft=raku
  au BufNewFile,BufRead *.p6 set ft=raku
  au BufNewFile,BufRead *.p6l set ft=raku
  au BufNewFile,BufRead *.p6m set ft=raku
  au BufNewFile,BufRead *.pl setf raku
  au BufNewFile,BufRead *.pl6 set ft=raku
  au BufNewFile,BufRead *.pm setf raku
  au BufNewFile,BufRead *.pm6 set ft=raku
  au BufNewFile,BufRead *.pod6 set ft=raku
  au BufNewFile,BufRead *.raku set ft=raku
  au BufNewFile,BufRead *.rakudoc set ft=raku
  au BufNewFile,BufRead *.rakumod set ft=raku
  au BufNewFile,BufRead *.rakutest set ft=raku
  au BufNewFile,BufRead *.t setf raku
  au BufNewFile,BufRead *.t6 set ft=raku
endif

if index(g:polyglot_disabled, 'raml') == -1
  au BufNewFile,BufRead *.raml set ft=raml
endif

if index(g:polyglot_disabled, 'razor') == -1
  au BufNewFile,BufRead *.cshtml set ft=razor
  au BufNewFile,BufRead *.razor set ft=razor
endif

if index(g:polyglot_disabled, 'reason') == -1
  au BufNewFile,BufRead *.re setf reason
  au BufNewFile,BufRead *.rei set ft=reason
endif

if index(g:polyglot_disabled, 'rst') == -1
  au BufNewFile,BufRead *.rest set ft=rst
  au BufNewFile,BufRead *.rest.txt set ft=rst
  au BufNewFile,BufRead *.rst set ft=rst
  au BufNewFile,BufRead *.rst.txt set ft=rst
endif

if index(g:polyglot_disabled, 'ruby') == -1
  au BufNewFile,BufRead *.axlsx set ft=ruby
  au BufNewFile,BufRead *.builder set ft=ruby
  au BufNewFile,BufRead *.cap set ft=ruby
  au BufNewFile,BufRead *.eye set ft=ruby
  au BufNewFile,BufRead *.fcgi setf ruby
  au BufNewFile,BufRead *.gemspec set ft=ruby
  au BufNewFile,BufRead *.god set ft=ruby
  au BufNewFile,BufRead *.jbuilder set ft=ruby
  au BufNewFile,BufRead *.mspec set ft=ruby
  au BufNewFile,BufRead *.opal set ft=ruby
  au BufNewFile,BufRead *.pluginspec setf ruby
  au BufNewFile,BufRead *.podspec set ft=ruby
  au BufNewFile,BufRead *.rabl set ft=ruby
  au BufNewFile,BufRead *.rake set ft=ruby
  au BufNewFile,BufRead *.rant set ft=ruby
  au BufNewFile,BufRead *.rb set ft=ruby
  au BufNewFile,BufRead *.rbi set ft=ruby
  au BufNewFile,BufRead *.rbuild set ft=ruby
  au BufNewFile,BufRead *.rbw set ft=ruby
  au BufNewFile,BufRead *.rbx set ft=ruby
  au BufNewFile,BufRead *.rjs set ft=ruby
  au BufNewFile,BufRead *.ru set ft=ruby
  au BufNewFile,BufRead *.ruby set ft=ruby
  au BufNewFile,BufRead *.rxml set ft=ruby
  au BufNewFile,BufRead *.spec setf ruby
  au BufNewFile,BufRead *.thor set ft=ruby
  au BufNewFile,BufRead *.watchr set ft=ruby
  au BufNewFile,BufRead {.,}autotest set ft=ruby
  au BufNewFile,BufRead {.,}irbrc set ft=ruby
  au BufNewFile,BufRead {.,}pryrc set ft=ruby
  au BufNewFile,BufRead Appraisals set ft=ruby
  au BufNewFile,BufRead Berksfile set ft=ruby
  au BufNewFile,BufRead Buildfile set ft=ruby
  au BufNewFile,BufRead Capfile set ft=ruby
  au BufNewFile,BufRead Cheffile set ft=ruby
  au BufNewFile,BufRead Dangerfile set ft=ruby
  au BufNewFile,BufRead Deliverfile set ft=ruby
  au BufNewFile,BufRead Fastfile set ft=ruby
  au BufNewFile,BufRead Gemfile set ft=ruby
  au BufNewFile,BufRead Gemfile.lock set ft=ruby
  au BufNewFile,BufRead Guardfile set ft=ruby
  au BufNewFile,BufRead Jarfile set ft=ruby
  au BufNewFile,BufRead KitchenSink set ft=ruby
  au BufNewFile,BufRead Mavenfile set ft=ruby
  au BufNewFile,BufRead Podfile set ft=ruby
  au BufNewFile,BufRead Puppetfile set ft=ruby
  au BufNewFile,BufRead Rakefile set ft=ruby
  au BufNewFile,BufRead Rantfile set ft=ruby
  au BufNewFile,BufRead Routefile set ft=ruby
  au BufNewFile,BufRead Snapfile set ft=ruby
  au BufNewFile,BufRead Thorfile set ft=ruby
  au BufNewFile,BufRead Vagrantfile set ft=ruby
  au BufNewFile,BufRead buildfile set ft=ruby
  au BufNewFile,BufRead *.erb set ft=eruby
  au BufNewFile,BufRead *.erb.deface set ft=eruby
  au BufNewFile,BufRead *.rhtml set ft=eruby
endif

if index(g:polyglot_disabled, 'rspec') == -1
  au BufNewFile,BufRead *_spec.rb set ft=ruby syntax=rspec
endif

if index(g:polyglot_disabled, 'yard') == -1
endif

if index(g:polyglot_disabled, 'brewfile') == -1
  au BufNewFile,BufRead Brewfile set ft=brewfile
endif

if index(g:polyglot_disabled, 'rust') == -1
  au BufNewFile,BufRead *.rs setf rust
  au BufNewFile,BufRead *.rs.in set ft=rust
endif

if index(g:polyglot_disabled, 'scala') == -1
  au BufNewFile,BufRead *.kojo set ft=scala
  au BufNewFile,BufRead *.sc setf scala
  au BufNewFile,BufRead *.scala set ft=scala
endif

if index(g:polyglot_disabled, 'sbt') == -1
  au BufNewFile,BufRead *.sbt set ft=sbt.scala
endif

if index(g:polyglot_disabled, 'scss') == -1
  au BufNewFile,BufRead *.scss set ft=scss
endif

if index(g:polyglot_disabled, 'sh') == -1
  au BufNewFile,BufRead *.bash set ft=sh
  au BufNewFile,BufRead *.bats set ft=sh
  au BufNewFile,BufRead *.cgi setf sh
  au BufNewFile,BufRead *.command set ft=sh
  au BufNewFile,BufRead *.env set ft=sh
  au BufNewFile,BufRead *.fcgi setf sh
  au BufNewFile,BufRead *.ksh set ft=sh
  au BufNewFile,BufRead *.sh set ft=sh
  au BufNewFile,BufRead *.sh.in set ft=sh
  au BufNewFile,BufRead *.tmux set ft=sh
  au BufNewFile,BufRead *.tool set ft=sh
  au BufNewFile,BufRead {.,}bash_aliases set ft=sh
  au BufNewFile,BufRead {.,}bash_history set ft=sh
  au BufNewFile,BufRead {.,}bash_logout set ft=sh
  au BufNewFile,BufRead {.,}bash_profile set ft=sh
  au BufNewFile,BufRead {.,}bashrc set ft=sh
  au BufNewFile,BufRead {.,}cshrc set ft=sh
  au BufNewFile,BufRead {.,}env set ft=sh
  au BufNewFile,BufRead {.,}env.example set ft=sh
  au BufNewFile,BufRead {.,}flaskenv set ft=sh
  au BufNewFile,BufRead {.,}login set ft=sh
  au BufNewFile,BufRead {.,}profile set ft=sh
  au BufNewFile,BufRead 9fs set ft=sh
  au BufNewFile,BufRead PKGBUILD set ft=sh
  au BufNewFile,BufRead bash_aliases set ft=sh
  au BufNewFile,BufRead bash_logout set ft=sh
  au BufNewFile,BufRead bash_profile set ft=sh
  au BufNewFile,BufRead bashrc set ft=sh
  au BufNewFile,BufRead cshrc set ft=sh
  au BufNewFile,BufRead gradlew set ft=sh
  au BufNewFile,BufRead login set ft=sh
  au BufNewFile,BufRead man set ft=sh
  au BufNewFile,BufRead profile set ft=sh
  au BufNewFile,BufRead *.zsh set ft=zsh
  au BufNewFile,BufRead {.,}zlogin set ft=zsh
  au BufNewFile,BufRead {.,}zlogout set ft=zsh
  au BufNewFile,BufRead {.,}zprofile set ft=zsh
  au BufNewFile,BufRead {.,}zshenv set ft=zsh
  au BufNewFile,BufRead {.,}zshrc set ft=zsh
endif

if index(g:polyglot_disabled, 'zinit') == -1
endif

if index(g:polyglot_disabled, 'slim') == -1
  au BufNewFile,BufRead *.slim set ft=slim
endif

if index(g:polyglot_disabled, 'slime') == -1
  au BufNewFile,BufRead *.slime set ft=slime
endif

if index(g:polyglot_disabled, 'smt2') == -1
  au BufNewFile,BufRead *.smt set ft=smt2
  au BufNewFile,BufRead *.smt2 set ft=smt2
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

if index(g:polyglot_disabled, 'svg') == -1
  au BufNewFile,BufRead *.svg set ft=svg
endif

if index(g:polyglot_disabled, 'svg-indent') == -1
endif

if index(g:polyglot_disabled, 'swift') == -1
  au BufNewFile,BufRead *.swift set ft=swift
endif

if index(g:polyglot_disabled, 'sxhkd') == -1
  au BufNewFile,BufRead *.sxhkdrc set ft=sxhkdrc
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
  au BufNewFile,BufRead *.hcl set ft=terraform
  au BufNewFile,BufRead *.tf set ft=terraform
  au BufNewFile,BufRead *.tfvars set ft=terraform
  au BufNewFile,BufRead *.workflow setf terraform
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
  au BufNewFile,BufRead *.toml set ft=toml
  au BufNewFile,BufRead */.cargo/config set ft=toml
  au BufNewFile,BufRead */.cargo/credentials set ft=toml
  au BufNewFile,BufRead Cargo.lock set ft=toml
  au BufNewFile,BufRead Gopkg.lock set ft=toml
  au BufNewFile,BufRead Pipfile set ft=toml
  au BufNewFile,BufRead poetry.lock set ft=toml
endif

if index(g:polyglot_disabled, 'tptp') == -1
  au BufNewFile,BufRead *.ax set ft=tptp
  au BufNewFile,BufRead *.p setf tptp
  au BufNewFile,BufRead *.tptp set ft=tptp
endif

if index(g:polyglot_disabled, 'twig') == -1
  au BufNewFile,BufRead *.twig set ft=html.twig
  au BufNewFile,BufRead *.xml.twig set ft=xml.twig
endif

if index(g:polyglot_disabled, 'typescript') == -1
  au BufNewFile,BufRead *.ts setf typescript
  au BufNewFile,BufRead *.tsx setf typescriptreact
endif

if index(g:polyglot_disabled, 'unison') == -1
  au BufNewFile,BufRead *.u set ft=unison
  au BufNewFile,BufRead *.uu set ft=unison
endif

if index(g:polyglot_disabled, 'v') == -1
  au BufNewFile,BufRead *.v setf v
endif

if index(g:polyglot_disabled, 'vala') == -1
  au BufNewFile,BufRead *.vala set ft=vala
  au BufNewFile,BufRead *.valadoc set ft=vala
  au BufNewFile,BufRead *.vapi set ft=vala
endif

if index(g:polyglot_disabled, 'vbnet') == -1
  au BufNewFile,BufRead *.vb set ft=vbnet
  au BufNewFile,BufRead *.vbhtml set ft=vbnet
endif

if index(g:polyglot_disabled, 'vcl') == -1
  au BufNewFile,BufRead *.vcl set ft=vcl
endif

if index(g:polyglot_disabled, 'velocity') == -1
  au BufNewFile,BufRead *.vm set ft=velocity
endif

if index(g:polyglot_disabled, 'vue') == -1
  au BufNewFile,BufRead *.vue set ft=vue
  au BufNewFile,BufRead *.wpy set ft=vue
endif

if index(g:polyglot_disabled, 'xdc') == -1
  au BufNewFile,BufRead *.xdc set ft=xdc
endif

if index(g:polyglot_disabled, 'xml') == -1
  au BufNewFile,BufRead *.adml set ft=xml
  au BufNewFile,BufRead *.admx set ft=xml
  au BufNewFile,BufRead *.ant set ft=xml
  au BufNewFile,BufRead *.axml set ft=xml
  au BufNewFile,BufRead *.builds set ft=xml
  au BufNewFile,BufRead *.ccproj set ft=xml
  au BufNewFile,BufRead *.ccxml set ft=xml
  au BufNewFile,BufRead *.cdxml set ft=xml
  au BufNewFile,BufRead *.clixml set ft=xml
  au BufNewFile,BufRead *.cproject set ft=xml
  au BufNewFile,BufRead *.cscfg set ft=xml
  au BufNewFile,BufRead *.csdef set ft=xml
  au BufNewFile,BufRead *.csl set ft=xml
  au BufNewFile,BufRead *.csproj set ft=xml
  au BufNewFile,BufRead *.ct set ft=xml
  au BufNewFile,BufRead *.depproj set ft=xml
  au BufNewFile,BufRead *.dita set ft=xml
  au BufNewFile,BufRead *.ditamap set ft=xml
  au BufNewFile,BufRead *.ditaval set ft=xml
  au BufNewFile,BufRead *.dll.config set ft=xml
  au BufNewFile,BufRead *.dotsettings set ft=xml
  au BufNewFile,BufRead *.filters set ft=xml
  au BufNewFile,BufRead *.fsproj set ft=xml
  au BufNewFile,BufRead *.fxml set ft=xml
  au BufNewFile,BufRead *.glade set ft=xml
  au BufNewFile,BufRead *.gml setf xml
  au BufNewFile,BufRead *.gmx set ft=xml
  au BufNewFile,BufRead *.grxml set ft=xml
  au BufNewFile,BufRead *.iml set ft=xml
  au BufNewFile,BufRead *.ivy set ft=xml
  au BufNewFile,BufRead *.jelly set ft=xml
  au BufNewFile,BufRead *.jsproj set ft=xml
  au BufNewFile,BufRead *.kml set ft=xml
  au BufNewFile,BufRead *.launch set ft=xml
  au BufNewFile,BufRead *.mdpolicy set ft=xml
  au BufNewFile,BufRead *.mjml set ft=xml
  au BufNewFile,BufRead *.mm setf xml
  au BufNewFile,BufRead *.mod setf xml
  au BufNewFile,BufRead *.mxml set ft=xml
  au BufNewFile,BufRead *.natvis set ft=xml
  au BufNewFile,BufRead *.ncl setf xml
  au BufNewFile,BufRead *.ndproj set ft=xml
  au BufNewFile,BufRead *.nproj set ft=xml
  au BufNewFile,BufRead *.nuspec set ft=xml
  au BufNewFile,BufRead *.odd set ft=xml
  au BufNewFile,BufRead *.osm set ft=xml
  au BufNewFile,BufRead *.pkgproj set ft=xml
  au BufNewFile,BufRead *.pluginspec setf xml
  au BufNewFile,BufRead *.proj set ft=xml
  au BufNewFile,BufRead *.props set ft=xml
  au BufNewFile,BufRead *.ps1xml set ft=xml
  au BufNewFile,BufRead *.psc1 set ft=xml
  au BufNewFile,BufRead *.pt set ft=xml
  au BufNewFile,BufRead *.rdf set ft=xml
  au BufNewFile,BufRead *.resx set ft=xml
  au BufNewFile,BufRead *.rss set ft=xml
  au BufNewFile,BufRead *.sch setf xml
  au BufNewFile,BufRead *.scxml set ft=xml
  au BufNewFile,BufRead *.sfproj set ft=xml
  au BufNewFile,BufRead *.shproj set ft=xml
  au BufNewFile,BufRead *.srdf set ft=xml
  au BufNewFile,BufRead *.storyboard set ft=xml
  au BufNewFile,BufRead *.sublime-snippet set ft=xml
  au BufNewFile,BufRead *.targets set ft=xml
  au BufNewFile,BufRead *.tml set ft=xml
  au BufNewFile,BufRead *.ui set ft=xml
  au BufNewFile,BufRead *.urdf set ft=xml
  au BufNewFile,BufRead *.ux set ft=xml
  au BufNewFile,BufRead *.vbproj set ft=xml
  au BufNewFile,BufRead *.vcxproj set ft=xml
  au BufNewFile,BufRead *.vsixmanifest set ft=xml
  au BufNewFile,BufRead *.vssettings set ft=xml
  au BufNewFile,BufRead *.vstemplate set ft=xml
  au BufNewFile,BufRead *.vxml set ft=xml
  au BufNewFile,BufRead *.wixproj set ft=xml
  au BufNewFile,BufRead *.workflow setf xml
  au BufNewFile,BufRead *.wsdl set ft=xml
  au BufNewFile,BufRead *.wsf set ft=xml
  au BufNewFile,BufRead *.wxi set ft=xml
  au BufNewFile,BufRead *.wxl set ft=xml
  au BufNewFile,BufRead *.wxs set ft=xml
  au BufNewFile,BufRead *.x3d set ft=xml
  au BufNewFile,BufRead *.xacro set ft=xml
  au BufNewFile,BufRead *.xaml set ft=xml
  au BufNewFile,BufRead *.xib set ft=xml
  au BufNewFile,BufRead *.xlf set ft=xml
  au BufNewFile,BufRead *.xliff set ft=xml
  au BufNewFile,BufRead *.xmi set ft=xml
  au BufNewFile,BufRead *.xml set ft=xml
  au BufNewFile,BufRead *.xml.dist set ft=xml
  au BufNewFile,BufRead *.xproj set ft=xml
  au BufNewFile,BufRead *.xsd set ft=xml
  au BufNewFile,BufRead *.xspec set ft=xml
  au BufNewFile,BufRead *.xul set ft=xml
  au BufNewFile,BufRead *.zcml set ft=xml
  au BufNewFile,BufRead {.,}classpath set ft=xml
  au BufNewFile,BufRead {.,}cproject set ft=xml
  au BufNewFile,BufRead {.,}project set ft=xml
  au BufNewFile,BufRead App.config set ft=xml
  au BufNewFile,BufRead NuGet.config set ft=xml
  au BufNewFile,BufRead Settings.StyleCop set ft=xml
  au BufNewFile,BufRead Web.Debug.config set ft=xml
  au BufNewFile,BufRead Web.Release.config set ft=xml
  au BufNewFile,BufRead Web.config set ft=xml
  au BufNewFile,BufRead packages.config set ft=xml
endif

if index(g:polyglot_disabled, 'xsl') == -1
  au BufNewFile,BufRead *.xsl set ft=xsl
  au BufNewFile,BufRead *.xslt set ft=xsl
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
  au BufNewFile,BufRead {.,}clang-format set ft=yaml
  au BufNewFile,BufRead {.,}clang-tidy set ft=yaml
  au BufNewFile,BufRead {.,}gemrc set ft=yaml
  au BufNewFile,BufRead fish_history set ft=yaml
  au BufNewFile,BufRead fish_read_history set ft=yaml
  au BufNewFile,BufRead glide.lock set ft=yaml
  au BufNewFile,BufRead yarn.lock set ft=yaml
endif

if index(g:polyglot_disabled, 'ansible') == -1
  au BufNewFile,BufRead *.asl set ft=yaml.ansible
  au BufNewFile,BufRead *.dsl set ft=yaml.ansible
  au BufNewFile,BufRead group_vars/* set ft=yaml.ansible
  au BufNewFile,BufRead handlers.*.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead host_vars/* set ft=yaml.ansible
  au BufNewFile,BufRead local.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead main.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead playbook.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead requirements.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead roles.*.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead site.y{a,}ml set ft=yaml.ansible
  au BufNewFile,BufRead tasks.*.y{a,}ml set ft=yaml.ansible
endif

if index(g:polyglot_disabled, 'helm') == -1
  au BufNewFile,BufRead */templates/*.tpl set ft=helm
  au BufNewFile,BufRead */templates/*.yaml set ft=helm
endif

if index(g:polyglot_disabled, 'zephir') == -1
  au BufNewFile,BufRead *.zep set ft=zephir
endif

if index(g:polyglot_disabled, 'zig') == -1
  au BufNewFile,BufRead *.zig set ft=zig
  au BufNewFile,BufRead *.zir set ft=zig
  au BufNewFile,BufRead *.zir set ft=zir
endif

" restore Vi compatibility settings
let &cpo = s:cpo_save
unlet s:cpo_save
