declare -i __CON_DEFAULT_STATUS_COLUMNS__=10
declare -i __CON_DEFAULT_MAX_COLUMNS__=79

function __con_max_columns ()
{
    [[ $COLUMNS -ge $__CON_DEFAULT_MAX_COLUMNS__ ]] && {
	echo $__CON_DEFAULT_MAX_COLUMNS__
	return
    }
    echo $COLUMNS
}

function __con_status_columns ()
{
    echo ${CON_STATUS_COLUMNS:-$__CON_DEFAULT_STATUS_COLUMNS__}
}

function __con_max_message_width ()
{
    local -i max_width=$(__con_max_columns)
    local -i status_width=$(__con_status_columns)
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

function __con_status_message ()
{
    local message="${*}"
    local status_cols=$(__con_status_columns)
    local max_columns=$(__con_max_columns)
    echo "$(tput cuf $((max_columns-__CON_CUR_COLUMN__)))$(tput cub $((${#message}+1)))$message"
    __con_unset_cur_column
}
    
function con_message ()
{
    local message="${*}"
    local message=${message:0:$(__con_max_message_width)}
    echo -n "$message"
    __con_set_cur_column "${#message}"
}

function con_success ()
{
    __con_status_message "[OK]"
}

function con_failure ()
{
    __con_status_message "[FAIL]"
}
