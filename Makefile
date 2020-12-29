.PHONY: build test dev

build:
	@ scripts/build

test:
	@ scripts/test

dev:
	@ find scripts autoload/polyglot ftdetect tests . -type f -maxdepth 1 | DEV=1 entr bash -c 'make'
