#!/bin/bash
set -e
# Run 5-ALA retrosynthesis pathway using RetropathRL
#
# Description: This script is to run 5-ALA biosynthesis pathway using RetropathRL
#
# Written by: Eric Juo
#
# First written: Feb 29, 2024
# Last modified: Feb 29,2024

# ------------------------------------------
# Main
# -----------------------------------------
ALA_InChI='InChI=1S/C5H9NO3/c6-3-4(7)1-2-5(8)9/h1-3,6H2,(H,8,9)'
ALA_name='5-ALA'
OUTDIR='RetroPathRL/5-ALA_03_03_no_H' # the first 03 detnotes biological score cutoff=0.3; the second denote chem score cutoff=0.3
BIO_CUT=0.3
CHEM_CUT=0.3
DIA='6 8 10 12 14 16'

python RetroPathRL/Tree.py \
    --log_file tree.log \
    --itermax 1000 \
    --expansion_width 10 \
    --time_budget 7200 \
    --max_depth 7 \
    --UCT_policy Biochemical_UCT_1 \
    --UCTK 20 \
    --bias_k 0 \
    --k_rave 0 \
    --Rollout_policy Rollout_policy_random_uniform_on_biochemical_multiplication_score \
    --max_rollout 3 \
    --chemical_scoring SubandprodChemicalScorer \
    --virtual_visits 0 \
    --progressive_bias_strategy 0 \
    --diameter $DIA \
    --c_name $ALA_name \
    --c_inchi $ALA_InChI \
    --folder_to_save $OUTDIR\
    --biological_score_cut_off $BIO_CUT \
    --chemical_score_cut_off $CHEM_CUT \
    --minimal_visit_counts 1

echo "RetropathRL run succeed!"

