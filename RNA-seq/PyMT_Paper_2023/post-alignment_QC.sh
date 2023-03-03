#! /bin/bash

# Get current user
username=$(whoami)

#####################################################################
######################## USER DEFINED VALUES ########################
#####################################################################

# It should be the full path, don't use ~
alignments_dir="/home/${username}/bioinformatics/PyMT_Paper_2023/alignments"

# Path to picard.jar
picard="/home/${username}/bioinformatics/picard.jar"

# Path to REF_FLAT file for your reference genomes
REF_FLAT="/home/${username}/bioinformatics/reference_genomes/GRCm39/Mus_musculus.GRCm39.109.ref_flat.txt"

# The picard flag based on your strandedness
# RF/fr-firststrand stranded (dUTP) = SECOND_READ_TRANSCRIPTION_STRAND
# FR/fr-secondstrand stranded (Ligation) = FIRST_READ_TRANSCRIPTION_STRAND
# Unstranded = NONE
STRAND=SECOND_READ_TRANSCRIPTION_STRAND

# Path to ribosomal intervals
RIBOSOMAL_INTERVALS="/home/${username}/bioinformatics/reference_genomes/GRCm39/ref_ribosome.interval_list"

# Path to reference bed file
REF_BED="/home/${username}/bioinformatics/reference_genomes/GRCm39/Mus_musculus.GRCm39.109.bed12"

# list of groups
groups=("FC" "FT" "MC" "MT")

#####################################################################
#####################################################################
#####################################################################

# Get current date and time
current_date=$(date +%Y-%m-%d_%H-%M-%S)

# Change directory
cd ${alignments_dir}

# Make flagstat directory
mkdir -p flagstat

# Run samtools flagstat on all individual .bam files
# Searching for *_* will find all the individual alignment files and skip the combined ones
find *_*.bam -exec echo samtools flagstat {} \> flagstat/{}.flagstat \; | sh

# Activate conda env
# Doing it this way instead of "conda activate bioinformatics" prevents conda init error
source /home/${username}/anaconda3/bin/activate bioinformatics

# Run fastqc on all individual .bam files in the directory
fastqc -t 24 *.bam

# Make new directory for the fastqc outputs and move
mkdir fastqc -p && mv *fastqc* fastqc

################################ Picard #############################

# Make directory for Picard in the alignments folder
mkdir -p picard

# Run picard on all individual .bam files using CollectRnaSeqMetrics
find *_*.bam -exec echo java -jar ${picard} CollectRnaSeqMetrics I={} O=picard/{}.RNA_Metrics REF_FLAT=${REF_FLAT} STRAND=${STRAND} RIBOSOMAL_INTERVALS=${RIBOSOMAL_INTERVALS} \; | sh

############################# rseqc #################################

# Make directory for rseqc
mkdir -p rseqc

# Loop through each group
# for group in "${groups[@]}"; do
#   # Create empty array to store .bam file names
#   bam_files=()
#
#   # Loop through the BAM files in the directory and add the ones that contain the group name to the array
#   for bam_file in "${alignments_dir}"/*"${group}"*.bam; do
#     # Extract the file name without the path and file extension
#     file_name=$(basename ${bam_file} .bam)
#
#     # Check if the file name contains the group name
#     if [[ ${file_name} != "${group}" ]]; then
#       continue
#     fi
#
#     # Add the file name to the array
#     bam_files+=("${bam_file}")
#   done
#
#   # Check if there are any BAM files for this group
#   if [ ${#bam_files[@]} -eq 0 ]; then
#     echo "No BAM files found for group ${group}"
#     continue
#   fi
#
#   # Join the BAM file names into a comma-separated list
#   bam_file_list=$(IFS=,; echo "${bam_files[*]}")
#
#   # Run the geneBody_coverage.py command with the BAM files for this group
#   geneBody_coverage.py -i "${bam_file_list}" -r "${REF_BED}" -o rseqc/"${group}"
# done

# Run geneBody_coverage
geneBody_coverage.py -i Pistilli_P11B_FC1_S1_L001_001.bam, Pistilli_P11D_FC2_S2_L001_001.bam, Pistilli_P13B_FC3_S3_L001_001.bam, Pistilli_P13C_FC4_S4_L001_001.bam, Pistilli_P13E_FC5_S5_L001_001.bam -r "${REF_BED}" -o rseqc/FC

geneBody_coverage.py -i Pistilli_P12BL_FT1_S6_L001_001.bam, Pistilli_P12CRR_FT2_S7_L001_001.bam, Pistilli_P13A_FT3_S8_L001_001.bam, Pistilli_P14E_FT4_S9_L001_001.bam, Pistilli_P13F_FT5_S10_L001_001.bam -r "${REF_BED}" -o rseqc/FT

geneBody_coverage.py -i Pistilli_P186-5_MC1_S11_L001_001.bam, Pistilli_P186-7_MC2_S12_L001_001.bam, Pistilli_P189-1_MC3_S13_L001_001.bam, Pistilli_P187-1_MC4_S14_L001_001.bam, Pistilli_P188-2_MC5_S15_L001_001.bam -r "${REF_BED}" -o rseqc/MC

geneBody_coverage.py -i Pistilli_P187-3_MT1_S16_L001_001.bam, Pistilli_P186-6_MT2_S17_L001_001.bam, Pistilli_P188-1_MT3_S18_L001_001.bam, Pistilli_P188-4_MT4_S19_L001_001.bam, Pistilli_P188-5_MT5_S20_L001_001.bam -r "${REF_BED}" -o rseqc/MT

# Run more rseqc commands, still in the alignments dir
find *_*.bam -exec echo inner_distance.py -i {} -r "${REF_BED}" -o rseqc/{} \; | sh
find *_*.bam -exec echo junction_annotation.py -i {} -r "${REF_BED}" -o rseqc/{} \; | sh
find *_*.bam -exec echo junction_saturation.py -i {} -r "${REF_BED}" -o rseqc/{} \; | sh
find *_*.bam -exec echo read_distribution.py -i {} -r "${REF_BED}" \> rseqc/{}.read_dist.txt \; | sh
find *_*.bam -exec echo RNA_fragment_size.py -i {} -r "${REF_BED}" \> rseqc/{}.frag_size.txt \; | sh
find *_*.bam -exec echo bam_stat.py -i {} \> {}.bam_stat.txt \; | sh
rm -f log.txt

# Run multiqc in same directory as the fastqc reports
multiqc ./

# Rename the multiqc report
rename multiqc_report post-alignment_multiqc_report_${current_date} ${alignments_dir}/multiqc_report.html


