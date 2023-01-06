#!/bin/bash 

NAME=$1
JNAME=$NAME
CORES=$2
TIME='xxx'
NPAR=2
PROJECTID="Cascade"
if [ $# -gt $NPAR ]; then
    echo "Too many params enter JOBNAME and CORES" 
#    exit(1) 
fi

if [ "$#" -lt $NPAR ]; then

  CORES=16;
  TIME=24;
  sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_PSMN.slurm| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' > subfile.slurm

fi

sed 's/NAMEFILE/'$NAME'/' ~/submitbin/submission_file_template_PSMN.slurm| sed 's/JOBNAME/'$JNAME'/'|sed 's/TIME/'$TIME'/'|sed 's/CORES/'$CORES'/'|sed 's/PROJECTID/'$PROJECTID'/' 
