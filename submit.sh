#!/bin/bash 

NORB=$1
NITER=$NORB #$(($NORB/50))    #awk -v nd=$NORB 'BEGIN{print nd/5}'

######## CATCH ERRORS #########
if [ "$#" -lt 1 ]; then
echo "Too few arguments.";
echo "Usage: submit.sh Nrepeat";
exit 1;
fi
#########
######### INITIALIZE submit.log
echo "###############" >> submit.log
echo "# SUBMIT LOG #"  >> submit.log
echo "##############"  >> submit.log
echo "" >> submit.log
echo "" >> submit.log
##########

INITDUMP=`awk 'NR==7{print $3}' *.in`
sed 's/\(\s*\).*[0-9]\{5\}[\.tmp]*/\1'$INITDUMP'/'< submission_file > prov 
cp prov submission_file
rm prov

condor_submit submission_file > submission.out

ID=`awk 'NR==2{print $6}' submission.out|sed 's/\.//'` 
counter=1

####### WRITE LOG #######
echo "`date`: submission on cluster $ID" >>submit.log
echo "Counter: $counter/$NITER" >> submit.log
echo "ClusterID: $ID" >> submit.log 
echo "Initial dump: $INITDUMP" >> submit.log 
echo "" >> submit.log 
INITDUMPrevious=$INITDUMP

######### BEGIN CHECK (every 30 sec)######
CONTINUE=true

while $CONTINUE;
do
  sleep 300
  ID=`awk 'NR==2{print $6}' submission.out|sed 's/\.//'` 
  checkflag=`condcheck.sh $ID`
  if $checkflag; then #if condorcheck gave back output submit again and uptate log file
        sleep 30
        condor_submit submission_file > submission.out
        ID=`awk 'NR==2{print $6}' submission.out|sed 's/\.//'`        
        counter=$(($counter+1)); 
        INITDUMP=`awk 'NR==7{print $3}' *.in`
        
        if [ $INITDUMPrevious == $INITDUMP ]; then #check if the same dump then simulation stucked stop
            CONTINUE=false        
            echo "!!!!WARNING!!!! Simulation stucked: same initial dump (reached time limit in .in file)">>submit.log   
        fi    
        INITDUMPrevious=$INITDUMP
        echo "`date`: submission on cluster $ID" >>submit.log
        echo "Counter: $counter/$NITER" >> submit.log
        echo "ClusterID: $ID" >> submit.log
        echo "Initial dump: $INITDUMP" >> submit.log  
        echo "" >> submit.log 
  fi
  if [ "$counter" -ge "$NITER" ]; then
        CONTINUE=false;
  fi
done

  
      
  
