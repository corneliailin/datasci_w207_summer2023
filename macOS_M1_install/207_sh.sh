#!/bin/zsh
# Original Script by Michael Tay
# Updated by Kevin Stallone

# This script has been updated to check if conda has already been installed in addition to fixing the download error with curl. If conda isn't
# installed, the script checks what architecture your Mac is (arm64 or x86_64) and will install the appropriate version of MiniForge. If
# conda is already installed then the script will update your conda installation and add the Conda Forge channel as the priority repository
# for downloading packages.


if ! type "conda" > /dev/null; then
    echo 'Conda is not installed; will now install (MiniForge)'
    
    if [[ $(uname -p) == 'arm' ]]; then
        curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh -o ~/Downloads/Miniforge3.sh
    else
        curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-x86_64.sh -o ~/Downloads/Miniforge3.sh
    fi
    
    chmod +x ~/Downloads/Miniforge3.sh
    sh ~/Downloads/Miniforge3.sh
    rm ~/Downloads/Miniforge3.sh

else
    conda update -n base conda -y
    conda config --add channels conda-forge 
    conda config --set channel_priority strict
fi

# The following is Michael's original contribution with only slight changes

eval "$(conda shell.zsh hook)"
wait
conda env remove -n w207_final
conda create -n w207_final -y python=3.9
conda activate w207_final
conda install -y -c apple tensorflow-deps
python -m pip install tensorflow-macos
python -m pip install tensorflow-metal
python -m pip install torchvision
python -m pip install tensorflow-datasets
python -m pip install transformers
python -m pip install facets-overview
conda install -y ipykernel
ipython kernel install --user --name=w207
conda install -y numpy matplotlib pandas seaborn jupyterlab opencv tokenizers=0.12.1 mlxtend pydot pydotplus shap wordcloud geopandas osmnx
conda install -c conda-forge -y tqdm
conda install -y scikit-learn

conda deactivate
conda activate w207_final