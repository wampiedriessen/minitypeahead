#!/bin/sh
cake build
cat node_modules/latinize/dist/latinize.js lib/minitypeahead.js > lib/bundle.js
# minify dist/avl.js
# minify dist/bundle.js
# minify dist/minitypeahead.js
