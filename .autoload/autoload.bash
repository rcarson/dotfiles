#!/usr/bin/env bash

function update_remote_autoload_files ()
{
    cd "${AUTOLOAD_DIR:-${HOME}/.autoload}" || return

    # loop through list of files
    for remote_url in "${REMOTE_AUTOLOAD_FILES[@]}"; do
	destination="${remote_url#*|}"   # grab second value
	remote_url="${remote_url%|*}"    # grab first value


	if [[ "$remote_url" == "$destination" ]]; then
	    unset destination
	    continue
	fi    

	con_message "Updating ${destination}"
	if curl -fsSL ${destination:+-o $destination} "$remote_url" 2>/dev/null; then
	    con_success
	else
	    con_failure
	fi
    done

    cd "${OLDPWD}" || return
}
