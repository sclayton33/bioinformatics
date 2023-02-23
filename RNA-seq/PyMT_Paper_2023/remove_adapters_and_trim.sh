#! /bin/bash

# Get current user
username=$(whoami)

#####################################################################
######################## USER DEFINED VALUES ########################
#####################################################################

# It should be the full path, don't use ~
fastq_dir="/home/${username}/bioinformatics/PyMT_Paper_2023"

# Sequencer multiplex file
multiplex="/home/${username}/bioinformatics/reference_genomes/GRCm38/illumina_multiplex.fa"

# Flexbar location
flexbar="/home/${username}/bioinformatics/flexbar-3.5.0-linux/flexbar"

#####################################################################
#####################################################################
#####################################################################

# Change directory
cd ${fastq_dir}

# Activate conda env
# Doing it this way instead of "conda activate bioinformatics" prevents conda init error
source /home/${username}/anaconda3/bin/activate bioinformatics

# Make trimmed directory and change to it
mkdir -p trimmed && cd trimmed

# Export flexbar to environment variable
export LD_LIBRARY_PATH=${flexbar}:$LD_LIBRARY_PATH

# Loop through all the paired read files in the directory
for read1_file in "${fastq_dir}"/*read1.fastq.gz; do
  # Extract the file name without the path and file extension
  file_name=$(basename ${read1_file} .read1.fastq.gz)

  # Determine the corresponding read2 file
  read2_file="${fastq_dir}/${file_name}.read2.fastq.gz"

  # Define the output file name
  output_file="${fastq_dir}/trimmed/${file_name}"

  # Run Flexbar on the read1 and read2 files and output to the output file
  cmd="${flexbar} --adapter-min-overlap 7 --adapter-trim-end RIGHT --adapters ${multiplex} --pre-trim-left 13 --max-uncalled 300 --min-read-length 25 --threads 24 --zip-output GZ --reads ${read1_file} --reads2 ${read2_file} --target ${output_file}"

  # Run command
  printf "Running command: ${cmd}\n"
  $cmd
done
