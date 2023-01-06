#!/bin/bash 

NAME=$1
JNAME=$NAME
CORES=$2
TIME='xxx'
NPAR=2
PROJECTID="Epyc7702deb512"
if [ $# -gt $NPAR ]; then
    echo "Too many params enter JOBNAME and CORES" 
#    exit(1) 
fi

if [ "$#" -lt $NPAR ]; then

  CORES=16;
  TIME=24;
  sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_PSMN.pbs| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' > subfile.pbs

fi

sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_PSMN.pbs| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' 
