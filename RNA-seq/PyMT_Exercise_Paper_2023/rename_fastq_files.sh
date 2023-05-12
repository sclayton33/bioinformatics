#! /bin/bash

#####################################################################
######################## USER DEFINED VALUES ########################
#####################################################################

# It should be the full path, don't use ~
fastq_dir="/home/user/bioinformatics/PyMT_Exercise_Paper_2023"

#####################################################################
#####################################################################
#####################################################################

# Change directory
cd ${fastq_dir}

# Rename the files to be *.read1.fastq.gz, etc.
for f in *R1_001.fastq.gz; do mv "$f" "${f/R1_001/001.read1}"; done
for f in *R2_001.fastq.gz; do mv "$f" "${f/R2_001/001.read2}"; done
