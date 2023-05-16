#!/bin/bash

mkdir GammaZHostelAndMessManagement
cd GammaZHostelAndMessManagement
echo "$(pwd)"

mkdir HAD
useradd -d $(pwd) "HAD"
passwd -d "HAD"
cd ..
cp "$(pwd)/Files/mess.txt" "$(pwd)/GammaZHostelAndMessManagement/HAD/Mess.txt"
chown root $(pwd)/GammaZHostelAndMessManagement
inputFile=$1
if [[ -z $inputFile ]]; then
    echo "Do you want to add custom student(y/n)"
    read ans
    if [ "$ans" == "n" ]; then
    	echo "Error: No input file provided."
    	exit 1
    else
    	    cd GammaZHostelAndMessManagement
	    echo "Enter details of the student"
	    echo "Student name: "
	    read studentname
	    echo "Student roll number: "
	    read rollnumber
	    echo "Student hostel name: "
	    read hostel
	    echo "Student room no.: "
	    read room
	    echo "Student mess name: "
	    read mess
	    echo "Student mess preference: "
	    read messpreference
	    mkdir -p "$(pwd)/${hostel}/${room}/${studentname}"
	    useradd -d $(pwd)/${hostel}/${room}/${studentname} "${studentname}"
	    passwd -d "${studentname}"
	    cd ..
	    setfacl -m g:${studentname}:r-x "FeeBreakUp.sh" 
	    
	    echo -e "#!/bin/bash\nalias feebreakup='$(pwd)/FeeBreakUp.sh'" >> "$(pwd)/GammaZHostelAndMessManagement/${hostel}/${room}/${studentname}/.bash_profile"
	    . "$(pwd)/GammaZHostelAndMessManagement/${hostel}/${room}/${studentname}/.bash_profile"
	    cd GammaZHostelAndMessManagement
	    
	    touch "$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
	    
	    cd ..
	    cp "$(pwd)/Files/feeBreakup.txt" "$(pwd)/GammaZHostelAndMessManagement/${hostel}/${room}/${studentname}/fees.txt"
	    cd GammaZHostelAndMessManagement
	    
	    if [ "${studentname}" != "-" ]; then
		echo -e "${studentname}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
	    fi
	    if [ "${rollnumber}" != "-" ]; then
		echo -e "${rollnumber}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
	    fi
	    if [ "${hostel}" != "-" ]; then
		echo -e "${hostel}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
	    fi
	    if [ "${mess}" != "-" ]; then
		echo -e "${mess}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
	    fi
	    if [ "${messpreference}" != "-" ]; then
		echo -e "${messpreference}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
	    fi
	    cd ..
	    echo -e "${studentname} ${rollnumber} ${hostel} ${room} ${mess} ${messprefernce}" >> $(pwd)/Files/studentDetails.txt
    fi

elif [ ! -f "$(pwd)/Files/${inputFile}" ]; then
    echo "Error: Input file '$inputFile' not found."
    exit 1


elif [ "$inputFile" == "studentDetails.txt" ]; then
    echo "Using studentDetails.txt to create student users..."
    inputFile="$(pwd)/Files/studentDetails.txt"

cd GammaZHostelAndMessManagement
for hostel in GarnetA GarnetB Opal Agate; do
    mkdir "${hostel}"
    useradd -d $(pwd)/${hostel} "${hostel}"
    passwd -d "${hostel}"
    for room in {0..20}; do
        mkdir "$hostel/$room"
    done
    touch "${hostel}/announcements.txt" "${hostel}/feeDefaulters.txt"
done

while read -ra line; do
    studentname="${line[0]}"
    rollnumber="${line[1]}"
    hostel="${line[2]}"
    room="${line[3]}"
    mess="${line[4]}"
    messpreference="${line[5]}"
    mkdir -p "$(pwd)/${hostel}/${room}/${studentname}"
    useradd -d $(pwd)/${hostel}/${room}/${studentname} "${studentname}"
    passwd -d "${studentname}"
    cd ..
    setfacl -m g:${studentname}:r-x "FeeBreakUp.sh" 
    
    echo -e "#!/bin/bash\nalias feebreakup='$(pwd)/FeeBreakUp.sh'" >> "$(pwd)/GammaZHostelAndMessManagement/${hostel}/${room}/${studentname}/.bash_profile"
    . "$(pwd)/GammaZHostelAndMessManagement/${hostel}/${room}/${studentname}/.bash_profile"
    cd GammaZHostelAndMessManagement
    
    touch "$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
    
    cd ..
    cp "$(pwd)/Files/feeBreakup.txt" "$(pwd)/GammaZHostelAndMessManagement/${hostel}/${room}/${studentname}/fees.txt"
    cd GammaZHostelAndMessManagement
    
    if [ "${studentname}" != "-" ]; then
        echo -e "${studentname}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
    fi
    if [ "${rollnumber}" != "-" ]; then
        echo -e "${rollnumber}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
    fi
    if [ "${hostel}" != "-" ]; then
        echo -e "${hostel}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
    fi
    if [ "${mess}" != "-" ]; then
        echo -e "${mess}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
    fi
    if [ "${messpreference}" != "-" ]; then
        echo -e "${messpreference}" >>"$(pwd)/${hostel}/${room}/${studentname}/userDetails.txt"
    fi
done <"${inputFile}"
cd ..
fi
