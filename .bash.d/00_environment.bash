#!/usr/bin/env bash

# set vi bindings
set -o vi

## Shell vars
EDITOR="$(which vim) -e"
VISUAL="$(which vim)"
PAGER=$(which less)

export EDITOR VISUAL PAGER
