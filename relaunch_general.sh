#!/bin/bash

PROJECTID="dp190"
ORIGDIR=$PWD
SUBFILE='subvideo.pbs'

for path in $@; do
     
     cp $SUBFILE $path
     cd $path
     qsub $SUBFILE
     sleep 1
     echo "Launched sim in $path"
     cd $ORIGDIR
done
