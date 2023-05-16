#!/bin/bash

# Make .bashrc for each manager
hostel="~"
cd $hostel
for room in $hostel
do
	for user in $(ls . | head -n -2)
	do 
	    
	    month=$(date "%m")
	    check=$(grep -C -rw ${room}/${user}/fees.txt -e ${month})
	    a=0
	    if [ $check == $a ]
	    then
		echo ${user} >> feeDefaulters.txt
	    else
	    	    i=0
	    	    b=5
	    	    j=1
		    if [ $i -lt $b ]
		    then
		    	echo ${user} >> announcement.txt
		    	i=` expr $i + $j `
		    fi
	    fi
	done
done
