#!/bin/bash 

### $1 is the name of the dump you are using for the RADIATIVE TRANSFER simulation


echo "Creating directories and copying basic files"

mkdir ./RAD_$1_$2
mkdir RAD_$1_$2/observation
mkdir RAD_$1_$2/observation/log
#cp dustkappa_lucas_mix_*.inp  RAD_$1_$2/observation/.
cp dustkappa_files/dustkappa_lucas_mix_1_q$3.inp RAD_$1_$2/observation/dustkappa_lucas_mix_1.inp
cp dustkappa_files/dustkappa_lucas_mix_2_q$3.inp RAD_$1_$2/observation/dustkappa_lucas_mix_2.inp
cp dustgrid* RAD_$1_$2/.


echo " Creating a grid for the dump file"
###Decomment this if you want to set the minimum of the density to 0
export SPLASH_TO_GRID_RHOMIN=0
###Put here the number of the columns of the dump file you want to use
export SPLASH_TO_GRID=6,7      
###For running this command you need to have in the directory dustgrid.limits, dustgrid.defaults, dustgrid.units
ssplash -p dustgrid to gridascii $1
###Change filename and put here the name you also put in dump2radmc.f90 in the src directory
mv $1_density_g_cm3_grid.dat RAD_$1_$2/hd135344B_1mu.dat 
mv $1_dustfrac_grid.dat RAD_$1_$2/hd135344B_1mu_dustfrac.dat


echo " Converting into radmc-3D input files"
cd src; make convert; mv ../dump2radmc ../RAD_$1_$2; cd ../RAD_$1_$2; ./dump2radmc; rm dump2radmc;
 
echo " Running MCTHERM:"
cd observation
# Here you have to put the path of your radmc3d executable. 
cp /home/benedetta/radmc-3d/version_0.41/src/radmc3d .
generatesubfile.sh mctherm
condor_submit submission_file_mctherm

echo " Waiting for the mctherm to finish and for the dust_temperature.dat file to show up "
while [ ! -f dust_temperature.dat ]; do sleep 1; done
while [ $(( $(date +%s) - $(stat -c %Y dust_temperature.dat) )) -lt 10 ]; do sleep 1; done;

echo " Creating RADMC3D images"
generatesubfile.sh image
condor_submit submission_file_image    
'''
echo " Waiting for the images.out files to show up"
while [ ! -f image_*.out ]; do sleep 1; done
while [ $(( $(date +%s) - $(stat -c %Y image_*.out) )) -lt 10 ]; do sleep 1; done;



echo "Creating tausurf images"
generatesubfile.sh surface 
condor_submit submission_file_surface
'''
echo " DONE! "

