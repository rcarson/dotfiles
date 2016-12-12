export REMOTE_AUTOLOAD_FILES=(
    "http://git.kernel.org/cgit/git/git.git/plain/contrib/completion/git-completion.bash|git-completion.bash"
    "http://git.kernel.org/cgit/git/git.git/plain/contrib/completion/git-prompt.sh|git-prompt.sh"
)

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
