#!/bin/bash

#"string example"
SCRIPTNAME=$0

function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

function warning {
	echo "${SCRIPTNAME}: WARNING! $1" 1>&2
	read -r -p "Continue? [y/N] " choice
	case "$choice" in
		[yY][eE][sS]|[yY])
			;;
		*)
			echo "Aborting.."
			exit 1
			;;
	esac
}

function get_len {
	if [[ -z "$1" ]]; then
		echo "0"
	else
		str=$1
		len=${#str}
		echo "$len"
	fi
}

re='^[-+]?(0|[1-9]|[1-9][0-9]+)$'

if [[ $# -eq 0 ]]; then
	error_exit "No arguments provided"
elif [[ "$#" -gt 1 ]]; then
	error_exit "Too many arguments! A single string is expected"
elif [[ $1 =~ $re ]]; then
	warning "You entered a number, shoud it be treated as a string?"
	get_len "$1"
else
	get_len "$1"
fi
