if [[ -d "${HOME}/.local/go" ]]; then
    GOPATH=$HOME/go
    PATH="$HOME/.local/go/bin:$GOPATH/bin:$PATH"
    export GOPATH PATH
fi


