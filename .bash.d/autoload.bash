#!/usr/bin/env bash

export REMOTE_AUTOLOAD_FILES=(
    "http://git.kernel.org/cgit/git/git.git/plain/contrib/completion/git-completion.bash|git-completion.bash"
    "http://git.kernel.org/cgit/git/git.git/plain/contrib/completion/git-prompt.sh|git-prompt.sh"
)

# Autoload functions since bash does not support FPATH
if [[ -d "${HOME}/.autoload" ]]; then
    declare -xa AUTOLOAD_FILES

    # Autoload all *.sh files, these should all be `sh` compliant
    while read -r file; do
	AUTOLOAD_FILES[${#AUTOLOAD_FILES[*]}]="$file"
	# shellcheck source=/dev/null
	source $file
    done < <(find "${HOME}/.autoload" -type f -name '*.sh')

    # Autoload all *.bash files, these should all be `bash` compliant
    while read -r file; do
	AUTOLOAD_FILES[${#AUTOLOAD_FILES[*]}]="$file"
	# shellcheck source=/dev/null
	source $file
    done < <(find "${HOME}/.autoload" -type f -name '*.bash')

fi
