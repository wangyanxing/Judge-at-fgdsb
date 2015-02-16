#!/bin/bash

# change to current dir
SCRIPT_DIR=$(dirname $(cd "$(dirname "$BASH_SOURCE")"; pwd))

cd $1
git add -A
git commit -m $2
git push origin updates