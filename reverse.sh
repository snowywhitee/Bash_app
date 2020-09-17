#!/bin/bash

#file file

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


#critical errors
if ! [[ -e "$1" ]]; then
	error_exit "File '"$1"' not found"
elif ! [[ -r "$1" ]]; then
	error_exit "File '"$1"' is not readable"
elif ! [[ -e "$2" ]]; then
	read -r -p "File '"$2"' not found. Create '"$2"'? [y/N]  " choice
	case "$choice" in
		[yY][eE][sS]|[yY])
			touch "$2"
			;;
		*)
			exit 1
			;;
	esac
elif ! [[ -w "$2" ]]; then
	error_exit "File '"$2"' is not writable"
fi

#warnings
if ! [[ -s "$1" ]]; then
	warning "File '"$1"' is empty, no changes to '"$2"' will be made"
	#do nothing c:
elif [[ "$1" -ef "$2" ]]; then
	warning "You are about to reverse file '"$1"' to itself"
	touch tmp
	tac "$1" >> tmp
	> "$1"
	cat tmp >> "$1"
	rm tmp
elif [[ -s "$2" ]]; then
	warning "File '"$2"' is not empty"
	read -r -p "File '"$2"' is not empty. Overwrite? [y/N] " choice
	case "$choice" in
		[yY][eE][sS]|[yY])
			> "$2"
			reverse $1 $2
			;;
		*)
			reverse $1 $2
			;;
	esac
else
	reverse $1 $2
fi

