#!/usr/bin/env bash
[[ $- == *i* ]] || return

alias grep='$(which grep) --color=auto'
