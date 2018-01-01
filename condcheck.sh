#!/bin/bash

#This program checks if condor gave back the output of a given ClusterID.
#If true it updates the submission_file with the last dump and throw TRUE as standard output
#else throw FALSE

clusterID=$1

if [ -s "out."$clusterID".0" ]; then
 DUMP=`awk 'NR==7{print $3}' *.in`
 sed 's/\(\s*\).*[0-9]\{5\}[\.tmp]*/\1'$DUMP'/'< submission_file > prov 
 cp prov submission_file
 rm prov
 echo "true"
else
 echo "false" 
fi 
