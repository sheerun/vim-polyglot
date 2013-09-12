#!/bin/sh

set -E

DIRS="
  syntax indent ftplugin ftdetect autoload compiler
  after/syntax after/indent
"

copy_dir() {
  if [ -d "$1/$2" ]; then
    mkdir -p "$2"
    cp -r $1/$2/* $2/
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
syntax 'acustodioo/vim-tmux' &
syntax 'groenewege/vim-less' &
syntax 'wavded/vim-stylus' &
syntax 'tpope/vim-cucumber' &
syntax 'jrk/vim-ocaml' &
syntax 'wlangstroth/vim-haskell' &
syntax 'slim-template/vim-slim' &
syntax 'vim-scripts/XSLT-syntax' &
syntax 'vim-scripts/python.vim--Vasiliev' &
syntax 'vim-scripts/octave.vim--' &

wait

rm -rf tmp
