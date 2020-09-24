#!/bin/bash

#calc sum 1 2

SCRIPTNAME=$0

function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

#check if all the scripts are available
if [ ! -e "calc.sh" ] || [ ! -e "strlen.sh" ] || [ ! -e "reverse.sh" ] || [ ! -e "search.sh" ] || [ ! -e "interactive.sh" ] || [ ! -e "log.sh" ]; then
	echo "WARNING: Some scripts are not available! some functions may not work"
fi



if [ $# -eq 0 ]; then
	error_exit "No arguments provided. See help for options"
else
	if [[ $1 == "calc" ]]; then
		if [[ -e "calc.sh" ]]; then
			sh calc.sh $@
		else
			error_exit "Script calc.sh not found"
		fi
	elif [[ $1 == "strlen" ]]; then
		if (( "$#" > 2 )); then
			error_exit "Too many arguments for $1. A single string expected"
		elif (( "$#" < 2 )); then
			error_exit "Too few arguments for $1"
		else
			if [[ -e "strlen.sh" ]]; then
				sh strlen.sh "$2"
			else
				error_exit "Script 'strlen.sh' not found"
			fi
		fi
	elif [[ $1 == "help" ]]; then
		if [[ -e "help.txt" ]]; then
			cat help.txt || error_exit "Couldn't open help.txt"
		else
			error_exit "File 'help.txt' not found"
		fi
	elif [[ $1 == "reverse" ]]; then
		if [[ -e "reverse.sh" ]]; then
			sh reverse.sh $@
		else
			error_exit "Script reverse.sh not found"
		fi
	elif [[ $1 == "search" ]]; then
		if [[ -e "search.sh" ]]; then
			sh search.sh $@
		else
			"Script search.sh not found"
		fi
	elif [[ $1 == "log" ]]; then
		if [[ -e "log.sh" ]]; then
			sh log.sh
		else
			error_exit "Script 'log.sh' not found"
		fi
	elif [[ $1 == "interactive" ]]; then
		if [[ -e "interactive.sh" ]]; then
			sh interactive.sh
		else
			error_exit "Script 'interactive.sh' not found"
		fi
	elif [[ $1 == "exit" ]]; then
		if (( $# > 2 )); then
			error_exit "Too many arguments! Should be just one or none"
		elif [[ $# == "1" ]]; then
			exit 0
		else
			re='^[-+]?(0|[1-9]|[1-9][0-9]+)$'
			if ! [[ $2 =~  $re ]]; then
				error_exit "Code must be a number!"
			else
				if (( $2 < 0 )) || (($2 > 256 )); then
					error_exit "Must be in [0;255]"
				fi
				exit "$2"
			fi
		fi
	else
		error_exit "Command not supported. See help for options"
	fi
fi

