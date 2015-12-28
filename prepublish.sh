#!/bin/sh
coffee -c -o dist/ src/minitypeahead.coffee;
cat node_modules/latinize/dist/latinize.js dist/minitypeahead.js > dist/bundle.js
minify dist/bundle.js;
minify dist/minitypeahead.js;