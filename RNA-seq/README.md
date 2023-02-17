# RNA-seq

This folder contains different versions of RNA-seq pipelines. At the moment it is only the one based on [rnabio.org](https://rnabio.org). I will create different verisons of this as I learn and refine it. At the moment it is just using typical command-line programs or R scripts, a detailed list is provided in the pipeline.

I plan to try using other RNA-seq tools such as ones written in Python and Julia to see which works best for my use cases.

- **RNA-seq_pipeline_practice_v1.0.0.ipynb** - The first full verison of the pipeline is now finished. It covers everything from raw fastq data processing, pre-alignment QC, alignment, post-alignment QC, expression, differential expression, visualization, batch correction, and pathway analysis. Other things can be added beyond that, but depends on usecase.
- **RNA-seq_BioProject_PRJNA496042_pipeline.ipynb** - This is a full run of the pipeline on a real, complete dataset to test its functionality and generalizability to other datasets. Link to the full dataset can be found on [BioProject - Accession PRJNA496042](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA496042).

# Future improvements

Just running this from Juptyer lab everytime I want to process a new dataset is obviously not a very efficient workflow. After the pipeline is working well and seems to cover everything I need it to that will be the next step.

- I'll probably separate each step out into either shell scripts or python files that incorporate running shell commands.
- Write a script to automatically log the versions of all installed software before running the pipeline.

# List of programs

This is meant to be a mostly exhaustive list of the software used in this pipeline, in no specific order. You can refer to [here](https://rnabio.org/module-00-setup/0000/10/01/Installation/) for some additional info. Some of these programs can be installed through your pacakge manager, depending on what distro you're using. Others you will either need to download a pre-compiled binary and execute yourself or build from source.

### Running programs

For programs that need to be downloaded, it is best to keep them all in the same location, ideally in your home folder (e.g. ```/home/user/bioinformatics/```). To run downloaded programs, you likely will need to prefix them with a dot-slash, assuming you are in the same directory as the program.

```
./program-name
```

### Environment

You will also need to setup an environment manager to install and run some programs, [Anaconda](https://www.anaconda.com/products/distribution) is recommended as it should also install jupyter lab which can be run with ```jupyter lab``` from a terminal. It is highly recommended to create an environment specifically for bioinformatics work, or even this pipeline. You can activate a conda environment from terminal with ```conda activate environment-name```. 

### Programs

It is best practice to make note of the specific versions you use in the pipeline. 

- [Samtools](https://www.htslib.org/)
    - [Github](https://github.com/samtools/samtools), [docs](https://www.htslib.org/doc/samtools.html), [SAM format specification](https://samtools.github.io/hts-specs/SAMv1.pdf), [Samtools github.io](https://samtools.github.io/)
- [bam-readcount](https://github.com/genome/bam-readcount)
- [HISAT2](https://daehwankimlab.github.io/hisat2/)
    - [docs](https://daehwankimlab.github.io/hisat2/manual/), [pre-built indexes](https://daehwankimlab.github.io/hisat2/download/)
- [StringTie](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)
- [gffcompare](https://ccb.jhu.edu/software/stringtie/gffcompare.shtml)
    - [Github](https://github.com/gpertea/gffcompare)
- [htseq-count](https://htseq.readthedocs.io/en/master/install.html)
    - [Github](https://github.com/htseq/htseq)
    - Need conda env active
- [TopHat](https://ccb.jhu.edu/software/tophat/index.shtml)
    - TopHat is largely deprecated, it is only installed to use the ```gtf_to_fasta``` tool if you're using the pseudoalignment approach with kallisto.
- [kallisto](https://pachterlab.github.io/kallisto/)
    - [docs](https://pachterlab.github.io/kallisto/manual), [Github](https://github.com/pachterlab/kallisto)
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
    - [docs](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/)
- [MultiQC](https://multiqc.info/)
    - [docs](https://multiqc.info/docs/), [Github](https://www.github.com/ewels/MultiQC)
- [Picard](https://broadinstitute.github.io/picard/)
    - [Github](https://github.com/broadinstitute/picard), [docs](https://broadinstitute.github.io/picard/command-line-overview.html#Overview)
- [Flexbar](https://github.com/seqan/flexbar)
    - [docs](https://github.com/seqan/flexbar/wiki)
- [RegTools](https://github.com/griffithlab/regtools#regtools)
    - [docs](https://regtools.readthedocs.io/en/latest/)
- [RSeQC](https://rseqc.sourceforge.net/)
    - Install via pip3 in conda env
- [bedops](https://bedops.readthedocs.io/en/latest/)
    - [docs](https://bedops.readthedocs.io/en/latest/content/reference/set-operations/bedops.html)
- [gtfToGenePred](https://bioconda.github.io/recipes/ucsc-gtftogenepred/README.html)
- [genePredToBed](https://bioconda.github.io/recipes/ucsc-genepredtobed/README.html)
- [how_are_we_stranded_here](https://github.com/signalbash/how_are_we_stranded_here)
    - Install via pip3 in conda env
- [Cell Ranger](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/installation)
- [tabix](https://www.htslib.org/download/)
    - This seems to be a dependency of sammtools and bcftools, and is included with ```HTSlib```. Install that if needed.
- [BWA](https://bio-bwa.sourceforge.net/bwa.shtml)
    - [Github](https://github.com/lh3/bwa)
- [BCFtools](https://www.htslib.org/download/)
- [peddy](https://github.com/brentp/peddy)
    - Install via pip3 in conda env
- [slivar](https://github.com/brentp/slivar)
- [STRling](https://strling.readthedocs.io/en/latest/index.html)
    - [Github](https://github.com/quinlan-lab/STRling)
- [freebayes](https://github.com/freebayes/freebayes)
- [IGV](https://igv.org/)

### R libraries

If needed, install the latest verions of [R](http://www.r-project.org/).

- [devtools](https://cran.r-project.org/web/packages/devtools/index.html)
- [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)
- [gplots](https://cran.r-project.org/web/packages/gplots/index.html)
- [ggplot2](https://ggplot2.tidyverse.org/)
- [UpSetR](https://cran.r-project.org/web/packages/UpSetR/index.html)

You should be able to install all of the needed libs by starting an R session in a terminal by typing ```R``` and executing 
```
install.packages(c("devtools","dplyr","gplots","ggplot2","UpSetR"),repos="http://cran.us.r-project.org")
```

### Bioconductor libraries

If needed, install [Bioconductor](https://www.bioconductor.org/) by starting an R session in a terminal by typing ```R``` and executing
```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "X.XX")
```
replacing ```X.XX``` with the current version of Bioconductor.

- [genefilter](https://bioconductor.org/packages/release/bioc/html/genefilter.html)
- [ballgown](http://bioconductor.org/packages/release/bioc/html/ballgown.html)
- [edgeR](http://www.bioconductor.org/packages/release/bioc/html/edgeR.html)
- [GenomicRanges](http://bioconductor.org/packages/release/bioc/html/GenomicRanges.html)
- [rhdf5](https://www.bioconductor.org/packages/release/bioc/html/rhdf5.html)
- [biomaRt](https://bioconductor.org/packages/release/bioc/html/biomaRt.html)
- [sva](https://www.bioconductor.org/packages/release/bioc/html/sva.html)
- [GAGE](https://bioconductor.org/packages/release/bioc/html/gage.html)

### Sleuth (R lib from source)

[Source](https://pachterlab.github.io/sleuth/download). Install with
```
devtools::install_github("pachterlab/sleuth")
```

# Overall flow of the pipeline

1. Ensure that all necessary software is installed and working.
2. Obtain the necessary reference genome (.fa) and corresponding annotations (.gtf) file. These **MUST** be from the **same source** and correspond with the **same version** of reference genome in order to work properly. I.e., GRCm38 refernce genome must also have an annotation file built for GRCm38, and these should be obtained from the same source.
    - Probably the two main sources are [Ensembl](https://useast.ensembl.org/index.html) and [UCSC]().

# Useful Links

- [IGV website](https://software.broadinstitute.org/software/igv/home)
    - [IGV long tutorial](https://rnabio.org/assets/module_2/IGV_Tutorial_Long_BroadInstitute.pdf)
- [HISAT2 github](https://github.com/DaehwanKimLab/hisat2)
- [StringTie manual](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)
