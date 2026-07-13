#!/bin/bash

#SBATCH --time 4-00:00:00

#SBATCH -p defq

#SBATCH --mail-type=ALL
#SBATCH --mail-user=cmloeffler@gwu.edu

#SBATCH --export=ALL    # Takes the users environment

#SBATCH -o ResFinder_first_%j.out
#SBATCH -e ResFinder_first_%j.err

# Set up the resFinder environment
source /GWSPH/home/cmloeffler/resfinder_env/bin/activate

# Run ResFinder
while read line
do 
	echo 1>&2 "Started $line" 

	mkdir ../ResFinder_outs/First_run/"$line"

	python -m resfinder -ifq ../Fastq/trim_130/paired/"$line"_R1.fastq.gz ../Fastq/trim_130/paired/"$line"_R2.fastq.gz -o ../ResFinder_outs/First_run/"$line" --kmaPath /GWSPH/home/cmloeffler/resfinder_env/extra_installs/kma/kma --db_path_res /GWSPH/home/cmloeffler/resfinder_env/extra_installs/databases/resfinder_db --db_path_disinf_kma /GWSPH/home/cmloeffler/resfinder_env/extra_installs/databases/disinfinder_db  --acquired -s "Other" --db_path_disinf /GWSPH/home/cmloeffler/resfinder_env/extra_installs/databases/disinfinder_db --disinfectant

	echo 1>&2 "Finished $line"

done < ../files/sample_list


echo "Done"
