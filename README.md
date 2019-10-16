![vim-polyglot](https://i.imgur.com/9RxQK6k.png)

[![Build Status][travis-img-url]][travis-url] [![Maintenance](https://img.shields.io/maintenance/yes/2019.svg?maxAge=2592000)]()

[travis-img-url]: https://travis-ci.org/sheerun/vim-polyglot.svg
[travis-url]: https://travis-ci.org/sheerun/vim-polyglot

A collection of language packs for Vim.

> One to rule them all, one to find them, one to bring them all and in the darkness bind them.

- It **won't affect your startup time**, as scripts are loaded only on demand\*.
- It **installs and updates 120+ times faster** than the <!--Package Count-->146<!--/Package Count--> packages it consists of.
- Solid syntax and indentation support (other features skipped). Only the best language packs.
- All unnecessary files are ignored (like enormous documentation from php support).
- No support for esoteric languages, only most popular ones (modern too, like `slim`).
- Each build is tested by automated vimrunner script on CI. See `spec` directory.

\*To be completely honest, concatenated `ftdetect` script takes up to `17ms` to load.

## Installation

1. Install [Pathogen](https://github.com/tpope/vim-pathogen), [Vundle](https://github.com/VundleVim/Vundle.vim), [NeoBundle](https://github.com/Shougo/neobundle.vim), or [Plug](https://github.com/junegunn/vim-plug) package manager for Vim.
2. Use this repository as submodule or package.

For example when using [Plug](https://github.com/junegunn/vim-plug):

```
Plug 'sheerun/vim-polyglot'
```

Optionally download one of the [releases](https://github.com/sheerun/vim-polyglot/releases) and unpack it directly under `~/.vim` directory.

You can also use Vim 8 built-in package manager:

```
mkdir -p ~/.vim/pack/default/start
git clone https://github.com/sheerun/vim-polyglot ~/.vim/pack/default/start/vim-polyglot
```

NOTE: Not all features of listed language packs are available. We strip them from functionality slowing vim startup in general (for example we ignore `plugins` folder that is loaded regardless of file type, use `ftplugin` instead).

If you need full functionality of any plugin, please use it directly with your plugin manager.

## Language packs

<!--Language Packs-->
- [acpiasl](https://github.com/martinlroth/vim-acpi-asl) (syntax)
- [ansible](https://github.com/pearofducks/ansible-vim) (syntax, indent, ftplugin)
- [apiblueprint](https://github.com/sheerun/apiblueprint.vim) (syntax)
- [applescript](https://github.com/mityu/vim-applescript) (syntax, indent)
- [arduino](https://github.com/sudar/vim-arduino-syntax) (syntax, indent)
- [asciidoc](https://github.com/asciidoc/vim-asciidoc) (syntax)
- [autohotkey](https://github.com/hnamikaw/vim-autohotkey) (indent)
- [blade](https://github.com/jwalton512/vim-blade) (syntax, indent, ftplugin)
- [c++11](https://github.com/octol/vim-cpp-enhanced-highlight) (syntax)
- [c/c++](https://github.com/vim-jp/vim-cpp) (syntax)
- [caddyfile](https://github.com/isobit/vim-caddyfile) (syntax, indent, ftplugin)
- [carp](https://github.com/hellerve/carp-vim) (syntax)
- [cjsx](https://github.com/mtscout6/vim-cjsx) (syntax, ftplugin)
- [clojure](https://github.com/guns/vim-clojure-static) (syntax, indent, autoload, ftplugin)
- [cmake](https://github.com/pboettch/vim-cmake-syntax) (syntax, indent)
- [coffee-script](https://github.com/kchmck/vim-coffee-script) (syntax, compiler, indent, autoload, ftplugin)
- [cql](https://github.com/elubow/cql-vim) (syntax)
- [cryptol](https://github.com/victoredwardocallaghan/cryptol.vim) (syntax, compiler, ftplugin)
- [crystal](https://github.com/rhysd/vim-crystal) (syntax, indent, autoload, ftplugin)
- [csv](https://github.com/chrisbra/csv.vim) (syntax, autoload, ftplugin)
- [cucumber](https://github.com/tpope/vim-cucumber) (syntax, indent, compiler, ftplugin)
- [cue](https://github.com/mgrabovsky/vim-cuesheet) (syntax)
- [dart](https://github.com/dart-lang/dart-vim-plugin) (syntax, indent, autoload, ftplugin)
- [dhall](https://github.com/vmchale/dhall-vim) (syntax, ftplugin)
- [dlang](https://github.com/JesseKPhillips/d.vim) (syntax, indent)
- [dockerfile](https://github.com/ekalinin/Dockerfile.vim) (syntax, indent, ftplugin)
- [elixir](https://github.com/elixir-lang/vim-elixir) (syntax, indent, compiler, autoload, ftplugin)
- [elm](https://github.com/ElmCast/elm-vim) (syntax, indent, autoload, ftplugin)
- [emberscript](https://github.com/yalesov/vim-ember-script) (syntax, indent, ftplugin)
- [emblem](https://github.com/yalesov/vim-emblem) (syntax, indent, ftplugin)
- [erlang](https://github.com/vim-erlang/vim-erlang-runtime) (syntax, indent)
- [ferm](https://github.com/vim-scripts/ferm.vim) (syntax)
- [fish](https://github.com/georgewitteman/vim-fish) (syntax, indent, compiler, autoload, ftplugin)
- [flatbuffers](https://github.com/dcharbon/vim-flatbuffers) (syntax)
- [fsharp](https://github.com/fsharp/vim-fsharp) (syntax, indent)
- [git](https://github.com/tpope/vim-git) (syntax, indent, ftplugin)
- [glsl](https://github.com/tikhomirov/vim-glsl) (syntax, indent)
- [gmpl](https://github.com/maelvalais/gmpl.vim) (syntax)
- [gnuplot](https://github.com/vim-scripts/gnuplot-syntax-highlighting) (syntax)
- [go](https://github.com/fatih/vim-go) (syntax, compiler, indent)
- [gradle](https://github.com/tfnico/vim-gradle) (compiler)
- [graphql](https://github.com/jparise/vim-graphql) (syntax, indent, autoload, ftplugin, after)
- [groovy-indent](https://github.com/vim-scripts/groovyindent-unix) (indent)
- [groovy](https://github.com/vim-scripts/groovy.vim) (syntax)
- [haml](https://github.com/sheerun/vim-haml) (syntax, indent, compiler, ftplugin)
- [handlebars](https://github.com/mustache/vim-mustache-handlebars) (syntax, indent, ftplugin)
- [haproxy](https://github.com/CH-DanReif/haproxy.vim) (syntax)
- [haskell](https://github.com/neovimhaskell/haskell-vim) (syntax, indent, ftplugin)
- [haxe](https://github.com/yaymukund/vim-haxe) (syntax)
- [hcl](https://github.com/b4b4r07/vim-hcl) (syntax, indent, ftplugin)
- [helm](https://github.com/towolf/vim-helm) (syntax)
- [hive](https://github.com/zebradil/hive.vim) (syntax, ftplugin)
- [html5](https://github.com/othree/html5.vim) (syntax, indent, autoload, ftplugin)
- [i3](https://github.com/mboughaba/i3config.vim) (syntax, ftplugin)
- [idris](https://github.com/idris-hackers/idris-vim) (syntax, indent, ftplugin)
- [ion](https://github.com/vmchale/ion-vim) (syntax, ftplugin)
- [jasmine](https://github.com/glanotte/vim-jasmine) (syntax)
- [javascript](https://github.com/pangloss/vim-javascript) (syntax, indent, compiler, ftplugin, extras)
- [jenkins](https://github.com/martinda/Jenkinsfile-vim-syntax) (syntax, indent)
- [jinja](https://github.com/lepture/vim-jinja) (syntax, indent)
- [json5](https://github.com/GutenYe/json5.vim) (syntax)
- [json](https://github.com/elzr/vim-json) (syntax, indent, ftplugin)
- [jst](https://github.com/briancollins/vim-jst) (syntax, indent)
- [jsx](https://github.com/MaxMEllon/vim-jsx-pretty) (autoload, after)
- [julia](https://github.com/JuliaEditorSupport/julia-vim) (syntax, indent, autoload, ftplugin)
- [kotlin](https://github.com/udalov/kotlin-vim) (syntax, indent, ftplugin)
- [latex](https://github.com/LaTeX-Box-Team/LaTeX-Box) (syntax, indent, ftplugin)
- [less](https://github.com/groenewege/vim-less) (syntax, indent, ftplugin)
- [lilypond](https://github.com/anowlcalledjosh/vim-lilypond) (syntax, indent, compiler, ftplugin)
- [livescript](https://github.com/gkz/vim-ls) (syntax, indent, compiler, ftplugin)
- [llvm](https://github.com/rhysd/vim-llvm) (syntax, indent, ftplugin)
- [log](https://github.com/MTDL9/vim-log-highlighting) (syntax)
- [lua](https://github.com/tbastos/vim-lua) (syntax, indent)
- [mako](https://github.com/sophacles/vim-bundle-mako) (syntax, indent, ftplugin)
- [markdown](https://github.com/plasticboy/vim-markdown) (syntax, indent)
- [mathematica](https://github.com/voldikss/vim-mma) (syntax, ftplugin)
- [mdx](https://github.com/jxnblk/vim-mdx-js) (syntax)
- [meson](https://github.com/mesonbuild/meson) (syntax, indent, ftplugin)
- [moonscript](https://github.com/leafo/moonscript-vim) (syntax, indent, ftplugin)
- [nginx](https://github.com/chr4/nginx.vim) (syntax, indent, ftplugin)
- [nim](https://github.com/zah/nim.vim) (syntax, compiler, indent)
- [nix](https://github.com/LnL7/vim-nix) (syntax, indent, compiler, ftplugin)
- [objc](https://github.com/b4winckler/vim-objc) (ftplugin, syntax, indent)
- [ocaml](https://github.com/rgrinberg/vim-ocaml) (syntax, indent, compiler, ftplugin)
- [octave](https://github.com/McSinyx/vim-octave) (syntax, indent)
- [opencl](https://github.com/petRUShka/vim-opencl) (syntax, indent, ftplugin)
- [perl](https://github.com/vim-perl/vim-perl) (syntax, indent, ftplugin)
- [pgsql](https://github.com/lifepillar/pgsql.vim) (syntax, indent)
- [php](https://github.com/StanAngeloff/php.vim) (syntax)
- [plantuml](https://github.com/aklt/plantuml-syntax) (syntax, indent, ftplugin)
- [pony](https://github.com/jakwings/vim-pony) (syntax, indent, autoload, ftplugin)
- [powershell](https://github.com/PProvost/vim-ps1) (syntax, indent, ftplugin)
- [protobuf](https://github.com/uarun/vim-protobuf) (syntax, indent)
- [pug](https://github.com/digitaltoad/vim-pug) (syntax, indent, ftplugin)
- [puppet](https://github.com/rodjek/vim-puppet) (syntax, indent, autoload, ftplugin)
- [purescript](https://github.com/purescript-contrib/purescript-vim) (syntax, indent, ftplugin)
- [python-compiler](https://github.com/aliev/vim-compiler-python) (compiler, autoload)
- [python-indent](https://github.com/Vimjas/vim-python-pep8-indent) (indent)
- [python](https://github.com/vim-python/python-syntax) (syntax)
- [qmake](https://github.com/artoj/qmake-syntax-vim) (syntax)
- [qml](https://github.com/peterhoeg/vim-qml) (syntax, indent, ftplugin)
- [r-lang](https://github.com/vim-scripts/R.vim) (syntax)
- [racket](https://github.com/wlangstroth/vim-racket) (syntax, indent, ftplugin)
- [ragel](https://github.com/jneen/ragel.vim) (syntax)
- [raml](https://github.com/IN3D/vim-raml) (syntax, ftplugin)
- [reason](https://github.com/reasonml-editor/vim-reason-plus) (syntax, indent)
- [rspec](https://github.com/sheerun/rspec.vim) (syntax)
- [rst](https://github.com/marshallward/vim-restructuredtext) (syntax, autoload, ftplugin)
- [ruby](https://github.com/vim-ruby/vim-ruby) (syntax, indent, compiler, autoload, ftplugin)
- [rust](https://github.com/rust-lang/rust.vim) (syntax, indent, compiler, autoload, ftplugin)
- [sbt](https://github.com/derekwyatt/vim-sbt) (syntax)
- [scala](https://github.com/derekwyatt/vim-scala) (syntax, indent, compiler, ftplugin)
- [scss](https://github.com/cakebaker/scss-syntax.vim) (syntax, indent, ftplugin)
- [slim](https://github.com/slim-template/vim-slim) (syntax, indent, ftplugin)
- [slime](https://github.com/slime-lang/vim-slime-syntax) (syntax, indent)
- [smt2](https://github.com/bohlender/vim-smt2) (syntax, autoload, ftplugin)
- [solidity](https://github.com/tomlion/vim-solidity) (syntax, indent, ftplugin)
- [stylus](https://github.com/wavded/vim-stylus) (syntax, indent, ftplugin)
- [svelte](https://github.com/evanleck/vim-svelte) (syntax, indent)
- [svg-indent](https://github.com/jasonshell/vim-svg-indent) (indent)
- [svg](https://github.com/vim-scripts/svg.vim) (syntax)
- [swift](https://github.com/keith/swift.vim) (syntax, indent, ftplugin)
- [sxhkd](https://github.com/baskerville/vim-sxhkdrc) (syntax)
- [systemd](https://github.com/wgwoods/vim-systemd-syntax) (syntax, ftplugin)
- [terraform](https://github.com/hashivim/vim-terraform) (syntax, indent, autoload, ftplugin)
- [textile](https://github.com/timcharper/textile.vim) (syntax, ftplugin)
- [thrift](https://github.com/solarnz/thrift.vim) (syntax)
- [tmux](https://github.com/ericpruitt/tmux.vim) (syntax, ftplugin)
- [tomdoc](https://github.com/wellbredgrapefruit/tomdoc.vim) (syntax)
- [toml](https://github.com/cespare/vim-toml) (syntax, ftplugin)
- [tptp](https://github.com/c-cube/vim-tptp) (syntax)
- [twig](https://github.com/lumiliet/vim-twig) (syntax, indent, ftplugin)
- [typescript](https://github.com/HerringtonDarkholme/yats.vim) (syntax, indent, compiler, ftplugin)
- [vala](https://github.com/arrufat/vala.vim) (syntax, indent)
- [vbnet](https://github.com/vim-scripts/vbnet.vim) (syntax)
- [vcl](https://github.com/smerrill/vcl-vim-plugin) (syntax)
- [vifm](https://github.com/vifm/vifm.vim) (syntax, autoload, ftplugin)
- [vm](https://github.com/lepture/vim-velocity) (syntax, indent)
- [vue](https://github.com/posva/vim-vue) (syntax, indent, ftplugin)
- [xdc](https://github.com/amal-khailtash/vim-xdc-syntax) (syntax)
- [xls](https://github.com/vim-scripts/XSLT-syntax) (syntax)
- [xml](https://github.com/amadeus/vim-xml) (syntax)
- [yaml](https://github.com/stephpy/vim-yaml) (syntax, ftplugin)
- [yard](https://github.com/sheerun/vim-yardoc) (syntax)
- [zephir](https://github.com/xwsoul/vim-zephir) (syntax)
- [zig](https://github.com/ziglang/zig.vim) (syntax, autoload, ftplugin)
<!--/Language Packs-->

## Updating

You can either wait for new patch release with updates or run the `./build` script by yourself.

## Troubleshooting

Please make sure you have `syntax on` in your `.vimrc`, otherwise syntax files are not loaded at all.

Individual language packs can be disabled by setting `g:polyglot_disabled` as follows:

```viml
" ~/.vimrc
let g:polyglot_disabled = ['css']
```

Note that disabling languages won't make in general your vim startup any faster / slower (only for specific file type). Vim-polyglot is selection of language plugins that are loaded only on demand.

## Contributing

Language packs are periodically updated using automated `build` script.

Feel free to add your language, and send pull-request.  In your pull request, please include:
1. How you chose the particular repo from which to pull support for this language.
2. An updated https://github.com/sheerun/vim-polyglot/blob/master/build .
3. If at all possible, absolutely nothing else (in particular, please don't run `build` and include that in your PR).

The easier it is to validate that the new language won't do anything wacky, the faster it'll be merged.  In particular, languages that utilize global plugins (loaded for every filetype), or plugins with dangerous features (like `call` based on the contents of a file being edited), will never be merged, as they will be slow or dangerous, respectively.

## License

See linked repositories for detailed license information.
