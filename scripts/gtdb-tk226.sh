#!/bin/bash

# Set GTDB-Tk data path (update this according to your environment)
export GTDBTK_DATA_PATH=/your/conda/envs/gtdbtk-2.4.0/share/gtdbtk/release226

# Run GTDB-Tk classification
gtdbtk classify_wf \
  --genome_dir "$genome_dir" \
  --out_dir "$out_dir" \
  --cpus 1 \
  --extension fa \
  --pplacer_cpus 1 \
  --mash_db "$GTDBTK_DATA_PATH/gtdb-tk-r226.msh"
