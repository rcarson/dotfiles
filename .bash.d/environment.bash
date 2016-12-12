# set vi bindings
set -o vi

## Shell vars
export EDITOR="$(which vim) -e"
export VISUAL="$(which vim)"
export PAGER=$(which less)
