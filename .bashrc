#
#
#

# Source in all .bash.d files
if [[ -d ${HOME}/.bash.d ]]; then
    for file in `find ${HOME}/.bash.d -type f`; do
	source $file
    done
fi
