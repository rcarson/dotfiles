#
#
#

# set vi bindings
set -o vi

## Shell vars
export EDITOR="$(which vim) -e"
export VISUAL="$(which vim)"
export PAGER=$(which less)

# History
export HISTFILE="${HOME}/.$(logname)_history"
export HISTFILESIZE=10000
export HISTSIZE=1000

# Tools/Apps
if which -s emacs; then
    export VISUAL="$(which emacs) -nw"
    alias emacs="$(which emacs) -nw"
fi

if which -s git; then
    alias config="$(which git) --git-dir=${HOME}/.dotfiles/ --work-tree=$HOME"
fi

## Aliases
alias grep="$(which grep) --color=auto"
