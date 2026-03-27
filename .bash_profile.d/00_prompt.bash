#!/usr/bin/env bash

if [[ -f /usr/lib/git-core/git-sh-prompt ]]; then
    source /usr/lib/git-core/git-sh-prompt
elif [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
    source /usr/share/git/completion/git-prompt.sh
fi

if declare -f __git_ps1 >/dev/null 2>&1; then
    GIT_PS1_SHOWDIRTYSTATE=1
    PS1='[\A] \W$(__git_ps1 " (%s)")\$ '
    export PS1 GIT_PS1_SHOWDIRTYSTATE
fi
