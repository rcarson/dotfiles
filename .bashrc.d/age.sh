if [[ -f "${HOME}/.age/rc.key" ]]; then
    export SOPS_AGE_KEY_FILE="$HOME/.age/rc.key"
fi
