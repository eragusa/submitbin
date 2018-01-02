#!/bin/bash 

PROCID=$HOME/ProcID
SUBMITDIR=$HOME/submitbin

mkdir $PROCID
cp $SUBMITDIR/daemonnohup.sh $PROCID
touch $PROCID/activenohupID.txt
echo $PROCID
sed 's,path_subst,'$PROCID',' < $SUBMITDIR/templwrapnohup.sh > $SUBMITDIR/wrapnohup.sh
sed 's,path_subst,'$PROCID',' < $SUBMITDIR/templactiveID.sh > $SUBMITDIR/activeID.sh


########wrtiting the README##########

echo "daemonnohup.sh is a sort of daemon that check constantly the situation of nohup jobs.
To work properly the call for nohup needs to be wrapped in the script wrapnohup.sh. THis script print the PID associated into the file activenohupID.txt.
daemonnohup.sh then checks periodically the status of the job looking in the ps -ef output.

HOW TO USE:
start the daemon: in this folder type 

nohup ./daemonnohup.sh > daemonPID.txt &

then call nohup jobs as

wrapnohup.sh PROGRAMNAME &

###################################
Aggiornamento

ora wrapnohup.sh fa le stesse cose ma senza bisogno del demone.
Tuttavia il demone è ccomunque utile perchè se processi chiusi male non aggiornano la lista.
Per aggiornare la lista basta digitare:

./daemonnohup.sh

poi chiuderlo manualmente con ctrl+c.
#######################################
Ultima versione

daemonnohup.sh non è più un demone. Conclude la sua esecuzione automaticamente." > $PROCID/README
