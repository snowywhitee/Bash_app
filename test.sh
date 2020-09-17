#!/bin/bash

#cmd=$(dialog --menu "Select:" 20 20 3 1 Calc 2 Search 3 Reverse 3>&2 2>&1 1>&3)

#dialog --msgbox "Choice: $cmd" 10 50

#clear

#cat tmp | sed -e "s/warning/\x1b[32mwarning\x1b[0m/g"
#dialog --textbox help.txt 50 60

touch tmp
grep -r --exclude=tmp "error_exit" /home/lidja/ > tmp
cat tmp
rm tmp
