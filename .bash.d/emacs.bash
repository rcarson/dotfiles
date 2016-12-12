if which -s emacs; then
    export VISUAL="$(which emacs) -nw"
    alias emacs="$(which emacs) -nw"
fi
