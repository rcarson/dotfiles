#!/usr/bin/env bash

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='[\A] \W$(__git_ps1 " (%s)") \$ '
