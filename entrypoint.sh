#!/bin/sh

set -e

npm i standard-version@next -g
sh -c "standard-version"
git push --tags
git push origin master
