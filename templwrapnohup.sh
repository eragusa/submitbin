#!/bin/bash

PWD=`pwd`
ARG1=$@
PROCID=path_subst

echo "`date`: $$ $PWD $ARG1"  >> $PROCID/activenohupID.txt 
nohup $ARG1 > "$ARG1.wrapout"
sed '/'$$'/d' $PROCID/activenohupID.txt > $PROCID/prov
mv $PROCID/prov $PROCID/activenohupID.txt



