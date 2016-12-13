#!/usr/bin/env bash

if which -s emacs; then
    VISUAL="$(which emacs) -nw"
    export VISUAL
    
    alias emacs='$(which emacs) -nw'
fi
