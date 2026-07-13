# Setup conda environment
source /GWSPH/home/cmloeffler/miniconda3/etc/profile.d/conda.sh
conda activate QC_Trim

# Make output directory if it does not already exist
mkdir -p ../Fastq/trim_130/paired
mkdir -p ../Fastq/trim_130/unpaired

# Trimmomatic
while read line
do
        trimmomatic PE ../Fastq/"$line"_L001_R1_001.fastq.gz ../Fastq/"$line"_L001_R2_001.fastq.gz \
                ../Fastq/trim_130/paired/"$line"_R1.fastq.gz ../Fastq/trim_130/unpaired/"$line"_R1.fastq.gz \
                ../Fastq/trim_130/paired/"$line"_R2.fastq.gz ../Fastq/trim_130/unpaired/"$line"_R2.fastq.gz \
                MINLEN:130 LEADING:20 TRAILING:20 AVGQUAL:28
done < ../files/sample_list.txt

# fastQC
mkdir -p ../QC/fastQCResults_trim_130
fastqc -t 6 ../Fastq/trim_130/paired/*.gz -o ../QC/fastQCResults_trim_130

echo 1>&2 "Finished FastQC for Trim"

# multiQC
multiqc ../QC/fastQCResults_trim_130 --interactive -o ../QC -n multiqc_trim_130

echo 1>&2 "Finished MultiQC for Trim"

