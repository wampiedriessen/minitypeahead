#!/bin/sh
coffee -c -o dist/ src/minitypeahead.coffee;
minify dist/minitypeahead.js;
cat node_modules/latinize/dist/latinize.min.js dist/minitypeahead.min.js > dist/bundle.js