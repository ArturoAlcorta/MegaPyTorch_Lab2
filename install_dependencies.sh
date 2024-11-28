#!/bin/bash

cd ..

source /opt/anaconda3/etc/profile.d/conda.sh

# create environment
conda create --name MEGA -y python=3.7
conda activate MEGA

# this installs the right pip and dependencies for the fresh python
yes | conda install ipython pip

# mega and coco api dependencies
yes | pip install ninja yacs cython matplotlib tqdm opencv-python scipy

# follow PyTorch installation in https://pytorch.org/get-started/locally/
# we give the instructions for CUDA 10.0
yes | conda install pytorch=1.2.0 torchvision=0.4.0 cudatoolkit=10.0 -c pytorch

export INSTALL_DIR=$PWD

# install pycocotools
cd $INSTALL_DIR
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
python setup.py build_ext install

# install cityscapesScripts
cd $INSTALL_DIR
git clone https://github.com/mcordts/cityscapesScripts.git
cd cityscapesScripts/
python setup.py build_ext install

# install apex
cd $INSTALL_DIR
git clone https://github.com/NVIDIA/apex.git
cd apex
git checkout e3794f422628d453b036f69de476bf16a0a838ac
python setup.py install

# install PyTorch Detection
cd $INSTALL_DIR
git clone https://github.com/Scalsol/mega.pytorch.git
cd mega.pytorch

# the following will install the lib with
# symbolic links, so that you can modify
# the files if you want and won't need to
# re-build it
python setup.py build develop

pip install 'pillow<7.0.0'

unset INSTALL_DIR
