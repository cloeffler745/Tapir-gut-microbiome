#!/bin/bash

#SBATCH --time 05:00:00

#SBATCH -p defq

#SBATCH --mail-type=ALL
#SBATCH --mail-user=cmloeffler@gwu.edu

#SBATCH --export=ALL    # Takes the users environment

#SBATCH -o QC_%j.out
#SBATCH -e QC_%j.err

# Setup conda environment
source /GWSPH/home/cmloeffler/miniconda3/etc/profile.d/conda.sh
conda activate QC_Trim

# Make output directory if it does not already exist
mkdir -p ../QC/fastQCResults_thisOne

# fastQC
fastqc -t 6 ../Fastq/*.gz -o ../QC/fastQCResults_thisOne

echo 1>&2 "Finished FastQC"

# multiQC
multiqc ../QC/fastQCResults_thisOne --interactive -o ../QC -n multiqc_raw_thisOne

echo 1>&2 "Finished MultiQC" 

