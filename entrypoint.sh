#!/bin/sh

set -e

ls
git status
sh -c "echo $*"
