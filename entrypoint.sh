#!/bin/sh

set -e

env
ls
git status
sh -c "echo $*"
