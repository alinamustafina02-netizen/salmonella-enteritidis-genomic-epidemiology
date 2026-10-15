#!/bin/bash
# Step 2. Filtering and assembly of Oxford Nanopore reads
# Filtlong: reads shorter than 1000 bp removed, best 90% of bases kept
# Flye v2.9.6-b1802
# samples_nanopore.tsv: <SRR accession> <TAB> <isolate ID>

while IFS=$'\t' read acc isolate; do
    filtlong --min_length 1000 --keep_percent 90 ${acc}.fastq > ${acc}_filt.fastq

    flye \
      --nano-hq ${acc}_filt.fastq \
      --out-dir assemblies/${acc} \
      --threads 4 \
      --genome-size 4.8m
done < samples_nanopore.tsv
