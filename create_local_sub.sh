#!/bin/bash

NCORES=32
NHOURS="120:00:00"
PROJECTID="Epyc7702deb512"
ORIGDIR=$PWD
SUBFILE='subfile_local.sge'

for path in $@; do

     cd $path	
     gensubfPSMN_local.sh 'sim'${path:0:7}'' 32 120:00:00 > $SUBFILE
     sed 's/\.\/phantom .*/\.\/phantom \*\.in \&> $outfile/' < $SUBFILE > provSub
     mv provSub $SUBFILE
     qsub $SUBFILE
     sleep 1
     echo "Launched sim in $path"
     cd $ORIGDIR
done
