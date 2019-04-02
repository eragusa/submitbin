#!/bin/bash 

NAME=$1
JNAME=$NAME
CORES=$2
TIME=$3
NPAR=3
TEMPLATE=submission_file_template_DialFargo.pbs
PROJECTID="dp005"

if [ "$#" -lt $NPAR ]; then

  CORES=16;
  TIME=24;
  sed 's/NAMEFILE/'$NAME'/' ~/submitbin/$TEMPLATE| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' > subfile.pbs

fi

sed 's/NAMEFILE/'$NAME'/' ~/submitbin/$TEMPLATE| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' 
