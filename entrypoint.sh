#!/bin/sh

set -e

npm i standard-version
ls
echo "got here"
sh -c "./node_modules/.bin/standard-version"
