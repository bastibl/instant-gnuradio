#!/bin/bash

set -exu

echo "==> Updating list of repositories"
sudo apt-get -y update

echo "==> Upgrading Packages"
sudo apt-get -y upgrade

echo "==> Installing ubuntu-gnome-desktop"
sudo apt-get install -y network-manager
sudo systemctl start NetworkManager
sudo apt-get install -y gnome-shell ubuntu-gnome-desktop
sudo update-alternatives --set gdm3.css /usr/share/gnome-shell/theme/gnome-shell.css

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
