# RetropathR installation
#
# Description: This script is to install RetropathRL application
#
# Written by: Eric Juo
#
# First written: Feb 07, 2024
# Last modified: Feb 07,2024

# ------------------------------------------
# Prerequisites
# -----------------------------------------
# RetroPathRL can only be run on Linux or MacOS machine.
#
# Prior to installation, virtual environment must be set up.
# Set up conda environment

conda create --name RetropathRL python=3.6
source activate RetropathRL
conda install -channel rdkit rdkit=2019.03.1.0
conda install pytest
conda install pyyaml

# ----------------------------------------
# Installation
# ---------------------------------------

# Clone RetropathRL repository
git clone https://github.com/brsynth/RetroPathRL.git

# Setup dependencies for RetroPathRL
cd RetroPathRL
pip install -e .


# Install scope viewer for later use. Scope viewer is to inspect the output tree in HTML.
git clone https://github.com/brsynth/scope-viewer.git

# Install toxicity calculator for later use.(Not available)
# conda install scikit-learn=0.19.1

# Set up database for caching
conda install pymongo
git clone https://github.com/brsynth/rp3_dcache.git
pip install -e .

# Download RetroRules
# Hydrogen handling: implicit
wget https://zenodo.org/record/5827969/files/retrorules_rr02_rp3_nohs.tar.gz
tar zxvf retrorules_rr02_rp3_nohs.tar.gz
# Hydrogen handling: explicit (Failed! Suggest download directly from RetroRules website)
wget https://zenodo.org/record/5827977/files/retrorules_rr03_rp3_hs.tar.gz
tar zxvf retrorules_rr02_rp3_hs.tar.gz

# Configure data path
python calculate_rule_sets_similarity.py --rule_address_with_H retrorules_rr02_rp3_hs/retrorules_rr02_flat_all.tsv --rule_address_without_H retrorules_rr02_rp3_nohs/retrorules_rr02_flat_all.tsv
python calculate_organisms.py

# Test run
python change_config.py --use_cache True --add_Hs True
pytest -v


# --------------------------------------------------------
# END
# ---------------------------------------------------------
