#!/bin/bash

#access log files


SCRIPTNAME=$0
function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown error"}" 1>&2
	exit 1
}

if [ "$EUID" -ne 0 ]; then
	error_exit "Please, run as root"
fi

#YELLOW [33m
#BLUE [34m

touch tmp tmp2

cat /var/log/anaconda/X.log >> tmp

sed -i 's/]\ (WW/]\ (Warning/g;s/]\ (II/]\ (Information/g' tmp
cat tmp >> tmp2
sed -i '/Information/!d' tmp
sed -i '/Warning/!d' tmp2

cat tmp2 | sed -e "s/Warning/\x1b[33mWarning\x1b[0m/g"
cat tmp | sed -e "s/Information/\x1b[34mInformation\x1b[0m/g"

rm tmp tmp2
