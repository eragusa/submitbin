#!/bin/bash 

PROCID=path_subst

for proc in `awk '{print $7}' $PROCID/activenohupID.txt`
 do
 HOWMANY=`ps -ef|grep " $proc "|awk 'END{print NR}'`
 if [ "$HOWMANY" -lt 2 ]; then 
     sed '/'$proc'/d' $PROCID/activenohupID.txt > prov
     mv prov $PROCID/activenohupID.txt
 fi   
 done
