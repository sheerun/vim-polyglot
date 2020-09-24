.PHONY: build test dev

build:
	@ scripts/build

test:
	@ scripts/test

dev:
	@ echo "polyglot.vim\npackages.yaml\nheuristics.yaml\nscripts/test\nscripts/build\ntests/extensions.vim" | DEV=1 entr bash -c 'make && make test'
