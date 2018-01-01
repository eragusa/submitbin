#!/bin/bash

PWD=`pwd`
ARG1=$@

echo "`date`: $$ $PWD $ARG1"  >> $HOME/simulazioni/procID/activenohupID.txt 
nohup $ARG1 > "$ARG1.wrapout"
sed '/'$$'/d' $HOME/simulazioni/procID/activenohupID.txt > $HOME/simulazioni/procID/prov
mv $HOME/simulazioni/procID/prov /home/ragusa/simulazioni/procID/activenohupID.txt



