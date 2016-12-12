#
#
#

# set vi bindings
set -o vi

## Shell vars
EDITOR=$(which emacs)
PAGER=$(which less)

# History
HISTFILE="${HOME}/.$(logname)_history"
HISTFILESIZE=10000
HISTSIZE=1000

## Aliases
if which -s emacs; then
    alias emacs="$(which emacs) -nw"
fi

if which -s git; then
    alias dotfile="$(which git) --git-dir=${HOME}/.dotfiles/ --work-tree=$HOME"
fi

alias grep="$(which grep) --color=auto"
