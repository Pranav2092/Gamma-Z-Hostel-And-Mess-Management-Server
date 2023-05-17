#!/bin/bash

chmod 771 GammaZHostelAndMessManagement
setfacl -R -m g:HAD:rwx GammaZHostelAndMessManagement

cd GammaZHostelAndMessManagement

while read -ra line; do
    
    studentname="${line[0]}"
    hostel="${line[2]}"
    room="${line[3]}"
    setfacl -R -m g:"${hostel}":rwx "${hostel}"
    chmod 771 "${hostel}"
    cd "${hostel}"
    cd "${room}"
    for file in *; do 
        if [ -d "$file" ]; then
            setfacl -R -m g:"${file}":r-x "${file}"
            chmod 771 "${file}"
        fi
    done
    cd ..
    cd ..
done < "../Files/studentDetails.txt"

cd ..

