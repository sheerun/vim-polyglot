# vim-polyglot [![Build Status][travis-img-url]][travis-url]

[travis-img-url]: https://travis-ci.org/sheerun/vim-polyglot.png
[travis-url]: https://travis-ci.org/sheerun/vim-polyglot

A collection of language packs for Vim.

> One to rule them all, one to find them, one to bring them all and in the darkness bind them.

- It **won't affect your startup time**, as scripts are loaded only on demand\*.
- It **installs 50+ times faster** than 50+ packages it consist of.
- Solid syntax and indentation support. Only the best language packs.
- All unnecessary files are ignored (like enormous documentation from php support).
- No support for esoteric languages, only most popular ones (modern too, like `slim`).
- Each build is tested by automated vimrunner script on CI. See `spec` directory.

\*To be completely honest, concatenated `ftdetect` script takes around `3ms` to load.

## Installation

1. Install Pathogen, Vundle, NeoBundle, or Plug package manager for Vim.
2. Use this repository as submodule or package.

Optionally download one of the [releases](https://github.com/sheerun/vim-polyglot/releases) and unpack it directly under `~/.vim` directory.

## Language packs

- [arduino](https://github.com/sudar/vim-arduino-syntax) (syntax, indent, ftdetect)
- [blade](https://github.com/xsbeats/vim-blade) (syntax, indent, ftdetect)
- [c++11](https://github.com/octol/vim-cpp-enhanced-highlight) (syntax)
- [c/c++](https://github.com/vim-jp/cpp-vim) (syntax)
- [cjsx](https://github.com/mtscout6/vim-cjsx) (ftdetect, syntax, ftplugin)
- [clojure](https://github.com/guns/vim-clojure-static) (syntax, indent, autoload, ftplugin, ftdetect)
- [coffee-script](https://github.com/kchmck/vim-coffee-script) (syntax, indent, compiler, autoload, ftplugin, ftdetect)
- [css](https://github.com/JulesWang/css.vim) (syntax)
- [cucumber](https://github.com/tpope/vim-cucumber) (syntax, indent, compiler, ftplugin, ftdetect)
- [dockerfile](https://github.com/honza/dockerfile.vim) (syntax, ftdetect)
- [elixir](https://github.com/elixir-lang/vim-elixir) (syntax, indent, compiler, ftplugin, ftdetect)
- [emberscript](https://github.com/heartsentwined/vim-ember-script) (syntax, indent, ftplugin, ftdetect)
- [emblem](https://github.com/heartsentwined/vim-emblem) (syntax, indent, ftplugin, ftdetect)
- [erlang](https://github.com/vim-erlang/vim-erlang-runtime) (syntax, indent, ftdetect)
- [git](https://github.com/tpope/vim-git) (syntax, indent, ftplugin, ftdetect)
- [glsl](https://github.com/tikhomirov/vim-glsl) (syntax, indent, ftdetect)
- [go](https://github.com/fatih/vim-go) (syntax, indent, ftdetect)
- [groovy](https://github.com/vim-scripts/groovy.vim) (syntax)
- [haml](https://github.com/tpope/vim-haml) (syntax, indent, compiler, ftplugin, ftdetect)
- [handlebars](https://github.com/mustache/vim-mustache-handlebars) (syntax, ftplugin, ftdetect)
- [haskell](https://github.com/neovimhaskell/haskell-vim) (syntax, indent, ftplugin, ftdetect)
- [haxe](https://github.com/yaymukund/vim-haxe) (syntax, ftdetect)
- [html5](https://github.com/othree/html5.vim) (syntax, indent, autoload, ftplugin)
- [jade](https://github.com/digitaltoad/vim-jade) (syntax, indent, ftplugin, ftdetect)
- [jasmine](https://github.com/glanotte/vim-jasmine) (syntax, ftdetect)
- [javascript](https://github.com/sheerun/yajs.vim) (syntax, indent)
- [json](https://github.com/sheerun/vim-json) (syntax, indent, ftdetect)
- [jst](https://github.com/briancollins/vim-jst) (syntax, indent, ftdetect)
- [jsx](https://github.com/mxw/vim-jsx) (after)
- [julia](https://github.com/dcjones/julia-minimalist-vim) (syntax, indent, ftdetect)
- [kotlin](https://github.com/udalov/kotlin-vim) (syntax, indent, ftdetect)
- [latex](https://github.com/LaTeX-Box-Team/LaTeX-Box) (syntax, indent, ftplugin)
- [less](https://github.com/groenewege/vim-less) (syntax, indent, ftplugin, ftdetect)
- [liquid](https://github.com/tpope/vim-liquid) (syntax, indent, ftplugin, ftdetect)
- [markdown](https://github.com/tpope/vim-markdown) (syntax, ftplugin, ftdetect)
- [nginx](https://github.com/mutewinter/nginx.vim) (syntax, ftdetect)
- [ocaml](https://github.com/jrk/vim-ocaml) (syntax, indent, ftplugin)
- [octave](https://github.com/vim-scripts/octave.vim--) (syntax)
- [opencl](https://github.com/petRUShka/vim-opencl) (syntax, indent, ftplugin, ftdetect)
- [perl](https://github.com/vim-perl/vim-perl) (syntax, indent, ftplugin, ftdetect)
- [php](https://github.com/StanAngeloff/php.vim) (syntax)
- [powershell](https://github.com/Persistent13/vim-ps1) (syntax, indent, ftplugin, ftdetect)
- [protobuf](https://github.com/uarun/vim-protobuf) (syntax, ftdetect)
- [puppet](https://github.com/rodjek/vim-puppet) (syntax, indent, ftplugin, ftdetect)
- [python](https://github.com/mitsuhiko/vim-python-combined) (syntax, indent)
- [qml](https://github.com/peterhoeg/vim-qml) (syntax, indent, ftplugin, ftdetect)
- [ragel](https://github.com/jneen/ragel.vim) (syntax)
- [r-lang](https://github.com/vim-scripts/R.vim) (syntax, ftplugin)
- [rspec](https://github.com/sheerun/rspec.vim) (syntax, ftdetect)
- [ruby](https://github.com/vim-ruby/vim-ruby) (syntax, indent, compiler, autoload, ftplugin, ftdetect)
- [rust](https://github.com/wting/rust.vim) (syntax, indent, compiler, autoload, ftplugin, ftdetect)
- [sbt](https://github.com/derekwyatt/vim-sbt) (syntax, ftdetect)
- [scala](https://github.com/derekwyatt/vim-scala) (syntax, indent, compiler, ftplugin, ftdetect)
- [slim](https://github.com/slim-template/vim-slim) (syntax, indent, ftdetect)
- [solidity](https://github.com/ethereum/vim-solidity) (syntax, indent, ftdetect)
- [stylus](https://github.com/wavded/vim-stylus) (syntax, indent, ftplugin, ftdetect)
- [swift](https://github.com/toyamarinyon/vim-swift) (syntax, indent, ftdetect)
- [systemd](https://github.com/kurayama/systemd-vim-syntax) (syntax, ftdetect)
- [textile](https://github.com/timcharper/textile.vim) (syntax, ftplugin, ftdetect)
- [thrift](https://github.com/solarnz/thrift.vim) (syntax, ftdetect)
- [tmux](https://github.com/tejr/vim-tmux) (syntax, ftdetect)
- [tomdoc](https://github.com/duwanis/tomdoc.vim) (syntax)
- [toml](https://github.com/cespare/vim-toml) (syntax, ftplugin, ftdetect)
- [twig](https://github.com/beyondwords/vim-twig) (syntax, ftplugin, ftdetect)
- [typescript](https://github.com/leafgarland/typescript-vim) (syntax, indent, compiler, ftplugin, ftdetect)
- [vala](https://github.com/tkztmk/vim-vala) (syntax, indent, ftdetect)
- [vbnet](https://github.com/vim-scripts/vbnet.vim) (syntax)
- [vm](https://github.com/lepture/vim-velocity) (syntax, indent, ftdetect)
- [xls](https://github.com/vim-scripts/XSLT-syntax) (syntax)
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
