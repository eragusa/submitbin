#!/bin/bash

NCORES=32
NHOURS="120:00:00"
PROJECTID="Epyc7702deb512"
ORIGDIR=$PWD
SUBFILE='subfile_local.pbs'

for path in $@; do

     cd $path
     sed "s/#$ -q .*/#$ -q $PROJECTID/" < $SUBFILE > provSub
     sed "s/#$ -pe.*/#$ -pe openmp32 $NCORES/" < provSub > $SUBFILE
     sed "s/#$ -l h_rt.*/#$ -l h_rt=$NHOURS/" < $SUBFILE > provSub
     sed "s/#$ -l s_rt.*/#$ -l s_rt=$NHOURS/" < $SUBFILE > provSub
     mv provSub $SUBFILE
     qsub $SUBFILE
     sleep 1
     echo "Launched sim in $path"
     cd $ORIGDIR
done
