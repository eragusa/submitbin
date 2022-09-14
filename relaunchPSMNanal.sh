#!/bin/bash

NCORES=1
NHOURS="10:00:00"
PROJECTID="Epyc7702deb512"
ORIGDIR=$PWD
SUBFILE='subanal.sge'

for path in $@; do

     cd $path
     sed "s/#$ -q .*/#$ -q $PROJECTID/" < $SUBFILE > provSub
     sed "s/#$ -pe.*/#$ -pe openmp32 $NCORES/" < provSub > $SUBFILE
     sed "s/#$ -l h_rt.*/#$ -l h_rt=$NHOURS/" < $SUBFILE > provSub
     sed "s/#$ -l s_rt.*/#$ -l s_rt=$NHOURS/" < provSub > $SUBFILE
     sed 's/python $HOME\/pyscripts\/NonResoBin\/cratioSeriesA.py .*/python $HOME\/pyscripts\/NonResoBin\/cratioSeriesA.py trunc*_*/' < $SUBFILE > provSub
     mv provSub $SUBFILE
     #echo "python $HOME/pyscripts/NonResoBin/cratioSeriesA.py *[0]" >> $SUBFILE
     qsub $SUBFILE
     sleep 1
     echo "Launched sim in $path"
     cd $ORIGDIR
done
