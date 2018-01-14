#!/bin/bash

set -e
set -x

echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections

sudo apt -y install ubuntu-gnome-desktop
sudo apt -y install git git-gui gitk tig cmake libboost-all-dev curl wget htop vim vim-gnome terminator xterm python-apt clang tmux screen qemu xvfb


sudo apt -y install python-pip
sudo pip install --upgrade pip

pip install --user PyBOMBS

pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git
pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git
pybombs prefix init /home/gnuradio/pybombs -a myprefix
pybombs config default_prefix myprefix
pybombs config satisfy_order src,native
pybombs install gnuradio

# pybombs install limesuite
# pybombs install gqrx
#cd ~/pybombs/src/gr-osmosdr/build/
#git remote add argilo https://github.com/argilo/gr-osmosdr.git
#git fetch argilo
#git checkout allow-tr-switching
#. ~/pybombs/setup_env.sh
#make && make install
#~/pybombs/lib/uhd/utils/uhd_images_downloader.p

# sudo cp pybombs/src/osmo-sdr/software/libosmosdr/osmosdr.rules /etc/udev/rules.d/
# sudo cp pybombs/src/airspy/airspy-tools/52-airspy.rules /etc/udev/rules.d/
# sudo cp pybombs/src/rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/
# sudo cp pybombs/src/uhd/host/utils/uhd-usrp.rules /etc/udev/rules.d/
# sudo cp pybombs/src/hackrf/host/libhackrf/53-hackrf.rules /etc/udev/rules.d/
# sudo cp pybombs/src/limesuite/udev-rules/64-limesuite.rules /etc/udev/rules.d/
# sudo sed s/@BLADERF_GROUP@/plugdev/ pybombs/src/bladeRF/host/misc/udev/88-nuand.rules.in > /etc/udev/rules.d/88-nuand.rules




### WALLPAPER
gsettings set org.gnome.desktop.background picture-uri "file:///home/gnuradio/Pictures/wallpaper.png"

### CUSTOM DESKTOP ENTRIES

cat > .local/share/applications/gnuradio-web.desktop <<End-of-Message
[Desktop Entry]
Type=Application
Name=GNU Radio documentation online
Exec=firefox --class gnuradio-web -- 'https://wiki.gnuradio.org/index.php/Main_Page'
Icon=help-faq
Categories=Science;
StartupWMClass=gnuradio-web
End-of-Message

### FAVORIT APPLICATIONS
xvfb-run dconf write /org/gnome/shell/favorite-apps "['gnuradio-grc.desktop', 'terminator.desktop', gnuradio-web.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"

### SKIP INITIAL SETUP
sudo apt remove -y gnome-initial-setup
