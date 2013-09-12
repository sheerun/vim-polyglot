#!/usr/bin/env zsh

set -E
setopt extended_glob

DIRS=(
  syntax indent ftplugin ftdetect autoload compiler
  after/syntax after/indent after/ftplugin after/ftdetect
)

copy_dir() {
  if [ -d "$1/$2" ]; then
    for file in $(find "$1/$2" -name '*.vim'); do
      file_path="$(dirname "${file##$1/}")"
      mkdir -p "$file_path"
      cp $file $file_path/
    done
  fi
}

# Fetches syntax files from given Github repo
syntax() {
  dir="tmp/$(echo "$1" | cut -d '/' -f 2)"
  echo "$1..."
  rm -rf "$dir"
  git clone -q --recursive "https://github.com/$1.git" "$dir"
  which tree > /dev/null && tree tmp

  for subdir in $DIRS; do
    copy_dir "$dir" "$subdir"
  done
}

rm -rf tmp
rm -rf $DIRS
mkdir -p tmp

syntax 'vim-ruby/vim-ruby' &
syntax 'kchmck/vim-coffee-script' &
syntax 'tpope/vim-haml' &
syntax 'tpope/vim-bundler' &
syntax 'pangloss/vim-javascript' &
syntax 'leshill/vim-json' &
syntax 'mutewinter/tomdoc.vim' &
syntax 'mutewinter/nginx.vim' &
syntax 'timcharper/textile.vim' &
syntax 'tpope/vim-markdown' &
syntax 'acustodioo/vim-tmux' &
syntax 'groenewege/vim-less' &
syntax 'wavded/vim-stylus' &
syntax 'tpope/vim-cucumber' &
syntax 'jrk/vim-ocaml' &
syntax 'slim-template/vim-slim' &
syntax 'vim-scripts/XSLT-syntax' &
syntax 'vim-scripts/python.vim--Vasiliev' &
syntax 'vim-scripts/octave.vim--' &
syntax 'jnwhiteh/vim-golang' &
syntax 'spf13/PIV' &
syntax 'briancollins/vim-jst' &
syntax 'derekwyatt/vim-scala' &
syntax 'derekwyatt/vim-sbt' &
syntax 'travitch/hasksyn' &
syntax 'vim-scripts/Puppet-Syntax-Highlighting' &
syntax 'beyondwords/vim-twig' &
syntax 'sudar/vim-arduino-syntax' &
syntax 'guns/vim-clojure-static' &
syntax 'chrisbra/csv.vim' &
syntax 'elixir-lang/vim-elixir' &
syntax 'jimenezrick/vimerl' &
syntax 'tpope/vim-git' &

wait

rm -rf tmp
