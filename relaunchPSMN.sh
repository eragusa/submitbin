#!/bin/bash

NCORES=32
NHOURS="168:00:00"
PROJECTID="Cascade"
ORIGDIR=$PWD
SUBFILE='subfile_local.slurm'
SIMTIME=62831.8531 

for path in $@; do

     cd $path
     sed "s/#SBATCH  --partition=.*/#SBATCH  --partition=$PROJECTID/" < $SUBFILE > provSub
     sed "s/#SBATCH -n.*/#SBATCH -n  $NCORES/" < provSub > $SUBFILE
     sed "s/#SBATCH --time=.*/#SBATCH --time=$NHOURS/" < $SUBFILE > provSub
     mv provSub $SUBFILE
     sed "s/ tmax =.*/ tmax =  $SIMTIME    ! end time/" < trunc*.in > provSub
     mv provSub trunc*.in

     #mv provSub $SUBFILE
     sbatch $SUBFILE
     sleep 1
     echo "Launched sim in $path"
     cd $ORIGDIR
done
