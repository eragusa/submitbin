#!/bin/bash
#
### variables SLURM
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


# aller dans le repertoire de travail/soumission
# important, sinon, le programme est lancé depuis ~/
cd "${SLURM_SUBMIT_DIR}" || { echo "cannot cd to ${SGE_O_WORKDIR}"; exit 1; }
 
### configurer l'environnement
#source /usr/share/lmod/lmod/init/bash
#module load IntelComp/15.0.2
export OMP_NUM_THREADS=CORES


### definition SCRATCHDIR
#SCRATCH="/scratch/Cascade"
DIRNAME=`basename $PWD`
SCRATCHDIR="/scratch/Cascade/${USER}/simulazioni/$DIRNAME"

### verif SCRATCHDIR
echo "SCRATCHDIR=${SCRATCHDIR}"
 
### creation du repertoire de travail dans le /scratch
if [[ ! -d "${SCRATCHDIR}" ]] 
then
	/bin/mkdir -p "${SCRATCHDIR}"
else
	if [[ "${SCRATCHDIR}" =~ scratch ]]
	then
        # cette commande est DANGEREUSE !
        #  /bin/rm -rf ${SCRATCHDIR}/
        /bin/mkdir -p "${SCRATCHDIR}"
        fi
fi
	        
### copie des fichiers sources dans le /scratch
DUMPFILE=`grep dumpfile "NAMEFILE.in" | sed "s/dumpfile =//g" | sed "s/\\!.*//g" | sed "s/\s//g"`
/bin/cp -- "${SLURM_SUBMIT_DIR}/phantom" "${SCRATCHDIR}/"
/bin/cp -- "${SLURM_SUBMIT_DIR}/$DUMPFILE" "${SCRATCHDIR}/"
/bin/cp -- "${SLURM_SUBMIT_DIR}/NAMEFILE.in" "${SCRATCHDIR}/"
/bin/cp -- "${SLURM_SUBMIT_DIR}/"*.slurm"" "${SCRATCHDIR}/"
/bin/cp -- "${SLURM_SUBMIT_DIR}/splash.defaults" "${SCRATCHDIR}/"

### se placer dans le repertoire d'execution AVANT le lancement du programme
cd "${SCRATCHDIR}" || { echo "cannot cd to ${SCRATCHDIR}"; exit 1; }
		        
### execution du programme
##EXECDIR=${HOME}/Formations/Sequentiel
##${EXECDIR}/aggregate_infinite.exe < Monfichierdedata > monfichierresultat
#./test1.exe

echo "starting phantom run..."
export outfile=`grep logfile "NAMEFILE.in" | sed "s/logfile =//g" | sed "s/\\!.*//g" | sed "s/\s//g"`
echo "writing output to $outfile"

#./test.exe >& $outfile 
./phantom NAMEFILE.in >& $outfile

### recuperation des resultats à la fin du calcul
#/bin/cp -- "${SCRATCHDIR}/*" "${HOMEDIR}/"
				        
### delete le dossier sur /scratch
#if [[ "${SCRATCHDIR}" =~ scratch ]]
#then
#	/bin/rm -rf "${SCRATCHDIR}"
#fi
					  
###
# fin
