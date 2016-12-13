#!/usr/bin/env bash
#
#

# Source in all .bash.d files
if [[ -d ${HOME}/.bash.d ]]; then
    while read -r file; do
	# shellcheck source=/dev/null
	source $file
    done < <(find "${HOME}/.bash.d" -type f)
fi
