# RNA-seq

This folder contains different versions of RNA-seq pipelines. At the moment it is only the one based on [rnabio.org](https://rnabio.org). I will create different verisons of this as I learn and refine it. At the moment it is just using typical command-line programs, a detailed list is provided in the pipeline.

I plan to try using other RNA-seq tools such as ones written in Python and Julia to see which works best for my use cases.

- RNA-seq_pipeline_practice_v0.5.0.ipynb - once I am finished writing it, it will cover everything from raw fastq data processing, pre-alignment QC, alignment, post-alignment QC, expression, differential expression, visualization, batch correction, pathway analysis. Other things can be added beyond that, but depends on usecase.

## Useful Links

- [SAM format specification](https://samtools.github.io/hts-specs/SAMv1.pdf)
    - [Samtools github.io](https://samtools.github.io/)
- [IGV website](https://software.broadinstitute.org/software/igv/home)
    - [IGV long tutorial](https://rnabio.org/assets/module_2/IGV_Tutorial_Long_BroadInstitute.pdf)
- [HISAT2 github](https://github.com/DaehwanKimLab/hisat2)
- [StringTie manual](https://ccb.jhu.edu/software/stringtie/index.shtml?t=manual)
