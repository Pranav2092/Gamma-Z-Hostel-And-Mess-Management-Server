#!/bin/bash

# Set base directory path
base_dir=$(pwd)

# Change the aliases according to the people who can run them

# Add alias for genstudent
echo "alias genstudent='$base_dir/GenStudent.sh'" >> ~/.bashrc

# Read student details from file and add aliases for feebreakup
while read -ra line; do
    studentname="${line[0]}"
    hostel="${line[2]}"
    room="${line[3]}"
    echo "alias feebreakup='$base_dir/GammaZHostelAndMessManagement/$hostel/$room/$studentname/FeeBreakUp.sh'" >> ~/.bashrc
done < "$base_dir/Files/studentDetails.txt"

# Add alias for permit
echo "alias permit='$base_dir/Permit.sh'" >> ~/.bashrc

# Change permissions for required scripts
chmod 760 GenStudent.sh Permit.sh FeeBreakUp.sh

# Reload the updated bashrc file
source ~/.bashrc
