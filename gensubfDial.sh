#!/bin/bash 

NAME=$1
JNAME=$NAME
CORES=$2
TIME=$3
NPAR=3
PROJECTID="dp190"
if [ $# -eq 4 ]; then
    PROJECTID=$4    
fi

if [ "$#" -lt $NPAR ]; then

  CORES=16;
  TIME=24;
  sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_Dial.pbs| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' > subfile.pbs

fi

sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_Dial.pbs| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' 
