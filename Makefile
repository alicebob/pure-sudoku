.PHONY: default build bundle purescript setup

PURS=~/.cabal/bin/purs

default: bundle

build:
	${PURS} compile $(shell find . -name \*purs)

bundle:
	${PURS} bundle $(shell find output/ -name \*.js) --module Main --main Main -o docroot/package.js

purescript:
	cabal update
	cabal install purescript

setup:
	git clone --branch v3.0.0 git@github.com:purescript/purescript-console.git dependencies/purescript-console/
	git clone --branch v3.1.0 git@github.com:purescript/purescript-prelude.git dependencies/purescript-prelude/
	git clone --branch v3.1.0 git@github.com:purescript/purescript-eff.git dependencies/purescript-eff/

