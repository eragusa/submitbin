#!/bin/bash

NCORES=36
NHOURS=120
PROJECTID="dp119"
ORIGDIR=$PWD
SUBFILE='subanal.sge'

for path in $@; do

     cd $path
     sed "s/#PBS -A .*/#PBS -A $PROJECTID/" < $SUBFILE > provSub
     sed "s/#PBS -l nodes.*/#PBS -l nodes=1:ppn=36/" < provSub > $SUBFILE
     sed "s/#PBS -l walltime.*/#PBS -l walltime=$NHOURS:00:00/" < $SUBFILE > provSub
     sed 's/perf\ record\ \.\/phantom/\.\/phantom/' < $SUBFILE > provSub
     mv provSub $SUBFILE
     qsub $SUBFILE
     sleep 1
     echo "Launched sim in $path"
     cd $ORIGDIR
done
