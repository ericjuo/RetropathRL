#!/bin/bash
set -e
# Run HA retrosynthesis pathway using RetropathRL
#
# Description: This script is to run HA biosynthesis pathway using RetropathRL
#
# Written by: Eric Juo
#
# First written: Feb 29, 2024
# Last modified: Feb 29,2024

# ------------------------------------------
# Main
# -----------------------------------------
InChI='InChI=1S/C28H44N2O23/c1-5(33)29-9-18(11(35)7(3-31)47-25(9)46)49-28-17(41)15(39)20(22(53-28)24(44)45)51-26-10(30-6(2)34)19(12(36)8(4-32)48-26)50-27-16(40)13(37)14(38)21(52-27)23(42)43/h7-22,25-28,31-32,35-41,46H,3-4H2,1-2H3,(H,29,33)(H,30,34)(H,42,43)(H,44,45)/t7-,8-,9-,10-,11-,12-,13+,14+,15-,16-,17-,18?,19?,20+,21+,22+,25-,26+,27-,28-/m1/s1'
NAME='HA'
OUTDIR='HA_03_03_with_H' # the first 03 detnotes biological score cutoff=0.3; the second denote chem score cutoff=0.3
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
    --c_name $NAME \
    --c_inchi $InChI \
    --folder_to_save $OUTDIR\
    --biological_score_cut_off $BIO_CUT \
    --substrate_only_score_cut_off 0.7 \
    --chemical_score_cut_off $CHEM_CUT \
    --minimal_visit_counts 1

echo "RetropathRL run succeed!"

