#!/bin/bash
# Step 4. Serovar prediction and MLST
# Input: assemblies that passed QC (genomes/*.fna)

mkdir -p SISTR mlst

# Serovar prediction (cgMLST) with SISTR v1.1.3
sistr \
    --qc \
    --run-mash \
    --threads 4 \
    -f tab \
    -o SISTR/SISTR_all.tsv \
    genomes/*.fna

# Sequence types with mlst v2.35.0 (Salmonella enterica scheme, PubMLST)
mlst genomes/*.fna > mlst/mlst_all.tsv
