#! /bin/bash

# Get current user
username=$(whoami)

# Get current date and time
current_date=$(date +%Y-%m-%d_%H-%M-%S)

#####################################################################
######################## USER DEFINED VALUES ########################
#####################################################################

# It should be the full path, don't use ~
fastq_dir="/home/${username}/bioinformatics/PyMT_Paper_2023"

# It should be the full path, don't use ~
trimmed_fastq_dir="/home/${username}/bioinformatics/PyMT_Paper_2023/trimmed"

# Name of sequencing platform
platform="ILLUMINA"

# Path to HISAT2 index for reference genome minus the trailing .X.ht2
HISAT2_index="/home/${username}/bioinformatics/reference_genomes/GRCm39/Mus_musculus.GRCm39.dna.primary_assembly"

# Path to log file
log_file="${fastq_dir}/alignments_${current_date}.log"

# Number of threads for HISAT2 to use
p="24"

#####################################################################
#####################################################################
#####################################################################

# Change to main project directory
cd ${fastq_dir}

# Make alignments folder and cd
mkdir -p alignments && cd alignments

# Loop through all the paired read files in the directory
for read1_file in "${trimmed_fastq_dir}"/*_1.fastq.gz; do
  # Extract the file name without the path and file extension
  file_name=$(basename ${read1_file} _1.fastq.gz)

  # Determine the corresponding read2 file
  read2_file="${trimmed_fastq_dir}/${file_name}_2.fastq.gz"

  # Define the output file name
  output_file="${fastq_dir}/alignments/${file_name}"

  # Run Flexbar on the read1 and read2 files and output to the output file
  cmd="hisat2 -p ${p} --rg-id ${file_name} --rg SM:${file_name} --rg LB:${file_name}_Lib --rg PL:${platform} -x ${HISAT2_index} --dta -1 ${read1_file} -2 ${read2_file} -S ${output_file}.sam >> ${log_file} 2>&1"

  # Run command
  printf "Running command: ${cmd}\n"
  eval $cmd
done
