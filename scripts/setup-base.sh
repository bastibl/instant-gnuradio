#!/bin/bash

set -exu

while (sudo fuser /var/lib/apt/lists/lock) >/dev/null 2>&1 ; do
	echo "Another package manager is currently using apt/lists. Waiting..."
	sleep 1s
done
while (sudo fuser /var/lib/dpkg/lock) >/dev/null 2>&1 ; do
	echo "Another package manager is currently using dpkg. Waiting..."
	sleep 1s
done

sudo apt-get -y remove update-notifier update-manager
sudo killall update-notifier || echo "update notifier not running"
sleep 5s
sudo apt-get -y remove apport gnome-initial-setup
sudo apt-get update

sudo apt-get -y install clang cmake cmake-qt-gui curl dconf-editor git git-core git-gui gitk gparted htop libboost-all-dev meld open-vm-tools-desktop pavucontrol screen silversearcher-ag terminator tig tmux tree virtualbox-guest-utils wget xterm xvfb

### Drivers
sudo apt-get -y remove virtualbox-guest-x11
sudo apt-get -y install bcmwl-kernel-source
sudo apt-get -y install exfatprogs exfat-fuse

### WIRESHARK
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo apt-get -y install wireshark
sudo usermod -aG wireshark gnuradio
sudo usermod -aG plugdev gnuradio

### ZSH
sudo apt-get -y install zsh
mkdir -p src
git clone https://github.com/robbyrussell/oh-my-zsh.git src/oh-my-zsh
sudo chsh -s /bin/zsh gnuradio

### FONTS
fc-cache -fr

### VS Code
sudo snap install --classic code

### VIM
sudo apt-get -y install vim vim-gtk3
mkdir -p .vim/bundle
mkdir -p .swp
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +VundleInstall +qall

### WALLPAPER
xvfb-run -a dconf write /org/gnome/desktop/background/picture-uri \"file:///home/gnuradio/Pictures/wallpaper.png\"

### NAUTILUS
xvfb-run -a dconf write /org/gnome/nautilus/preferences/default-folder-viewer \"list-view\"
xvfb-run -a dconf write /org/gnome/nautilus/icon-view/default-zoom-level \"standard\"

### Desktop
# xvfb-run -a dconf write /org/gnome/desktop/background/show-desktop-icons true
# xvfb-run -a dconf write /org/gnome/nautilus/desktop/home-icon-visible true
# xvfb-run -a dconf write /org/gnome/nautilus/desktop/network-icon-visible false
# xvfb-run -a dconf write /org/gnome/nautilus/desktop/trash-icon-visible true
# xvfb-run -a dconf write /org/gnome/nautilus/desktop/volumes-visible false

### Screen Blanking
xvfb-run -a dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-timeout 'int32 0'
xvfb-run -a dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-timeout 'int32 0'
xvfb-run -a dconf write /org/gnome/desktop/session/idle-delay 'uint32 0'

### GNOME Updates
# xvfb-run -a dconf write /org/gnome/software/allow-updates false
# xvfb-run -a dconf write /org/gnome/software/download-updates false

### CPU Freq
sudo apt-get -y install cpufrequtils
sudo systemctl stop cpufrequtils
sudo systemctl disable cpufrequtils
echo "GOVERNOR=\"performance\"" | sudo tee -a /etc/default/cpufrequtils

### Favorites
xvfb-run -a dconf write /org/gnome/shell/favorite-apps "['terminator.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"
