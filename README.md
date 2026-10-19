***Salmonella***** Enteritidis genome analysis**  
Commands used for the genomic analysis in the article "Comparative Genomic Analysis of _Salmonella_ Enteritidis from Kazakhstan in a Regional Context
".  
**Software**  
| | | |  
|-|-|-|  
| **Step** | **Tool** | **Version** |   
| Assembly download | NCBI Datasets CLI | — |   
| Read download | SRA Toolkit | — |   
| Nanopore read filtering | Filtlong | 0.3.1 |   
| Illumina assembly | Shovill | 1.4.2 |   
| Nanopore assembly | Flye | 2.9.6-b1802 |   
| Assembly QC | QUAST | 5.3.0 |   
| Serovar prediction | SISTR | 1.1.3 |   
| MLST | mlst | 2.35.0 |   
| AMR genes | StarAMR | 0.12.3 |   
| AMR genes | AMRFinderPlus | 4.2.7 (DB 2026-05-15.1) |   
| Virulence genes | ABRicate (VFDB) | 1.4.0 |   
| Core-genome alignment | Parsnp | 2.1.5 |   
| Recombination removal | Gubbins | 3.4.3 |   
| Phylogeny | IQ-TREE | 3.1.2 |   
| SNP distances | snp-dists | 0.8.2 |   
| Tree visualization | iTOL | v6 |   
| Statistics and plots | R / ggplot2 | 4.5.2 / 4.0.3 |   
   
**Workflow**  
The dataset combines public assemblies from NCBI and genomes assembled in this study from SRA reads (for isolates without an available assembly). All final assemblies are collected in genomes/ as <isolate ID>.fna.  
Scripts are in scripts/ and are run in order:  
**Data**  
- 00a_download_ncbi_assemblies.sh — download of public assemblies from NCBI; accessions and isolate IDs in samples_ncbi.tsv  
- 00b_download_reads.sh — download of SRA reads for isolates without an assembly (fasterq-dump)  
**Assembly** (only for isolates without an NCBI assembly)  
1. 01_assembly_illumina.sh — assembly of Illumina paired-end reads (Shovill), samples listed in samples_illumina.tsv  
2. 02_assembly_nanopore.sh — filtering of Nanopore reads (Filtlong: min length 1000 bp, best 90% kept) and assembly (Flye), samples listed in samples_nanopore.tsv  
**Analysis** (all genomes)  
1. 03_assembly_qc.sh — assembly quality assessment (QUAST). Assemblies were kept if total length was 4.0–6.5 Mb, N50 ≥ 10 kb and the number of contigs ≥ 500 bp was below 1000  
2. 04_typing.sh — serovar prediction (SISTR) and sequence typing (mlst)  
3. 05_amr_virulence.sh — resistance genes (StarAMR, AMRFinderPlus) and virulence genes (ABRicate + VFDB)  
4. 06_phylogeny.sh — core-genome alignment against S. Enteritidis P125109 (GCA_000009505.1), recombination removal, SNP distances and maximum-likelihood tree  
Isolate metadata and assembly quality metrics are provided in S1 Table of the article.  
