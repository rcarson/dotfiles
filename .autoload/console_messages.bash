#!/usr/bin/env bash

declare -i __CON_DEFAULT_STATUS_COLUMNS__=10
declare -i __CON_DEFAULT_MAX_COLUMNS__=79

function __con_max_columns ()
{
    (( COLUMNS >= __CON_DEFAULT_MAX_COLUMNS__ )) && {
	echo "$__CON_DEFAULT_MAX_COLUMNS__"
	return
    }
    echo "$COLUMNS"
}

function __con_status_columns ()
{
    echo "${CON_STATUS_COLUMNS:-$__CON_DEFAULT_STATUS_COLUMNS__}"
}

function __con_max_message_width ()
{
    local -i max_width status_width
    max_width=$(__con_max_columns)
    status_width=$(__con_status_columns)

    echo $((max_width-status_width))
}

function __con_set_cur_column ()
{
    local -i col=${1}
    export __CON_CUR_COLUMN__=$((col+1))
}

function __con_unset_cur_column ()
{
    unset __CON_CUR_COLUMN__
}

function __con_inflight ()
{
    [[ ${__CON_CUR_COLUMN__:+_} == '_' ]] && return 0
    return 1
}

function __con_status_message ()
{
    local message="${*}"
    local -i max_columns
    max_columns=$(__con_max_columns)

    echo "$(tput cuf $((max_columns-__CON_CUR_COLUMN__)))$(tput cub $((${#message}+1)))$message" && {
	__con_unset_cur_column
    }
}
    
function con_message ()
{
    # if we have a message in flight already, reset
    __con_inflight && echo

    local message="${*}"

    message=${message:0:$(__con_max_message_width)}
    echo -n "$message" && {
	__con_set_cur_column "${#message}"
    } || echo
}

function con_success ()
{
    __con_status_message "[OK]"
}

function con_failure ()
{
    __con_status_message "[FAIL]"
}
