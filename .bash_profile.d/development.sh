# Functions
function commit {
    message="${@}"
    git commit -m "$message"
}

