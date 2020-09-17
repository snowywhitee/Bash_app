#!/bin/bash

SCRIPTNAME=$0

function error {
	dialog --title "Error" --msgbox "$1" 10 50
}

function warning {
	dialog --title "Warning" --msgbox "$1" 10 50
}

re='^[-+]?(0|[1-9]|[1-9][0-9]+)$'

function calc {
	#set values

	while true; do
		num1=$(dialog --title "Interactive mode" --inputbox \
		"Enter the first number:" 10 50 3>&1 1>&2 2>&3 3>&- )

		if [ "$?" != "0" ]; then
			mainMenu
			return 0
		elif ! [[ $num1 =~ $re ]]; then
			error "You should enter a NUMBER. Try again"
		else
			break
		fi
	done

	while true; do
		num2=$(dialog --title "Interactive mode" --inputbox \
		"Enter the second number:" 10 50 3>&1 1>&2 2>&3 3>&- )
		if [ "$?" != "0" ]; then
			mainMenu
			return 0
		elif ! [[ $num2 =~ $re ]]; then
			error "You should enter a NUMBER. Try again"
		elif [[ "$num2" == "0" ]]; then
			error "Division by zero"
		else
			break
		fi
	done

	#calculations and output
	case "$1" in
		"sum")
			dialog --msgbox "$num1 + $num2 = $((num1+num2))" 7 15
			;;
		"sub")
			dialog --msgbox "$num1 - $num2 = $((num1-num2))" 7 15
			;;
		"mul")
			dialog --msgbox "$num1 * $num2 = $((num1*num2))" 7 15
			;;
		"div")
			dialog --msgbox "$num1 / $num2 = $((num1/num2))" 7 15
			;;
		*)
			error "This operator is not supported"
			;;
	esac

	mainMenu
}

function search {
	while true; do
		dirname=$(dialog --title "Interactive mode" --inputbox \
		"Enter the directory name:" 10 50 3>&1 1>&2 2>&3 3>&- )
		if [ "$?" != "0" ]; then
			mainMenu
			return 0
		elif ! [ -d "$dirname" ]; then
			error "Directory '"$dirname"' not found. Try again"
		else
			break
		fi
	done
	pattern=$(dialog --title "Interactive mode" --inputbox \
	"Enter the expression:" 10 50 3>&1 1>&2 2>&3 3>&- )
	if [ "$?" != "0" ]; then
		mainMenu
		return 0
	fi
	touch tmp
	grep -r --exclude=tmp "$pattern" "$dirname" > tmp
	if ! [[ -s "tmp" ]]; then
		dialog --title ":(" --msgbox "No results, sorry" 10 50
		rm tmp
		mainMenu
		return 0
	fi
	dialog --title "Search resuts" --textbox tmp 50 60
	rm tmp
	mainMenu
}

function rev {
	tac "$1" >> "$2" || error "Reverse was not complete"
}

function reverse {
	while true; do
		input=$(dialog --title "Ineractive mode" --inputbox \
		"Enter the name of the file:" 10 50 3>&1 1>&2 2>&3 3>&- )
		if [ "$?" != "0" ]; then
			mainMenu
			return 0
		elif ! [[ -e "$input" ]]; then
			error "File not found"
		elif ! [[ -r "$input" ]]; then
			error "File is not readable. Try another one"
		else
			break
		fi
	done

	while true; do
		output=$(dialog --title "Interactive mode" --inputbox \
		"Enter the final file name:" 10 50 3>&1 1>&2 2>&3 3>&- )
		if [ "$?" != "0" ]; then
			mainMenu
			return 0
		elif ! [[ -e "$output" ]]; then
			dialog --yesno \
			"File '"$output"' doesn't exist. Create?" 10 50
			if [ "$?" == "0" ]; then
				touch "$output"
				break
			fi
		elif ! [[ -w "$output" ]]; then
			error "File is not writable"
		else
			break
		fi
	done
	#warnings
	if ! [[ -s "$input" ]]; then
		warning "File '"$input"' is empty, no changes to '"output"' will be made"
		return 0
	elif [[ "$input" -ef "$output" ]]; then
		warning "You are about to reverse file '"$input"' to itself"
		touch tmp
		tac "$input" >> tmp
		> "$input"
		cat tmp >> "$input"
		rm tmp
		return 0
	elif [[ -s "$output" ]]; then
		dialog --yesno "File '"$output"' is not empty. Overwrite?" 10 50
		if [ "$?" == "0" ]; then
			> "$output"
			rev $input $output
		else
			rev $input $output
		fi
	else
		rev $input $output
	fi
	dialog --msgbox "Done!" 10 50
	mainMenu
}

function strlen {
	str=$(dialog --title "Interactive mode" --inputbox "Enter the string:" \
	10 50 3>&1 1>&2 2>&3 3>&- )
	if [ "$?" != "0" ]
	then
		mainMenu
		return 0
	fi
	len=${#str}
	dialog --msgbox "String length is: $len " 10 50
	mainMenu
}

function getLog {
	if [ "$EUID" -ne 0 ]; then
		error "Please, run as root"
		mainMenu
		exit 0
	fi
	touch tmp tmp2
	cat /var/log/anaconda/X.log >> tmp
	sed -i 's/WW/Warning/g;s/II/Information/g' tmp
	cat tmp >> tmp2
	sed -i '/Information/!d' tmp
	sed -i '/Warning/!d' tmp2
	cat tmp >> tmp2
	dialog --title "Logs" --textbox tmp2 50 60
	rm tmp tmp2
	mainMenu
}

function getHelp {
	if ! [[ -e "help.txt" ]]; then
		error "Help file wasn't found"
		mainMenu
		clear
		exit 0
	fi
	dialog --textbox help.txt 50 60
	mainMenu
}

function mainMenu {

choice=$(dialog --title "Main menu"  --menu "Choose the command" 15 30 7\
 1 calc 2 search 3 reverse 4 strlen 5 log 6 help 7 exit 3>&2 2>&1 1>&3)

if [ "$?" != "0" ]; then
	dialog --yesno "You sure, you want to exit?" 10 50
	if [ "$?" != "0" ]; then
		mainMenu
	else
		clear
		exit 0
	fi
elif [ "$choice" = "1" ]; then
	option=$(dialog --title "Interactive mode" --menu "Choose an operator" 15 30 4\
	 1 sum 2 sub 3 mul 4 div 3>&2 2>&1 1>&3)
	if [ "$?" != "0" ]; then
		mainMenu
	elif [ "$option" = "1" ]; then
		calc sum
	elif [ "$option" = "2" ]; then
		calc sub
	elif [ "$option" = "3" ]; then
		calc mul
	elif [ "$option" = "4" ]; then
		calc div
	fi
elif [ "$choice" = "2" ]; then
	search
elif [ "$choice" = "3" ]; then
	reverse
elif [ "$choice" = "4" ]; then
	strlen
elif [ "$choice" = "5" ]; then
	getLog
elif [ "$choice" = "6" ]; then
	getHelp
elif [ "$choice" = "7" ]; then
	while true; do
		option=$(dialog --inputbox \
		"Enter the code. Must be a number" 10 50 3>&1 1>&2 2>&3 3>&- )
		if ! [[ $option =~ $re ]]; then
			error "Code must be a number!"
		else
			break
		fi
	done
	clear
	exit $option
fi

clear
}

if [ ! -e "calc.sh" ] || [ ! -e "strlen.sh" ] || [ ! -e "search.sh" ] || [ ! -e "interactive.sh" ] || [ ! -e "reverse.sh" ] || [ ! -e "log.sh" ]; then
	dialog --title "WARNING" --msgbox "Some scripts are not found. Some functions may not work" 10 50
fi

mainMenu