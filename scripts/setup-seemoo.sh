#!/bin/bash

set -eux

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:${PATH}"


cd ~/cricom/gr-powerswitch
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

cd ~/cricom/gr-keyfob
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

