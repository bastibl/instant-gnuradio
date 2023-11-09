#!/bin/bash

set -eux

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:${PATH}"


cd ~/Desktop/gr-powerswitch
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

cd ~/Desktop/gr-keyfob
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

