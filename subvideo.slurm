#!/bin/bash
#
### nom du job (a changer)
#SBATCH --job-name=JOBNAME
### file d'attente (a changer)
#SBATCH  --partition=PROJECTID
#SBATCH --nodes=1
### parallel environment & nb cpu (NSLOTS)
#SBATCH -n CORES
### charger l'environnement utilisateur pour SGE
#SBATCH -D ./
### exporter les variables d'environnement sur tous les noeuds d'execution
#SBATCH --time=TIME

###### mails en debut et fin d'execution
#######SBATCH --mail-user=<enrico.ragusa@ens-lyon.fr>
#######SBATCH --mail-type=<FAIL>

### configurer l'environnement
#source /usr/share/lmod/lmod/init/bash
#module load IntelComp/15.0.2

mkdir -p movie
splash -p trunc*_0* -r 6 -dev /png
mv splash_*png movie
cd movie 
~/splash/scripts/movie.sh
