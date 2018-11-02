#!/bin/sh

set -e

npm i standard-version@next -g
git config --global user.email "${GITHUB_EMAIL}"
git config --global user.name "${GITHUB_ACTOR}"
sh -c "alias git=hub"
sh -c "git pull --tags"
sh -c "standard-version"
git push origin master
git push --tags
