.PHONY: all test dev

all:
	@ scripts/build

test:
	@ scripts/test

dev:
	@ echo "packages.yaml\nheuristics.yaml\nscripts/test\nscripts/build\nscripts/test_extensions.vim" | DEV=1 entr bash -c 'make && make test'
