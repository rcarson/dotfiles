#!/usr/bin/env bash

# set vi bindings (interactive only)
[[ $- == *i* ]] && set -o vi

## Shell vars
if which vim >/dev/null 2>&1; then
    EDITOR="$(which vim) -e"
    VISUAL="$(which vim)"
fi

if which less >/dev/null 2>&1; then
    PAGER="$(which less)"
fi

export EDITOR VISUAL PAGER
