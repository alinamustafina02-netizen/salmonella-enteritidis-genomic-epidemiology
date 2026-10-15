#!/bin/bash
# Step 6. Core-genome alignment, recombination removal, phylogeny and SNP distances
# Reference: S. Enteritidis P125109 (GCA_000009505.1) -> reference/reference.fna
# Input assemblies: genomes/

mkdir -p iqtree

# Core-genome alignment with Parsnp v2.1.5
parsnp -r reference/reference.fna -d genomes -o parsnp_result

# Convert Parsnp output to a FASTA alignment (HarvestTools)
harvesttools -x parsnp_result/parsnp.xmfa -M parsnp_alignment.fasta

# Removal of recombinant regions with Gubbins v3.4.3
run_gubbins.py --prefix enteritidis_gubbins parsnp_alignment.fasta

# Pairwise SNP distances with snp-dists v0.8.2
# (from the recombination-filtered polymorphic site alignment)
snp-dists enteritidis_gubbins.filtered_polymorphic_sites.fasta > snp_distance_matrix.tsv

# Maximum-likelihood tree with IQ-TREE v3.1.2
# GTR+ASC model, 1000 ultrafast bootstrap + 1000 SH-aLRT replicates
iqtree -s enteritidis_gubbins.filtered_polymorphic_sites.fasta \
       -m GTR+ASC -bb 1000 -alrt 1000 -nt AUTO \
       --prefix iqtree/enteritidis

# The tree was visualized in iTOL (https://itol.embl.de).
# Isolate RU01 was used to root the tree and then removed for display.
