.PHONY: default build bundle purescript setup

PURS=~/.cabal/bin/purs
#PURS=~/src/node-v7.1.0-linux-x64/bin/purs

default: build bundle

build:
	@# ${PURS} compile $(shell find src/ bower_components/*/src/ -name \*purs)
	pulp build

bundle:
	@# ${PURS} bundle $(shell find output/ -name \*.js) --module Main --main Main -o docroot/package.js
	pulp browserify --optimise -t docroot/package.js

setup:
	npm install -g bower pulp
	npm install
	bower update
