#
#
#

# Autoload functions since bash does not support FPATH
if [[ -d ${HOME}/.autoload ]]; then
    declare -xa AUTOLOAD_FILES

    # Autoload all *.sh files, these should all be `sh` compliant
    for file in `find ${HOME}/.autoload -type f -name '*.sh'`; do
	AUTOLOAD_FILES[${#AUTOLOAD_FILES[*]}]=$file
	source $file
    done
    # Autoload all *.bash files, these should all be `bash` compliant
    for file in `find ${HOME}/.autoload -type f -name '*.bash'`; do
	AUTOLOAD_FILES[${#AUTOLOAD_FILES[*]}]=$file
	source $file
    done
fi

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

alias grep="$(which grep) --color=auto"

export REMOTE_AUTOLOAD_FILES=(
    "http://git.kernel.org/cgit/git/git.git/plain/contrib/completion/git-completion.bash|git-completion.bash"
    "http://git.kernel.org/cgit/git/git.git/plain/contrib/completion/git-prompt.sh|git-prompt.sh"
)
