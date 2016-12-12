if which -s git; then
    alias config="$(which git) --git-dir=${HOME}/.dotfiles/ --work-tree=$HOME"
fi
