#!/bin/bash 


for proc in `awk '{print $7}' ~/simulazioni/procID/activenohupID.txt`
 do
 HOWMANY=`ps -ef|grep " $proc "|awk 'END{print NR}'`
 if [ "$HOWMANY" -lt 2 ]; then 
     sed '/'$proc'/d' ~/simulazioni/procID/activenohupID.txt > prov
     mv prov ~/simulazioni/procID/activenohupID.txt
 fi   
 done
