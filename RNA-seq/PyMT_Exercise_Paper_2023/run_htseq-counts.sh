#!/bin/bash

# Get current user
username=$(whoami)

# Get aboslute path of current directory
current_dir=$(pwd)

#####################################################################
######################## USER DEFINED VALUES ########################
#####################################################################

# Set the paths
alignment_dir="${current_dir}/alignments"
gtf_file="/home/${username}/bioinformatics/reference_genomes/GRCm39/Mus_musculus.GRCm39.109.gtf"
output_dir="${alignment_dir}/expression/htseq_counts"
jobs_to_run=20

#####################################################################
#####################################################################
#####################################################################

# Create the output directory if it doesn't exist
mkdir -p "${output_dir}"

# Export variables for GNU parallel
export alignment_dir gtf_file output_dir

# Define a function for running htseq-count
run_htseq_count() {
    bam_file=$1
    # Extract the file name without the path and file extension
    file_name=$(basename "${bam_file}" .bam)

    # Define the output file name
    output_file="${output_dir}/${file_name}.tsv"

    # Run htseq-count on the current .bam file and output to the .tsv file
    htseq-count --format bam --order pos --mode intersection-strict --stranded reverse --minaqual 1 --type exon --idattr gene_id "${bam_file}" "${gtf_file}" > "${output_file}"
}

# Export the function so GNU parallel can use it
export -f run_htseq_count

# Use GNU parallel to run the function on each .bam file in parallel
find "${alignment_dir}" -name "*.bam" | parallel -j ${jobs_to_run} run_htseq_count
