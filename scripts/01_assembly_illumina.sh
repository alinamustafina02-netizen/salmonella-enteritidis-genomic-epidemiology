#!/bin/bash
# Step 1. Assembly of Illumina paired-end reads with Shovill v1.4.2
# samples_illumina.tsv: <SRR accession> <TAB> <isolate ID>
# Reads were downloaded from SRA with SRA Toolkit (fasterq-dump splits each run
# into <accession>_1.fastq and <accession>_2.fastq).
# --trim: adapter trimming is performed by Shovill itself.

while IFS=$'\t' read acc isolate; do
    shovill \
      --R1 ${acc}_1.fastq \
      --R2 ${acc}_2.fastq \
      --outdir assemblies/${acc} \
      --gsize 4.8M \
      --cpus 4 \
      --ram 8 \
      --trim
done < samples_illumina.tsv
