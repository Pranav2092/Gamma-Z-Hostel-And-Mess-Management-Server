#!/bin/bash

# HAD and students can run this script

HAD="~"
student="~"
while read -ra line;
do
	student=${line[0]}
	
	user="$(whoami)"
	if [ $user == $student ]
	then
		echo "Choose mess preference (1,2,3)"
		read ans
		echo "${ans}" >> userDetails.txt
	elif [ $user == "HAD" ]
	then
		cd ..
		count1=0
		count2=0
		count3=0
		a=1
		for hostel in GarnetA GarnetB Agate Opal;
		do
			cd $hostel
			
			count=$(ls -l | wc -l)
			count=` expr $count - $2 `
			for room in {0..$count};
			do
				cd $room
				declare -a users=()
				$users=$(ls | head -2)
				for user in $users;
				do
					cd $user
					mess=$(sed -n '4{p;q}' userDetails.txt)
					messpreference=$(sed -n '6{p;q}' userDetails.txt)
					if [ $messprefernce == "1" ]
					then
						if [ $count1 -lt 35 ]
						then 
							awk 'NR==4{print "${messpreference}"}1' userDetails.txt
							echo "${user} ${messpreference}" "../HAD/Mess.txt"
							count1=` expr $count1 + $a `
						else
							messpreference=` expr $messprefernce + $a `
						fi
					elif [ $messprefernce == "2" ]
					then
						if [ $count2 -lt 35 ]
						then 
							awk 'NR==4{print "${messpreference}"}1' userDetails.txt
							echo "${user} ${messpreference}" "../HAD/Mess.txt"
							count2=` expr $count2 + $a `
						else
							messpreference=` expr $messprefernce + $a `
						fi
					elif [ $messprefernce == "3" ]
					then
						if [ $count3 -lt 35 ]
						then 
							awk 'NR==4{print "${messpreference}"}1' userDetails.txt
							echo "${user} ${messpreference}" "../HAD/Mess.txt"
							count3=` expr $count2 + $a `
						fi	
					fi
					cd ..
				done
				cd ..
			done
			cd ..
		done
	else
		continue
	fi
	
done < "../Files/studentDetails.txt"
