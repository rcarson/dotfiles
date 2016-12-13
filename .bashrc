#!/usr/bin/env bash
#
#

# Source in all .bash.d files
if [[ -d ${HOME}/.bash.d ]]; then
    find "${HOME}/.bash.d" -type f | while read -r file; do
	# shellcheck source=/dev/null
	source $file
    done
fi
