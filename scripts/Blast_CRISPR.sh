makeblastdb -in virus_genomes.fasta -dbtype nucl -out /path/to/your_project/database/virus_genomes_db

blastn -task blastn-short \
  -evalue 0.001 \
  -perc_identity 100 \
  -qcov_hsp_perc 100 \
  -query /path/to/your_project/database/spacer/your_spacer_file.fasta \
  -db /path/to/your_project/database/virus_genomes_db \
  -outfmt "6 qseqid sseqid pident length qlen mismatch gapopen qcovs" \
  -num_threads 16 | \
  awk '$6 == 0 && $7 == 0' > output.txt
