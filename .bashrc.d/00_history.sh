#!/usr/bin/env bash

[[ $- == *i* ]] && shopt -s histappend

# History
HISTFILE="${HOME}/.$(logname)_history"
HISTFILESIZE=10000
HISTSIZE=1000
HISTCONTROL=ignoreboth

export HISTFILE HISTFILESIZE HISTSIZE HISTCONTROL
