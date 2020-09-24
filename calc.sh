#!/bin/bash

#sum 1 2
SCRIPTNAME=$0

function error_exit {
	echo "${SCRIPTNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

function calc {
	case "$1" in
		"sum")
			echo "$(($2+$3))"
			;;
		"sub")
			echo "$(($2-$3))"
			;;
		"mul")
			echo "$(($2*$3))"
			;;
		"div")
			echo "$(($2/$3))"
			;;
	esac
}

re='^[-+]?(0|[1-9]|[1-9][0-9]+)$'

if (( $# < 4 ));then
	error_exit "Too few arguments for calc. Use this pattern: sum 1 2"
elif (( $# > 4 )); then
	error_exit "Too many arguments for calc. Use this pattern: sum 1 2"
elif [[ $2 =~ $re ]]; then
	error_exit "The operator is missing. Should be sum/sub/mul/div instead of $2"
elif [ $2 != "sum" ] && [ $2 != "sub" ] && [ $2 != "mul" ] && [ $2 != "div" ]; then
	error_exit "This operator is not supported($2). Check the spelling"
elif [[ $3 =~ $re ]] && [[ $4 =~ $re ]]; then
	if [ "$2" == "div" ] && (( $4 == 0 )); then
		error_exit "Division by zero"
	else
		calc $2 $3 $4
	fi
else
	error_exit "Last two arquments must be int numbers"
fi

