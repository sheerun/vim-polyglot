# vim-polyglot [![Build Status][travis-img-url]][travis-url] [![Maintenance](https://img.shields.io/maintenance/yes/2016.svg?maxAge=2592000)]()

[travis-img-url]: https://travis-ci.org/sheerun/vim-polyglot.svg
[travis-url]: https://travis-ci.org/sheerun/vim-polyglot

A collection of language packs for Vim.

> One to rule them all, one to find them, one to bring them all and in the darkness bind them.

- It **won't affect your startup time**, as scripts are loaded only on demand\*.
- It **installs and updates 70+ times faster** than 70+ packages it consist of.
- Solid syntax and indentation support. Only the best language packs.
- All unnecessary files are ignored (like enormous documentation from php support).
- No support for esoteric languages, only most popular ones (modern too, like `slim`).
- Each build is tested by automated vimrunner script on CI. See `spec` directory.

\*To be completely honest, concatenated `ftdetect` script takes around `3ms` to load.

## Installation

1. Install [Pathogen](https://github.com/tpope/vim-pathogen), [Vundle](https://github.com/VundleVim/Vundle.vim), [NeoBundle](https://github.com/Shougo/neobundle.vim), or [Plug](https://github.com/junegunn/vim-plug) package manager for Vim.
2. Use this repository as submodule or package.

Optionally download one of the [releases](https://github.com/sheerun/vim-polyglot/releases) and unpack it directly under `~/.vim` directory.

## Language packs

- [ansible](https://github.com/pearofducks/ansible-vim) (syntax, indent, ftplugin, ftdetect)
- [arduino](https://github.com/sudar/vim-arduino-syntax) (syntax, indent, ftdetect)
- [blade](https://github.com/jwalton512/vim-blade) (syntax, indent, ftplugin, ftdetect)
- [c++11](https://github.com/octol/vim-cpp-enhanced-highlight) (syntax)
- [c/c++](https://github.com/vim-jp/vim-cpp) (syntax)
- [cjsx](https://github.com/mtscout6/vim-cjsx) (ftdetect, syntax, ftplugin)
- [clojure](https://github.com/guns/vim-clojure-static) (syntax, indent, autoload, ftplugin, ftdetect)
- [coffee-script](https://github.com/kchmck/vim-coffee-script) (syntax, indent, compiler, autoload, ftplugin, ftdetect)
- [cryptol](https://github.com/victoredwardocallaghan/cryptol.vim) (syntax, compiler, ftplugin, ftdetect)
- [crystal](https://github.com/rhysd/vim-crystal) (syntax, indent, autoload, ftplugin, ftdetect)
- [cql](https://github.com/elubow/cql-vim) (syntax, ftdetect)
- [css](https://github.com/JulesWang/css.vim) (syntax)
- [cucumber](https://github.com/tpope/vim-cucumber) (syntax, indent, compiler, ftplugin, ftdetect)
- [dart](https://github.com/dart-lang/dart-vim-plugin) (syntax, indent, autoload, ftplugin, ftdetect)
- [dockerfile](https://github.com/honza/dockerfile.vim) (syntax, ftdetect)
- [elixir](https://github.com/elixir-lang/vim-elixir) (syntax, indent, compiler, ftplugin, ftdetect)
- [elm](https://github.com/lambdatoast/elm.vim) (syntax, indent, autoload, ftplugin, ftdetect)
- [emberscript](https://github.com/heartsentwined/vim-ember-script) (syntax, indent, ftplugin, ftdetect)
- [emblem](https://github.com/heartsentwined/vim-emblem) (syntax, indent, ftplugin, ftdetect)
- [erlang](https://github.com/vim-erlang/vim-erlang-runtime) (syntax, indent, ftdetect)
- [fish](https://github.com/dag/vim-fish) (syntax, indent, compiler, autoload, ftplugin, ftdetect)
- [git](https://github.com/tpope/vim-git) (syntax, indent, ftplugin, ftdetect)
- [glsl](https://github.com/tikhomirov/vim-glsl) (syntax, indent, ftdetect)
- [go](https://github.com/fatih/vim-go) (syntax, compiler, indent, ftdetect)
- [groovy](https://github.com/vim-scripts/groovy.vim) (syntax)
- [haml](https://github.com/tpope/vim-haml) (syntax, indent, compiler, ftplugin, ftdetect)
- [handlebars](https://github.com/mustache/vim-mustache-handlebars) (syntax, indent, ftplugin, ftdetect)
- [haskell](https://github.com/neovimhaskell/haskell-vim) (syntax, indent, ftplugin, ftdetect)
- [haxe](https://github.com/yaymukund/vim-haxe) (syntax, ftdetect)
- [html5](https://github.com/othree/html5.vim) (syntax, indent, autoload, ftplugin)
- [jasmine](https://github.com/glanotte/vim-jasmine) (syntax, ftdetect)
- [javascript](https://github.com/pangloss/vim-javascript) (syntax, indent, ftplugin, ftdetect)
- [json](https://github.com/sheerun/vim-json) (syntax, indent, ftdetect)
- [jst](https://github.com/briancollins/vim-jst) (syntax, indent, ftdetect)
- [jsx](https://github.com/mxw/vim-jsx) (ftdetect, after)
- [julia](https://github.com/dcjones/julia-minimalist-vim) (syntax, indent, ftdetect)
- [kotlin](https://github.com/udalov/kotlin-vim) (syntax, indent, ftdetect)
- [latex](https://github.com/LaTeX-Box-Team/LaTeX-Box) (syntax, indent, ftplugin)
- [less](https://github.com/groenewege/vim-less) (syntax, indent, ftplugin, ftdetect)
- [liquid](https://github.com/tpope/vim-liquid) (syntax, indent, ftplugin, ftdetect)
- [mako](https://github.com/sophacles/vim-bundle-mako) (syntax, indent, ftplugin, ftdetect)
- [markdown](https://github.com/tpope/vim-markdown) (syntax, ftplugin, ftdetect)
- [nginx](https://github.com/othree/nginx-contrib-vim) (syntax, indent, ftdetect)
- [nim](https://github.com/zah/nim.vim) (syntax, compiler, indent, ftdetect)
- [nix](https://github.com/spwhitt/vim-nix) (syntax, ftplugin, ftdetect)
- [objc](https://github.com/b4winckler/vim-objc) (ftplugin, syntax, indent)
- [ocaml](https://github.com/jrk/vim-ocaml) (syntax, indent, ftplugin)
- [octave](https://github.com/vim-scripts/octave.vim--) (syntax)
- [opencl](https://github.com/petRUShka/vim-opencl) (syntax, indent, ftplugin, ftdetect)
- [perl](https://github.com/vim-perl/vim-perl) (syntax, indent, ftplugin, ftdetect)
- [pgsql](https://github.com/exu/pgsql.vim) (syntax, ftdetect)
- [php](https://github.com/StanAngeloff/php.vim) (syntax)
- [plantuml](https://github.com/aklt/plantuml-syntax) (syntax, ftplugin, ftdetect)
- [powershell](https://github.com/Persistent13/vim-ps1) (syntax, indent, ftplugin, ftdetect)
- [protobuf](https://github.com/uarun/vim-protobuf) (syntax, ftdetect)
- [pug](https://github.com/digitaltoad/vim-pug) (syntax, indent, ftplugin, ftdetect)
- [puppet](https://github.com/voxpupuli/vim-puppet) (syntax, indent, ftplugin, ftdetect)
- [purescript](https://github.com/raichoo/purescript-vim) (syntax, indent, ftdetect)
- [python](https://github.com/mitsuhiko/vim-python-combined) (syntax, indent)
- [qml](https://github.com/peterhoeg/vim-qml) (syntax, indent, ftplugin, ftdetect)
- [r-lang](https://github.com/vim-scripts/R.vim) (syntax, ftplugin)
- [ragel](https://github.com/jneen/ragel.vim) (syntax)
- [rspec](https://github.com/sheerun/rspec.vim) (syntax, ftdetect)
- [ruby](https://github.com/vim-ruby/vim-ruby) (syntax, indent, compiler, autoload, ftplugin, ftdetect)
- [rust](https://github.com/rust-lang/rust.vim) (syntax, indent, compiler, autoload, ftplugin, ftdetect)
- [sbt](https://github.com/derekwyatt/vim-sbt) (syntax, ftdetect)
- [scala](https://github.com/derekwyatt/vim-scala) (syntax, indent, compiler, ftplugin, ftdetect)
- [slim](https://github.com/slim-template/vim-slim) (syntax, indent, ftdetect)
- [solidity](https://github.com/ethereum/vim-solidity) (syntax, indent, ftdetect)
- [stylus](https://github.com/wavded/vim-stylus) (syntax, indent, ftplugin, ftdetect)
- [swift](https://github.com/keith/swift.vim) (syntax, indent, ftplugin, ftdetect)
- [systemd](https://github.com/kurayama/systemd-vim-syntax) (syntax, ftdetect)
- [textile](https://github.com/timcharper/textile.vim) (syntax, ftplugin, ftdetect)
- [thrift](https://github.com/solarnz/thrift.vim) (syntax, ftdetect)
- [tmux](https://github.com/tejr/vim-tmux) (syntax, ftdetect)
- [tomdoc](https://github.com/wellbredgrapefruit/tomdoc.vim) (syntax)
- [toml](https://github.com/cespare/vim-toml) (syntax, ftplugin, ftdetect)
- [twig](https://github.com/evidens/vim-twig) (syntax, ftplugin)
- [typescript](https://github.com/leafgarland/typescript-vim) (syntax, indent, compiler, ftplugin, ftdetect)
- [vala](https://github.com/tkztmk/vim-vala) (syntax, indent, ftdetect)
- [vbnet](https://github.com/vim-scripts/vbnet.vim) (syntax)
- [vcl](https://github.com/smerrill/vcl-vim-plugin) (syntax, ftdetect)
- [vm](https://github.com/lepture/vim-velocity) (syntax, indent, ftdetect)
- [xls](https://github.com/vim-scripts/XSLT-syntax) (syntax)
- [yaml](https://github.com/stephpy/vim-yaml) (syntax, ftplugin)
- [yard](https://github.com/sheerun/vim-yardoc) (syntax)

## Disabling a language pack

Individual language packs can be disabled by setting `g:polyglot_disabled`.

```viml
" ~/.vimrc
let g:polyglot_disabled = ['css']
```

Note that disabiling languages won't make in general your vim startup any faster / slower (only for specific file type). Vim-polyglot is selection of language plugins that are loaded only on demand.

## Updating

You can either wait for new patch release with updates or run the `./build` script by yourself.

## Contributing

Language packs are periodically updated using automated `build` script.

Feel free to add your language, and send pull-request.

## License

See linked repositories for detailed license information.
