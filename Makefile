.PHONY: default build bundle dev setup

PURS=~/.cabal/bin/purs
#PURS=~/src/node-v7.1.0-linux-x64/bin/purs

default: build bundle

build:
	pulp build

bundle:
	NODE_ENV=production pulp browserify --optimise -t docroot/package.js

# like `bundle`, but different NODE_ENV
dev: build
	pulp browserify -t docroot/package.js

setup:
	npm install -g bower pulp
	npm install
	bower update
