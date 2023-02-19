# load the required libraries
library(ballgown)
library(genefilter)
library(dplyr)
library(devtools)

# Create phenotype data needed for ballgown analysis
ids=c("Control_1","Control_2","Control_3","Control_4","PDX_1","PDX_2","PDX_3","PDX_4")
type=c("Control","Control","Control","Control","PDX","PDX","PDX","PDX")
results="/home/user/bioinformatics/BP_PRJNA496042/alignments/expression/stringtie/ref_only/" # be sure to include "/" at the end of the path
path=paste(results,ids,sep="")
pheno_data=data.frame(ids,type,path)

# Load ballgown data structure and save it to a variable "bg"
bg = ballgown(samples=as.vector(pheno_data$path), pData=pheno_data)

# Display a description of this object
bg

# Load all attributes including gene name
bg_table = texpr(bg, 'all')
bg_gene_names = unique(bg_table[, 9:10])

# Save the ballgown object to a file for later use
save(bg, file='/home/user/bioinformatics/BP_PRJNA496042/alignments/de/ballgown/ref_only/bg.rda')

# Perform differential expression (DE) analysis with no filtering
results_transcripts = stattest(bg, feature="transcript", covariate="type", getFC=TRUE, meas="FPKM")
results_genes = stattest(bg, feature="gene", covariate="type", getFC=TRUE, meas="FPKM")
results_genes = merge(results_genes, bg_gene_names, by.x=c("id"), by.y=c("gene_id"))

# Save a tab delimited file for both the transcript and gene results
write.table(results_transcripts, "/home/user/bioinformatics/BP_PRJNA496042/alignments/de/ballgown/ref_only/Control_vs_PDX_transcript_results.tsv", sep="\t", quote=FALSE, row.names = FALSE)
write.table(results_genes, "/home/user/bioinformatics/BP_PRJNA496042/alignments/de/ballgown/ref_only/Control_vs_PDX_gene_results.tsv", sep="\t", quote=FALSE, row.names = FALSE)

# Filter low-abundance genes. Here we remove all transcripts with a variance across the samples of less than one
bg_filt = subset (bg,"rowVars(texpr(bg)) > 1", genomesubset=TRUE)

# Load all attributes including gene name
bg_filt_table = texpr(bg_filt , 'all')
bg_filt_gene_names = unique(bg_filt_table[, 9:10])

# Perform DE analysis now using the filtered data
results_transcripts = stattest(bg_filt, feature="transcript", covariate="type", getFC=TRUE, meas="FPKM")
results_genes = stattest(bg_filt, feature="gene", covariate="type", getFC=TRUE, meas="FPKM")
results_genes = merge(results_genes, bg_filt_gene_names, by.x=c("id"), by.y=c("gene_id"))

# Output the filtered list of genes and transcripts and save to tab delimited files
write.table(results_transcripts, "/home/user/bioinformatics/BP_PRJNA496042/alignments/de/ballgown/ref_only/Control_vs_PDX_transcript_results_filtered.tsv", sep="\t", quote=FALSE, row.names = FALSE)
write.table(results_genes, "/home/user/bioinformatics/BP_PRJNA496042/alignments/de/ballgown/ref_only/Control_vs_PDX_gene_results_filtered.tsv", sep="\t", quote=FALSE, row.names = FALSE)

# Identify the significant genes with p-value < 0.05
sig_transcripts = subset(results_transcripts, results_transcripts$pval<0.05)
sig_genes = subset(results_genes, results_genes$pval<0.05)

# Output the significant gene results to a pair of tab delimited files
write.table(sig_transcripts, "/home/user/bioinformatics/BP_PRJNA496042/alignments/de/ballgown/ref_only/Control_vs_PDX_transcript_results_sig.tsv", sep="\t", quote=FALSE, row.names = FALSE)
write.table(sig_genes, "/home/user/bioinformatics/BP_PRJNA496042/alignments/de/ballgown/ref_only/Control_vs_PDX_gene_results_sig.tsv", sep="\t", quote=FALSE, row.names = FALSE)

# Exit the R session
quit(save="no")
