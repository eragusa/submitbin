#!/bin/bash

PWD=`pwd`
ARG1=$@
PROCID=/home/ragusa/ProcID

echo "`date`: $$ $PWD $ARG1"  >> $HOME/simulazioni/procID/activenohupID.txt 
nohup $ARG1 > "$ARG1.wrapout"
sed '/'$$'/d' $HOME/simulazioni/procID/activenohupID.txt > $HOME/simulazioni/procID/prov
mv $PROCID/prov $PROCID/activenohupID.txt



