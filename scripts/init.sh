#!/bin/bash

set -e
set -x

sudo tee -a /etc/ssh/sshd_config <<EOF

UseDNS no
EOF

sudo apt update
sudo apt -y upgrade


if [ "$PACKER_BUILDER_TYPE" == "virtualbox-iso" ]; then

    sudo apt-get -y install dkms
    sudo apt-get -y install make

    # Uncomment this if you want to install Guest Additions with support for X
    #sudo apt-get -y install xserver-xorg

    sudo mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
    sudo /mnt/VBoxLinuxAdditions.run || :
    sudo umount /mnt/
    rm -f ~/VBoxGuestAdditions.iso

    VBOX_VERSION=$(cat ~/.vbox_version)
    if [ "$VBOX_VERSION" == '4.3.10' ]; then
        # https://www.virtualbox.org/ticket/12879
        sudo ln -s "/opt/VBoxGuestAdditions-$VBOX_VERSION/lib/VBoxGuestAdditions" /usr/lib/VBoxGuestAdditions
    fi
fi


if [ "$PACKER_BUILDER_TYPE" == "vmware-iso" ]; then

    sudo apt-get -y install open-vm-tools
    sudo mkdir -p /mnt/hgfs
fi


mkdir -p Documents
mkdir -p .local/share/applications

echo 'export PATH=~/.local/bin:${PATH}' >> .bashrc
. .bashrc
