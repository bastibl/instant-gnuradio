#!/bin/bash

set -exu

echo "==> Updating list of repositories"
sudo apt-get -y update

echo "==> Upgrading Packages"
sudo apt-get -y upgrade

echo "==> Installing ubuntu-gnome-desktop"
sudo apt-get install -y gnome-shell ubuntu-gnome-desktop

echo "==> Disabling the release upgrader"
sudo sed -i 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo "Setting system locale to US"
sudo locale-gen
sudo localectl set-locale LANG="en_US.UTF-8"

echo "UseDNS no" | sudo tee -a /etc/ssh/sshd_config

echo "==> Customizing message of the day"
echo "Welcome to Instant GNU Radio!\n\n" | sudo tee -a /etc/motd

echo "==> Modifying User Dirs"
sudo sed -i s/enabled=True/enabled=False/g /etc/xdg/user-dirs.conf

echo "==> Creating User Dirs"
mkdir -p Documents
mkdir -p Downloads
mkdir -p Desktop
mkdir -p Pictures
mkdir -p src
mkdir -p .local/share/applications
mkdir -p .config/autostart
mkdir -p .config/terminator
mkdir -p .local/share/applications
mkdir -p .fonts
mkdir -p .vim/colors
