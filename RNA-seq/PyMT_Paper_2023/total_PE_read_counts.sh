#!/bin/bash

# Define the directory where the FASTQ files are located
# The script assumes they are all in one directory
fastq_dir="/home/user/bioinformatics/PyMT_Paper_2023"

# Define the instrument ID to use for searching, what comes after the @
inst_id="VH00"

# Read number format. I.e R1 and R2, Read_1 and Read_2
read_1=R1
read_2=R2

# Get current date and time
current_date=$(date +%Y-%m-%d_%H-%M-%S)

# Define the output file where the counts will be saved
output_file=${fastq_dir}/total_read_counts_${current_date}.txt

# Loop through all the R1 FASTQ files in the directory
for file_R1 in "${fastq_dir}"/*"${read_1}"*".fastq.gz"; do
  # Extract the file name without the path and file extension
  file_name=$(basename ${file_R1} | sed "s/${read_1}.*\.fastq\.gz//")
  printf "${file_name}\n"

  # Determine the total number of reads in the R1 file that start with the instrument ID
  count_R1=$(zcat ${file_R1} | grep -P "^\@${inst_id}" | wc -l)

  # Find the corresponding R2 file and determine the total number of reads in the R2 file
  file_R2="${fastq_dir}/${file_name}${read_2}*.fastq.gz"
  count_R2=$(zcat ${file_R2} | grep -P "^\@${inst_id}" | wc -l)

  # Set the string for the fourth column based on the equality of the read counts
  if [ ${count_R1} -eq ${count_R2} ]; then
    read_counts_status="EQUAL"
  else
    read_counts_status="UNEQUAL"
  fi

  printf "${file_name} ${count_R1} ${count_R2} ${read_counts_status}\n"

  # Write the file name, counts, and status to the output file
  echo "${file_name} ${count_R1} ${count_R2} ${read_counts_status}" >> ${output_file}
done
