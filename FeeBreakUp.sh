#!/bin/bash

# Make .bashrc for each user
#user="~"
amount=100000
while read -ra line; do
    studentname="${line[0]}"
    hostel="${line[2]}"
    room="${line[3]}"
    if [ "$(whoami)" == "$studentname" ]
    then
        echo -e "$(whoami) -$amount $(date '+%Y-%m-%d %H:%M:%S')" >> fees.txt 
        echo -e "Fees of $amount paid successfully"
        while read -ra line; do
		name="${line[0]}"
		per="${line[1]}"
		val="${line[2]}"
		if [ "${name}" != "$(whoami)" ]
		then
			b=100
			x=`expr $amount * $per`
			y=`expr $x / $b`
			z=`expr $y + $val`
			val=$z
			line[2]=$val
		fi 
        done < "fees.txt"
    else
        echo -e "Fees cannot be paid as user not found"
    fi
done < "Files/studentDetails.txt"    

