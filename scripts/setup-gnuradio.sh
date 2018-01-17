#!/bin/bash

set -eux

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:${PATH}"

### PYBOMBS
sudo apt -y install python-pip
sudo pip install --upgrade pip

pip install --user PyBOMBS

pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git
pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git

mkdir -p /home/gnuradio/pybombs
pybombs prefix init /home/gnuradio/pybombs/master -a master
pybombs prefix init /home/gnuradio/pybombs/next -a next
pybombs config default_prefix master

pybombs install rtl-sdr
sudo cp pybombs/master/src/rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/

sudo apt-get -y install libfftw3-dev
pybombs install hackrf
sudo cp pybombs/master/src/hackrf/host/libhackrf/53-hackrf.rules /etc/udev/rules.d/

pybombs install uhd
sudo cp pybombs/master/src/uhd/host/utils/uhd-usrp.rules /etc/udev/rules.d/
pybombs/master/lib/uhd/utils/uhd_images_downloader.py

sudo apt-get -y install libwxgtk3.0-dev
pybombs install wxpython

pybombs install gnuradio

pybombs install gqrx
pybombs install gr-osmosdr
#pybombs install gr-fosphor
pybombs install gr-foo
pybombs install gr-ieee-80211
pybombs install gr-ieee-802154

### FAVORIT APPLICATIONS
xvfb-run dconf write /org/gnome/shell/favorite-apps "['gnuradio-grc.desktop', 'terminator.desktop', 'gnuradio-web.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"

### The German Code
xvfb-run dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'de')]"
