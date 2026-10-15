#!/bin/bash
# Step 0a. Download of publicly available assemblies from NCBI (NCBI Datasets CLI)
# samples_ncbi.tsv: <assembly accession> <TAB> <isolate ID>
# Each assembly is saved as genomes/<isolate ID>.fna

mkdir -p genomes

cut -f1 samples_ncbi.tsv > ncbi_accessions.txt
datasets download genome accession --inputfile ncbi_accessions.txt \
    --include genome --filename ncbi_assemblies.zip
unzip -o -q ncbi_assemblies.zip -d ncbi_assemblies

while IFS=$'\t' read acc isolate; do
    cp ncbi_assemblies/ncbi_dataset/data/${acc}/*_genomic.fna genomes/${isolate}.fna
done < samples_ncbi.tsv
