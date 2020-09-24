#!/bin/bash

#access log files


SCRIPTNAME=$0
function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown error"}" 1>&2
	exit 1
}

if ! [[ -e "/var/log/anaconda/X.log" ]]; then
	error_exit "For some reason /var/log/anaconda/X.log doesn't exist"
elif ! [[ -r "/var/log/anaconda/X.log" ]]; then
	error_exit "Log file '/var/log/anaconda/X.log' is not readable"
fi

#YELLOW [33m
#BLUE [34m

warnings="$(cat /var/log/anaconda/X.log | sed -e 's/]\ (WW/]\ (Warning/g;/Warning/!d;s/Warning/\x1b[33mWarning\x1b[0m/g')"
echo -e "$warnings"
info="$(cat /var/log/anaconda/X.log | sed -e 's/]\ (II/]\ (Information/g;/Information/!d;s/Information/\x1b[34mInformation\x1b[0m/g')"
echo -e "$info"

