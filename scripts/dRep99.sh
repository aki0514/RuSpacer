#!/bin/bash

# Dereplicate genome assemblies (e.g., metagenome-assembled genomes: MAGs) using dRep at 99% ANI

# input_dir: directory containing genome FASTA files (*.fa)
# output_dir: directory where the dereplication results will be saved

dRep dereplicate output_dir \
  -g input_dir/*.fa \
  -sa 0.99 \
  --S_algorithm fastANI \
  --ignoreGenomeQuality \
  --multiround_primary_clustering \
  --greedy_secondary_clustering \
  --run_tertiary_clustering \
  -p 8

