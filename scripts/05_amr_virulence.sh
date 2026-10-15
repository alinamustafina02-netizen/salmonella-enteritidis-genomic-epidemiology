#!/bin/bash
# Step 5. Antimicrobial resistance and virulence genes
# Input: genomes/*.fna

mkdir -p AMRFinder results/abricate

# StarAMR v0.12.3 (ResFinder + PointFinder, organism Salmonella)
staramr search --pointfinder-organism salmonella --nprocs 4 -o StarAMR genomes/*.fna

# AMRFinderPlus v4.2.7, database version 2026-05-15.1 (organism Salmonella)
for f in genomes/*.fna; do
    id=$(basename "$f" .fna)
    amrfinder -n "$f" -O Salmonella --plus -o AMRFinder/${id}_raw.tsv
done

# Virulence genes: ABRicate v1.4.0 with VFDB
abricate --db vfdb genomes/*.fna > results/abricate/vfdb_results.tab
