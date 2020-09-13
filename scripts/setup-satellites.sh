#!/bin/bash

set -eux

sudo pip3 install construct

cd
cd src
git clone https://github.com/bastibl/gr-dslwp.git
cd gr-dslwp
git checkout maint38
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

cd
cd src
git clone https://github.com/daniestevez/gr-satellites.git
cd gr-satellites
git checkout maint-3.8
git submodule init
git submodule update
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

cd
git clone https://github.com/daniestevez/grcon2020-workshop.git
cd grcon2020-workshop/recordings
wget http://eala.destevez.net/~daniel/grcon2020-workshop/bepicolombo-8420535000Hz_20200404_151554.wav
wget http://eala.destevez.net/~daniel/grcon2020-workshop/solarorbiter-8427070000Hz_20200213_164325.wav

