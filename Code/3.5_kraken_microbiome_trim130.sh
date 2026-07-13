#!/bin/bash

#SBATCH --time 06:00:00

#SBATCH -p short-384gb

#SBATCH --mail-type=ALL
#SBATCH --mail-user=cmloeffler@gwu.edu

#SBATCH --export=ALL    # Takes the users environment

#SBATCH --exclude=cpu150,cpu139,cpu141,cpu114,cpu117,cpu120,cpu137,cpu147,cpu149,cpu123,cpu112,cpu122

#SBATCH -o Kraken_microbe_trim130_%j.out
#SBATCH -e Kraken_microbe_trim130_%j.err

module load kraken2/2.1.5

mkdir -p ../kraken_outs/trim_130/reports


echo 1>&2 "STARTED TRIM_130 KRAKEN2 ALIGNMENT ============================================="

while read filename
do
        echo 1>&2 "$filename started ---------------"
        kraken2 \
                --db /scratch/cbi/Tapir/references/kraken_db \
                --threads 35 \
                --paired \
                --gzip-compressed \
                --output ../kraken_outs/trim_130/${filename}.out \
                --report ../kraken_outs/trim_130/reports/${filename}_kraken_report \
                --use-names \
                ../Fastq/trim_130/paired/${filename}_R1.fastq.gz ../Fastq/trim_130/paired/${filename}_R2.fastq.gz
        echo 1>&2 "$filename Finished ---------------"
done < ../files/sample_list

echo 1>&2 "FINISHED TRIM_130 KRAKEN2 ALIGNMENT ============================================="
