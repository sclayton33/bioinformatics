# RNA-seq

This folder contains different versions of RNA-seq pipelines. At the moment it is only the one based on [rnabio.org](https://rnabio.org). I will create different verisons of this as I learn and refine it. At the moment it is just using typical command-line programs or R scripts, a detailed list is provided in the pipeline.

I plan to try using other RNA-seq tools such as ones written in Python and Julia to see which works best for my use cases.

- **RNA-seq_pipeline_practice_v1.0.0.ipynb** - The first full verison of the pipeline is now finished. It covers everything from raw fastq data processing, pre-alignment QC, alignment, post-alignment QC, expression, differential expression, visualization, batch correction, and pathway analysis. Other things can be added beyond that, but depends on usecase.
- **RNA-seq_BioProject_PRJNA496042_pipeline.ipynb** - This is a full run of the pipeline on a real, complete dataset to test its functionality and generalizability to other datasets. Link to the full dataset can be found on [BioProject - Accession PRJNA496042](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA496042).

# Future improvements

Just running this from Juptyer lab everytime I want to process a new dataset is obviously not a very efficient workflow. After the pipeline is working well and seems to cover everything I need it to that will be the next step.

- I'll probably separate each step out into either shell scripts or python files that incorporate running shell commands.

# List of required and optional programs

This is meant to be a mostly exhaustive list of the software used in this pipeline, in no specific order. You can refer to [here](https://rnabio.org/module-00-setup/0000/10/01/Installation/) for some additional info. Some of these programs can be installed through your pacakge manager, depending on what distro you're using. Others you will either need to download a pre-compiled binary and execute yourself or build from source.

- [Samtools](https://www.htslib.org/) - [Github](https://github.com/samtools/samtools)

# Overall flow of the pipeline

1. Ensure that all necessary software is installed and working.
2. Obtain the necessary reference genome (.fa) and corresponding annotations (.gtf) file. These **MUST** be from the **same source** and correspond with the **same version** of reference genome in order to work properly. I.e., GRCm38 refernce genome must also have an annotation file built for GRCm38, and these should be obtained from the same source.
    - Probably the two main sources are [Ensembl](https://useast.ensembl.org/index.html) and [UCSC]().

# Useful Links

- [SAM format specification](https://samtools.github.io/hts-specs/SAMv1.pdf)
    - [Samtools github.io](https://samtools.github.io/)
- [IGV website](https://software.broadinstitute.org/software/igv/home)
    - [IGV long tutorial](https://rnabio.org/assets/module_2/IGV_Tutorial_Long_BroadInstitute.pdf)
- [HISAT2 github](https://github.com/DaehwanKimLab/hisat2)
- [StringTie manual](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)
