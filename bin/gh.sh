#!/bin/sh

. ~/bin/functions.bash

extra="$1"
if [[ "$extra" == "" ]]; then
  extra="/tree/$(current_git_branch)"`echo "$(pwd)" | sed "s|$(git rev-parse --show-toplevel)||"`
else
  extra="/commit/$(git rev-parse $1)"
fi

open `git config -l | sed -En 's/remote.origin.url=git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'`$extra

