#!/bin/bash

SCRIPTNAME=$0

function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

function search {
	grep -r "$2" "$1" 2>/dev/null 1>&1
}

if (( $# < 3 )); then
	error_exit "Too few arguments for $1"
elif (( $# > 3 )); then
	error_exit "Too many arguments for $1"
elif ! [ -d "$2" ]; then
	error_exit "Directory '"$2"' not found"
fi

search $2 $3
