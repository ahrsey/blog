#!/bin/bash
#
# Deploys to gh-pages

set -e

VERSION=0.0

\git branch -D gh-pages
\git checkout -b gh-pages
\sh build.sh
\git ls-files | \grep -v dist | \xargs git rm
\cp -r ./dist/* .
\git rm -r dist
\git add -A
\git commit -m "Deployment ${VERSION}.$(git rev-parse HEAD)"
\git push origin gh-pages --force
\git checkout -
