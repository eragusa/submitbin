#!/bin/bash

NAME=$1
JNAME=`pwd|awk -F '/' 'NR==1{print $NF}'`

sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_Dial.pbs| sed 's/JOBNAME/'$JNAME'/' > subfile.pbs

