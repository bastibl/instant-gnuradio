#!/bin/bash

set -eux

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:${PATH}"

### PYBOMBS
sudo apt-get -y install python-pip
sudo pip install --upgrade pip

pip install --user PyBOMBS

pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git
pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git

mkdir -p /home/gnuradio/pybombs
pybombs prefix init /home/gnuradio/pybombs -a master
pybombs config default_prefix master
echo "source /home/gnuradio/pybombs/setup_env.sh" >> .zshrc

### RTL-SDR
pybombs install rtl-sdr
sudo cp pybombs/src/rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/

### HACKRF
sudo apt-get -y install libfftw3-dev
pybombs install hackrf
sudo cp pybombs/src/hackrf/host/libhackrf/53-hackrf.rules /etc/udev/rules.d/

### UHD
pybombs install uhd
sudo cp pybombs/src/uhd/host/utils/uhd-usrp.rules /etc/udev/rules.d/
pybombs/lib/uhd/utils/uhd_images_downloader.py

### GNU RADIO
pybombs install gnuradio
/home/gnuradio/pybombs/libexec/gnuradio/grc_setup_freedesktop
rm -rf .gnome/apps/gnuradio-grc.desktop

### GQRX
pybombs install gqrx
xdg-icon-resource install --context apps --novendor --size 96 Pictures/gqrx.png

### GR OSMOSDR
pybombs install gr-osmosdr

### FOSPHOR
sudo apt-get -y install libfreetype6-dev ocl-icd-opencl-dev python-opengl lsb-core
pybombs install gr-fosphor

cd Downloads
tar xvf opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz
sudo opencl_runtime_16.1.2_x64_rh_6.4.0.37/install.sh -s opencl-silent.cfg
cd ~/pybombs/src/gr-fosphor/build
set +u
source /home/gnuradio/pybombs/setup_env.sh
set -u
cmake -DOpenCL_LIBRARY=/opt/intel/opencl-1.2-6.4.0.37/lib64/libOpenCL.so ..
make
make install
cd

pybombs install gr-foo
pybombs install gr-ieee-80211
pybombs install gr-ieee-802154

### FAVORIT APPLICATIONS
xvfb-run dconf write /org/gnome/shell/favorite-apps "['gnuradio-grc.desktop', 'gqrx.desktop', 'terminator.desktop', 'gnuradio-web.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"

### The German Code
# xvfb-run dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'de')]"
