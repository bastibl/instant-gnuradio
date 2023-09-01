#!/bin/bash

set -eux

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:${PATH}"

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

cd
sudo mv 90-usrp.conf /etc/sysctl.d/

cd
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3/dist-packages' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3/site-packages' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3.10/dist-packages' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3.10/site-packages' >> .profile

cd /tmp
sudo mkdir /tmp/isomount
sudo mount -t iso9660 -o loop /home/sdr/VBoxGuestAdditions.iso /tmp/isomount

# Install the drivers
yes | sudo /tmp/isomount/VBoxLinuxAdditions.run || echo

# Cleanup
sudo umount isomount
sudo rm -rf isomount /home/sdr/VBoxGuestAdditions.iso

echo "sdr - rtprio 99" | sudo tee -a /etc/security/limits.conf
sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install jupyter jupyter-qtconsole jupyter-notebook python3-matplotlib python3-ipython python3-scipy python3-numpy python3-pip multimon-ng sox liborc-dev gr-fosphor gr-osmosdr gqrx-sdr inspectrum hackrf soapysdr-tools libsoapysdr-dev soapysdr0.8-module-{bladerf,hackrf,osmosdr,rtlsdr,uhd} gnuradio gr-rds gr-satellites rtl-sdr bladerf

sudo snap install urh

sudo groupadd usrp
sudo usermod -aG usrp sdr
sudo apt-get -y install clinfo mesa-utils
sudo usermod -aG video sdr
sudo usermod -aG dialout sdr
sudo usermod -aG lpadmin sdr

sudo apt-get -y install intel-opencl-icd lsb-core

sudo apt-get -y install uhd-host
sudo /usr/bin/uhd_images_downloader

cd ~/Downloads
tar xvf l_opencl_p_18.1.0.015.tgz
sudo l_opencl_p_18.1.0.015/install.sh -s opencl-silent.cfg

cd
xdg-icon-resource install --context apps --novendor --size 96 Pictures/fosphor-icon.png
xdg-icon-resource install --context apps --novendor --size 96 Pictures/futuresdr-icon.png
xdg-icon-resource install --context apps --novendor --size 96 Pictures/gqrx-icon.png
xdg-icon-resource install --context apps --novendor --size 96 Pictures/inspectrum-icon.png
xdg-icon-resource install --context apps --novendor --size 96 Pictures/urhpng.png

rm -rf Downloads/*

### FAVORITE APPLICATIONS
update-desktop-database ~/.local/share/applications
xvfb-run dconf write /org/gnome/shell/favorite-apps "['gnuradio-grc.desktop', 'gqrx.desktop', 'fosphor.desktop', 'inspectrum.desktop', 'urh.desktop', 'terminator.desktop', 'code_code.desktop', 'futuresdr-web.desktop', 'firefox_firefox.desktop', 'org.gnome.Nautilus.desktop']"

### The German Code
# xvfb-run dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'de')]"

curl https://sh.rustup.rs -sSf | sh -s -- -y
source ~/.cargo/env
rustup install nightly
rustup default nightly
rustup component add rust-src
rustup component add rust-analyzer
rustup target add wasm32-unknown-unknown

sudo apt-get -y install libfontconfig-dev libssl-dev
cargo install alacritty
cargo install bat
cargo install fd-find
cargo install cargo-asm
cargo install cargo-check
cargo install cargo-expand
cargo install cargo-update
cargo install cargo-watch
cargo install exa
cargo install procs
cargo install trunk
cargo install wasm-pack

git clone --recursive https://github.com/bastibl/FutureSDR ~/Desktop/futuresdr -b netsys

echo 'debconf debconf/frontend select Dialog' | sudo debconf-set-selections
