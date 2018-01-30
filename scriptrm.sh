#!/bin/bash 

echo "WARNINIG!!!! This is a script to automatically remove a large number of dumps"
echo "Press enter to go on, but just if you know what you are doing. To stop press ctrl+c"
read

echo "You are going to remove all dumps"
echo "except those ending for 0 or 5 in the following dirs:"
echo "`ls -d "$PWD"/*/`"

echo "Press enter to go further, ctrl+c to stop"
read

for dir in `ls -d "$PWD"/*/`; do
    
    cd $dir 
    echo "Deleting dumps in: $PWD"
    rmdecfive.sh

done 
