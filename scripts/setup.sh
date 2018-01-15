#!/bin/bash

set -e
set -x

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:${PATH}"

df -h

sudo apt -y install ubuntu-gnome-desktop
sudo apt -y install git git-gui gitk tig cmake libboost-all-dev curl wget htop terminator xterm python-apt clang tmux screen qemu xvfb silversearcher-ag
sudo apt-get clean

### PYBOMBS
sudo apt -y install python-pip
sudo pip install --upgrade pip

pip install --user PyBOMBS

pybombs recipes add gr-recipes git+https://github.com/gnuradio/gr-recipes.git
pybombs recipes add gr-etcetera git+https://github.com/gnuradio/gr-etcetera.git

df -h

mkdir -p /home/gnuradio/pybombs
pybombs prefix init /home/gnuradio/pybombs/master -a master
pybombs prefix init /home/gnuradio/pybombs/next -a next
pybombs config default_prefix master
pybombs config satisfy_order src,native

df -h

pybombs install rtl-sdr
sudo cp pybombs/master/src/rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/

df -h

sudo apt -y install libfftw3-dev
pybombs install hackrf
sudo cp pybombs/master/src/hackrf/host/libhackrf/53-hackrf.rules /etc/udev/rules.d/

df -h

pybombs install uhd
sudo cp pybombs/master/src/uhd/host/utils/uhd-usrp.rules /etc/udev/rules.d/
pybombs/master/lib/uhd/utils/uhd_images_downloader.py

df -h

pybombs install gnuradio

df -h

pybombs install gqrx
pybombs install gr-osmosdr
#pybombs install gr-fosphor
pybombs install gr-foo
pybombs install gr-ieee-80211
pybombs install gr-ieee-802154

### WIRESHARK
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo apt -y install wireshark

### ZSH
sudo apt -y install zsh
mkdir -p src
git clone https://github.com/robbyrussell/oh-my-zsh.git src/oh-my-zsh
sudo chsh -s /bin/zsh gnuradio

### FONTS
fc-cache -fr

### SPACEMACS
sudo apt -y install emacs25
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd .emacs.d
git checkout -b develop
git reset --hard origin/develop
cd ~
emacs --batch \
  --eval "(setq gc-cons-threshold 100000000)" \
  --eval "(defconst spacemacs-version         \"0.200.10\" \"Spacemacs version.\")" \
  --eval "(defconst spacemacs-emacs-min-version   \"24.4\" \"Minimal version of Emacs.\")" \
  --eval "(load-file \"/home/gnuradio/.emacs.d/core/core-load-paths.el\")" \
  --eval "(require 'core-spacemacs)" \
  --eval "(spacemacs/init)" \
  --eval "(configuration-layer/sync)"

### VIM
sudo apt -y install vim vim-gnome
mkdir -p .vim/bundle
mkdir -p .swp
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +VundleInstall +qall

### WALLPAPER
xvfb-run dconf write /org/gnome/desktop/background/picture-uri \"file:///home/gnuradio/Pictures/wallpaper.png\"

### FAVORIT APPLICATIONS
xvfb-run dconf write /org/gnome/shell/favorite-apps "['gnuradio-grc.desktop', 'terminator.desktop', 'gnuradio-web.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"

### SKIP INITIAL SETUP
sudo apt remove -y gnome-initial-setup
