#!/bin/bash 

NPAR=4
MASSR=$1;
SEMAX=$2;
ALPHA=$3
NUM=$4
SIZE=1;
UNIT=mm;

FOLDERNAME=""$NUM"_q"$MASSR"au"$SEMAX"alpha"$ALPHA""
FILENAME="MWC480$NUM"
PHANTOMFOLD="$HOME/phantom_PUBLIC_myfun"

######## CATCH ERRORS #########
if [ "$#" -lt $NPAR ]; then
echo "Too few arguments.";
echo "Usage: setmod.sh q a grainsize unit";
exit 1;
fi

if [ $UNIT != "mm" ] && [ $UNIT != "mum" ] && [ $UNIT != "cm" ]; then
echo "Unit must be cm, mm or mum";
exit 1;
fi

####Message summarizing variables
echo "massratio: $MASSR; semimaj-axis: $SEMAX; grainsize: $SIZE $UNIT; alpha: $ALPHA"
echo "$NUM. massratio: $MASSR; semimaj-axis: $SEMAX; grainsize: $SIZE $UNIT; alpha: $ALPHA" >> paramset.par

#Setting up the simulation folder
if [ ! -d $FOLDERNAME ] || [ -e ./forceit ]; then
  mkdir $FOLDERNAME;
else
  echo "This simulation already exist force, it touching a file named \"forceit\" in this folder";
  exit 1
fi

cd $FOLDERNAME;
echo "massratio: $MASSR; semimaj-axis: $SEMAX; grainsize: $SIZE $UNIT; alpha: $ALPHA"> paramset.par

#copying or creating executables
if [ ! -s ../phantom ] || [ ! -s ../phantomsetup ] || [ ! -s ../phantomsetup ]
then
  $PHANTOMFOLD/scripts/writemake.sh dustydisc> Makefile;
  make;
  make setup;
  make analysis;
else
  cp ../phantom ../phantomsetup ../phantomanalysis .
fi

cp ../templ.in ./$FILENAME.in

#Personalzing the setup
if [ $UNIT = "mm" ]; then
  sed 's/MASSR/'$MASSR'/' < ../templMM.setup| sed 's/SEMAX/'$SEMAX'/'| sed 's/SIZE/0.'$SIZE'/'|sed 's/ALPHA/'$ALPHA'/' > "./"$FILENAME".setup";
elif [ $UNIT = "mum" ]; then
  sed 's/MASSR/'$MASSR'/' < ../templMUM.setup| sed 's/SEMAX/'$SEMAX'/'| sed 's/SIZE/0.000'$SIZE'/'|sed 's/ALPHA/'$ALPHA'/' > "./"$FILENAME".setup";
elif [ $UNIT = "cm" ]; then
  sed 's/MASSR/'$MASSR'/' < ../templCM.setup| sed 's/SEMAX/'$SEMAX'/'| sed 's/SIZE/'$SIZE'/'|sed 's/ALPHA/'$ALPHA'/' > "./"$FILENAME".setup";
else
 echo "Something wrong with the units chosen, it must be mm or mum or cm"
 echo "This is actually second filter, if this message appears something went really wrong";
 exit 1;
fi

#Creating the setup
./phantomsetup $FILENAME

#Generating submission file
generatesubfile.sh $FILENAME

