#!/bin/bash 

NAME=$1
JNAME=$NAME
CORES=$2
TIME=$3 ##[hh:mm:ss]
NPAR=3
PROJECTID="Cascade"
SUBMISSIONFILE=''$HOME'/submitbin/submission_file_psmn_template.slurm'
if [ $# -eq 4 ]; then
    PROJECTID=$4    
fi

if [ "$#" -lt $NPAR ]; then

  CORES=16;
  TIME=24;
  sed 's/NAMEFILE/'$NAME'/' $SUBMISSIONFILE| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' > subfile.pbs

fi

sed 's/NAMEFILE/'$NAME'/' $SUBMISSIONFILE| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' 
