#!/bin/bash

#sum 1 2
SCRIPTNAME=$0

function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

function calc {
	if [[ $1 == "sum" ]]; then
		echo "$(($2+$3))"
	elif [[ $1 == "sub" ]]; then
		echo "$(($2-$3))"
	elif [[ $1 == "mul" ]]; then
		echo "$(($2*$3))"
	elif [[ $1 == "div" ]]; then
		echo "$(($2/$3))"
	fi
}

re='^[-+]?(0|[1-9]|[1-9][0-9]+)$'

if (( $# < 3 ));then
	error_exit "Too few arguments($#). Use this pattern: sum 1 2"
elif (( $# > 3 )); then
	error_exit "Too many arguments($#). Use this pattern: sum 1 2"
elif [[ $1 =~ $re ]]; then
	error_exit "The operator is missing. Should be sum/sub/mul/div instead of $1"
elif [ $1 != "sum" ] && [ $1 != "sub" ] && [ $1 != "mul" ] && [ $1 != "div" ]; then
	error_exit "This operator is not supported($1). Check the spelling"
elif [[ $2 =~ $re ]] && [[ $3 =~ $re ]]; then
	if [[ "$3" == "0" ]]; then
		error_exit "Division by zero"
	else
		calc $1 $2 $3
	fi
else
	error_exit "Last two arquments must be numbers($2 and $3)"
fi

