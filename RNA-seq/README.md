# RNA-seq

This folder contains different versions of RNA-seq pipelines. At the moment it is only the one based on [rnabio.org](https://rnabio.org). I will create different verisons of this as I learn and refine it. At the moment it is just using typical command-line programs or R scripts, a detailed list is provided in the pipeline.

I plan to try using other RNA-seq tools such as ones written in Python and Julia to see which works best for my use cases.

- RNA-seq_pipeline_practice_v1.0.0.ipynb - The first full verison of the pipeline is now finished. It covers everything from raw fastq data processing, pre-alignment QC, alignment, post-alignment QC, expression, differential expression, visualization, batch correction, and pathway analysis. Other things can be added beyond that, but depends on usecase.
- RNA-seq_BioProject_PRJNA496042_pipeline.ipynb - This is a full run of the pipeline on a real, complete dataset to test its functionality and generalizability to other datasets. Link to the full dataset can be found on [BioProject - Accession PRJNA496042](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA496042).

## Useful Links

- [SAM format specification](https://samtools.github.io/hts-specs/SAMv1.pdf)
    - [Samtools github.io](https://samtools.github.io/)
- [IGV website](https://software.broadinstitute.org/software/igv/home)
    - [IGV long tutorial](https://rnabio.org/assets/module_2/IGV_Tutorial_Long_BroadInstitute.pdf)
- [HISAT2 github](https://github.com/DaehwanKimLab/hisat2)
- [StringTie manual](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)
