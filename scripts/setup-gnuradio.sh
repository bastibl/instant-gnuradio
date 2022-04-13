#!/bin/bash

set -eux

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:${PATH}"

cd
sudo mv 90-usrp.conf /etc/sysctl.d/

cd
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3/dist-packages' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3/site-packages' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3.8/dist-packages' >> .profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3.8/site-packages' >> .profile

cd /tmp
sudo mkdir /tmp/isomount
sudo mount -t iso9660 -o loop /home/gnuradio/VBoxGuestAdditions.iso /tmp/isomount

# Install the drivers
yes | sudo /tmp/isomount/VBoxLinuxAdditions.run || echo

# Cleanup
sudo umount isomount
sudo rm -rf isomount /home/gnuradio/VBoxGuestAdditions.iso

echo "gnuradio - rtprio 99" | sudo tee -a /etc/security/limits.conf
sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install jupyter jupyter-qtconsole jupyter-notebook python3-matplotlib python3-ipython python3-scipy python3-numpy python3-pip multimon-ng sox liborc-dev swig3.0

sudo add-apt-repository -y ppa:gnuradio/gnuradio-releases
sudo add-apt-repository -y ppa:mormj/gnuradio-oot3
sudo apt-get update

sudo apt-get -y install gr-fcdproplus gr-fosphor gr-iqbal gr-limesdr gr-osmosdr

sudo apt-get -y install gqrx-sdr inspectrum

sudo snap install urh

sudo groupadd usrp
sudo usermod -aG usrp gnuradio
sudo apt-get -y install clinfo mesa-utils
sudo usermod -aG video gnuradio
sudo usermod -aG dialout gnuradio
sudo usermod -aG lpadmin gnuradio

sudo apt-get -y install intel-opencl-icd lsb-core

sudo /usr/lib/uhd/utils/uhd_images_downloader.py

cd ~/Downloads
tar xvf l_opencl_p_18.1.0.015.tgz
sudo l_opencl_p_18.1.0.015/install.sh -s opencl-silent.cfg

cd
xdg-icon-resource install --context apps --novendor --size 96 Pictures/gqrx-icon.png
xdg-icon-resource install --context apps --novendor --size 96 Pictures/inspectrum-icon.png
xdg-icon-resource install --context apps --novendor --size 96 Pictures/fosphor-icon.png
xdg-icon-resource install --context apps --novendor --size 96 Pictures/urhpng.png

rm -rf Downloads/*

### FAVORITE APPLICATIONS
xvfb-run dconf write /org/gnome/shell/favorite-apps "['gnuradio-grc.desktop', 'gqrx.desktop', 'fosphor.desktop', 'inspectrum.desktop', 'urh.desktop', 'terminator.desktop', 'code_code.desktop', 'gnuradio-web.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"

### The German Code
# xvfb-run dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'de')]"
