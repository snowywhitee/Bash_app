#!/bin/bash

SCRIPTNAME=$0

function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

function warning {
	echo "${SCRIPTNAME}: WARNING! $1" 1>&2
	read -r -p "Coninue? [y/N] " choice
	case "$choice" in
		[yY][eE][sS]|[yY])
			;;
		*)
			echo "Aborting.."
			exit 1
			;;
	esac
}

function reverse {
	tac "$1" >> "$2" || error_exit "Reverse was not complete"
}

#arguments
if (( $# < 3 )); then
	error_exit "Too few arguments for $1"
elif (( $# > 3 )); then
	error_exit "Too many arguments for $1"
fi

#critical errors
if ! [[ -e "$2" ]]; then
	error_exit "File '"$1"' not found"
elif ! [[ -r "$2" ]]; then
	error_exit "File '"$1"' is not readable"
elif ! [[ -e "$3" ]]; then
	read -r -p "File '"$3"' not found. Create '"$3"'? [y/N]  " choice
	case "$choice" in
		[yY][eE][sS]|[yY])
			touch "$3" 2>/dev/null || error_exit "Permission to create '"$2"' denied"
			;;
		*)
			exit 1
			;;
	esac
elif ! [[ -w "$3" ]]; then
	error_exit "File '"$3"' is not writable"
fi

#warnings
if ! [[ -s "$2" ]]; then
	warning "File '"$2"' is empty, no changes to '"$2"' will be made"
	#do nothing c:
elif [[ "$2" -ef "$3" ]]; then
	warning "You are about to reverse file '"$2"' to itself"
	sed -i '1!G;h;$!d' "$2"
elif [[ -s "$3" ]]; then
	read -r -p "File '"$3"' is not empty, o-Overwrite, a-append [o/a] " choice
	case "$choice" in
		[oO])
			> "$3"
			reverse $2 $3
			;;
		*)
			reverse $2 $3
			;;
	esac
else
	reverse $2 $3
fi

