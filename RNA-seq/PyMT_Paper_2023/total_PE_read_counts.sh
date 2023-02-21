#!/bin/bash

# Define the directory where the FASTQ files are located
fastq_dir="/home/user/bioinformatics/PyMT_Paper_2023"

# Define the output file where the counts will be saved
output_file="/home/user/bioinformatics/PyMT_Paper_2023/total_read_counts.txt"

# Loop through all the R1 FASTQ files in the directory
for file_R1 in ${fastq_dir}/*R1*.fastq.gz; do
  # Extract the file name without the path and file extension
  file_name=$(basename ${file_R1} _R1_001.fastq.gz)

  # Determine the total number of reads in the R1 file that start with "@VH00"
  count_R1=$(zcat ${file_R1} | grep -P "^\@VH00" | wc -l)

  # Find the corresponding R2 file and determine the total number of reads in the R2 file
  file_R2="${fastq_dir}/${file_name}_R2_001.fastq.gz"
  count_R2=$(zcat ${file_R2} | grep -P "^\@VH00" | wc -l)

  # Write the file name and counts to the output file
  echo "${file_name} ${count_R1} ${count_R2}" >> ${output_file}
done
