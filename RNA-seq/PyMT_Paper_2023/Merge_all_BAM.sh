#! /bin/bash

# Get current user
username=$(whoami)

#####################################################################
######################## USER DEFINED VALUES ########################
#####################################################################

# It should be the full path, don't use ~
alignments_dir="/home/${username}/bioinformatics/PyMT_Paper_2023/alignments"

# Path to Picard
picard="/home/${username}/bioinformatics/picard.jar"

# list of groups
groups=("FC" "FT" "MC" "MT")

#####################################################################
#####################################################################
#####################################################################

# Change to main project directory
cd ${alignments_dir}

# Loop through the bam files in the alignments_dir
for bam_file in "${alignments_dir}"/*.bam; do
  for
  # Extract the file name without the path and file extension
  file_name=$(basename ${bam_file} .bam)

for group in ${groups}; do

