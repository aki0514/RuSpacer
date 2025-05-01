#!/bin/bash

# Input and output
input_file="your_genome.fa"
output_dir="crispr_output"

# Extract genome name from input filename (remove .fa extension)
genome_name=$(basename "$input_file" .fa)

# Run CRISPRCasFinder using Singularity
singularity exec CrisprCasFinder.simg perl /usr/local/CRISPRCasFinder/CRISPRCasFinder.pl \
  -so /usr/local/CRISPRCasFinder/sel392v2.so \
  -cf /usr/local/CRISPRCasFinder/CasFinder-2.0.3 \
  -drpt /usr/local/CRISPRCasFinder/supplementary_files/repeatDirection.tsv \
  -rpts /usr/local/CRISPRCasFinder/supplementary_files/Repeat_List.csv \
  -def G \
  -out "$output_dir" \
  -in "$input_file"

# Extract spacers with Evidence Level 3 or 4
cat "$output_dir/result.json" | jq -r \
  '.Sequences[].Crisprs[] | select(.Evidence_Level == 4 or .Evidence_Level == 3) | .Regions[] | select(.Type == "Spacer") | .Sequence' \
  | awk -v genome_name="$genome_name" '{print ">" genome_name "_Sequence" NR "\n" $0}' \
  > "$output_dir/spacer.fasta"
