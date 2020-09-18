#!/bin/bash

SCRIPTNAME=$0

function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

function search {
	touch tmp
	grep -r --exclude=tmp "$2" "$1" >/dev/null > tmp
	cat tmp
	rm tmp
}

if ! [ -d "$1" ]; then
	error_exit "Directory '"$1"' not found"
fi

search $1 $2
