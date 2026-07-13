#!/bin/bash

#SBATCH --time 2-00:00:00

#SBATCH -p defq

#SBATCH --mail-type=ALL
#SBATCH --mail-user=cmloeffler@gwu.edu

#SBATCH --export=ALL    # Takes the users environment

#SBATCH --exclude=cpu150,cpu139,cpu141,cpu114,cpu117,cpu120,cpu137,cpu147,cpu149,cpu123,cpu112,cpu122,cpu098,cpu082

#SBATCH -o Braken_microbe_trim130_%j.out
#SBATCH -e Braken_microbe_trim130_%j.err

# Load module
module load bracken/2.0
module load kraken2/2.1.5

# Make the kracken DB Bracken compatable 
bracken-build -k 35 -l 150 -d /scratch/cbi/Tapir/references/kraken_db -t 30 -x /c1/apps/kraken2/2.1.5/

# Make output directory
mkdir -p ../braken_outs/trim_130/reports_Species

while read filename
do 

echo 1>&2 "$filename started ---------------------"

bracken -d /scratch/cbi/Tapir/references/kraken_db -i ../kraken_outs/trim_130/reports/${filename}_kraken_report -o ../braken_outs/trim_130/reports_Species/${filename}_braken_report -r 150 -l S

echo 1>&2 "$filename finished ---------------------"

done < ../files/sample_list 
