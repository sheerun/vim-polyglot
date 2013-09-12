#!/bin/sh

set -e

DIRS="
  syntax indent ftplugin ftdetect autoload compiler doc
  after/syntax after/indent
"

copy_dir() {
  if [ -d "tmp/$1" ]; then
    mkdir -p "$1"
    cp -r tmp/$1/* $1/
  fi
}

# Fetches syntax files from given Github repo
syntax() {
  echo "$1..."
  rm -rf tmp
  git clone -q --recursive "https://github.com/$1.git" tmp
  which tree && tree tmp

  for dir in $DIRS; do
    copy_dir "$dir"
  done
}

rm -rf $DIRS

# syntax 'vim-ruby/vim-ruby'
