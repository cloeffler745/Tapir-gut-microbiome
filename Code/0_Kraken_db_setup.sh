#!/bin/bash

#SBATCH --time 3-00:00:00

#SBATCH -p 384gb

#SBATCH --mail-type=ALL
#SBATCH --mail-user=cmloeffler@gwu.edu

#SBATCH --export=ALL    # Takes the users environment

#SBATCH -o Kraken_db_make_%j.out
#SBATCH -e Kraken_db_make_%j.err

# Building the Kraken reference library
module load kraken2/2.1.5
# Get the taxonomy database
#kraken2-build --download-taxonomy --db /scratch/cbi/Tapir/references/kraken_db

# Download the genomes AGAIN, I am not playing around 
#kraken2-build --download-library bacteria --db /scratch/cbi/Tapir/references/kraken_db
#kraken2-build --download-library archaea --db /scratch/cbi/Tapir/references/kraken_db
#kraken2-build --download-library viral --db /scratch/cbi/Tapir/references/kraken_db
#kraken2-build --download-library fungi --db /scratch/cbi/Tapir/references/kraken_db
#kraken2-build --download-library plant --db /scratch/cbi/Tapir/references/kraken_db

# Build the db
kraken2-build --build --db /scratch/cbi/Tapir/references/kraken_db
