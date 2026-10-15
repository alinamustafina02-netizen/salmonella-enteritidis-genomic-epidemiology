#!/bin/bash
# Step 3. Collecting assemblies and quality assessment with QUAST v5.3.0
# NCBI assemblies are already in genomes/ after step 0a.
# Assemblies made in this study are copied there under their isolate IDs
# (Shovill -> contigs.fa, Flye -> assembly.fasta).

mkdir -p genomes

while IFS=$'\t' read acc isolate; do
    cp assemblies/${acc}/contigs.fa genomes/${isolate}.fna
done < samples_illumina.tsv

while IFS=$'\t' read acc isolate; do
    cp assemblies/${acc}/assembly.fasta genomes/${isolate}.fna
done < samples_nanopore.tsv

quast.py genomes/*.fna -o quast_results -t 8

# Assemblies were retained if: total length 4.0-6.5 Mb, N50 >= 10 kb,
# and number of contigs >= 500 bp below 1000 (see quast_results/report.tsv).
# Assemblies that failed these criteria were removed from genomes/,
# all following steps use genomes/*.fna.
