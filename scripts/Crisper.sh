singularity exec CrisprCasFinder.simg perl /usr/local/CRISPRCasFinder/CRISPRCasFinder.pl \
  -so /usr/local/CRISPRCasFinder/sel392v2.so \
  -cf /usr/local/CRISPRCasFinder/CasFinder-2.0.3 \
  -drpt /usr/local/CRISPRCasFinder/supplementary_files/repeatDirection.tsv \
  -rpts /usr/local/CRISPRCasFinder/supplementary_files/Repeat_List.csv \
  -def G \
  -out "$output_dir" \
  -in "$input_file"

cat "$output_dir/result.json" | jq -r \
  '.Sequences[].Crisprs[] | select(.Evidence_Level == 4 or .Evidence_Level == 3) | .Regions[] | select(.Type == "Spacer") | .Sequence' \
  | awk -v dir_name="$dir_name" '{print ">" dir_name "_Sequence" NR "\n" $0}' \
  > "$output_dir/spacer.fasta"