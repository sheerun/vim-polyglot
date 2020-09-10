.PHONY: all test dev

all:
	@ scripts/build

test:
	@ scripts/test

dev:
	@ (ls && find scripts) | DEV=1 entr bash -c 'make && make test'
