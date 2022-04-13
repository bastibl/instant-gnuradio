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

echo "==> Updating list of repositories"
sudo apt-get -y update

echo "==> adding apt-smart from pip and updating apt mirror"
sudo apt-get -y install python3-pip
sudo pip3 install apt-smart
sudo apt-smart --auto-change-mirror

echo "==> Upgrading Packages"
sudo apt-get upgrade --fix-missing -y

echo "==> Installing ubuntu-gnome-desktop"
sudo apt-get install -y network-manager
sudo systemctl start NetworkManager
sudo apt-get install -y gnome-shell ubuntu-gnome-desktop

### NICER GDM SCREEN
sudo update-alternatives --set gdm3-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresource

### NO WAYLAND
sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm3/custom.conf

echo "==> Disabling the release upgrader"
sudo sed -i 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo "Setting system locale to US"
sudo locale-gen
sudo localectl set-locale LANG="en_US.UTF-8"

echo "UseDNS no" | sudo tee -a /etc/ssh/sshd_config

echo "==> Custom Message of the Day"
echo -e "\nWelcome to Instant GNU Radio\n" | sudo tee -a /etc/motd

echo "==> Stop Creating User Dirs"
sudo sed -i s/enabled=True/enabled=False/g /etc/xdg/user-dirs.conf

echo "==> Creating User Dirs"
mkdir -p bin
mkdir -p Documents
mkdir -p Downloads
mkdir -p Desktop
mkdir -p Pictures
mkdir -p src
mkdir -p .local/share/applications
mkdir -p .config/autostart
mkdir -p .config/terminator
mkdir -p .fonts
mkdir -p .vim/colors
