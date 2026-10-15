#!/bin/bash
# Step 0b. For isolates without an assembly in NCBI: download of sequencing reads
# from SRA with SRA Toolkit.
# --split-3: paired-end runs give <SRR>_1.fastq and <SRR>_2.fastq,
# Nanopore runs give one <SRR>.fastq

cat samples_illumina.tsv samples_nanopore.tsv | while IFS=$'\t' read acc isolate; do
    fasterq-dump ${acc} --split-3
done
