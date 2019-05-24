#!/bin/bash 

NAME=$1
JNAME=$NAME
CORES=$2
TIME=$3
NPAR=3
PROJECTID="dp119"

if [ "$#" -lt $NPAR ]; then

  CORES=36;
  TIME=1;
  sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_DialMCF.pbs| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' > subfile.pbs

fi

sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_DialMCF.pbs| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' 
