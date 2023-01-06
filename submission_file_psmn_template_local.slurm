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
export OMP_NUM_THREADS=CORES

echo "starting phantom run..."
export outfile=`grep logfile "NAMEFILE.in" | sed "s/logfile =//g" | sed "s/\\!.*//g" | sed "s/\s//g"`
echo "writing output to $outfile"

#./test.exe >& $outfile 
./phantom NAMEFILE.in >& $outfile

### recuperation des resultats à la fin du calcul
/bin/cp -- "${SCRATCHDIR}/*" "${HOMEDIR}/"
				        

