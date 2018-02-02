#!/bin/bash

set -eux

export WORK=~/work
export CD=~/cd
export FORMAT=squashfs
export FS_DIR=casper

sudo rm -rf ${WORK} ${CD}
sudo mkdir -p ${CD}/{${FS_DIR},boot/grub} ${WORK}/rootfs


sudo apt-get update
sudo apt-get -y install grub2 xorriso squashfs-tools


sudo rsync -av --one-file-system --exclude=/proc/* --exclude=/dev/* \
	--exclude=/sys/* --exclude=/tmp/* --exclude=/lost+found \
        --exclude=/boot/grub/* \
        --exclude=/root/* \
	--exclude=/var/backup/* \
	--exclude=/var/cache/* \
	--exclude=/var/crash/* \
	--exclude=/var/lock/* \
	--exclude=/var/log/* \
	--exclude=/var/metrics/* \
	--exclude=/var/run/* \
	--exclude=/var/tmp/* \
	--exclude=/var/mail/* \
        --exclude=/var/spool/* \
        --exclude=/media/* \
	--exclude=/etc/fstab --exclude=/etc/mtab --exclude=/etc/hosts \
	--exclude=/etc/timezone --exclude=/etc/shadow* --exclude=/etc/gshadow* \
	--exclude=/etc/X11/xorg.conf* --exclude=${CD} --exclude=${WORK} \
	--exclude=/home/gnuradio/instant-gnuradio.iso \
	--exclude=/home/gnuradio/chroot-iso.sh \
	--exclude=/home/gnuradio/gen-iso.sh \
	/ ${WORK}/rootfs

sudo rm -rf ${WORK}/rootfs/etc/skel
sudo mv ${WORK}/rootfs/home/gnuradio ${WORK}/rootfs/etc/skel

sudo mount  --bind /dev/ ${WORK}/rootfs/dev
sudo mount -t proc proc ${WORK}/rootfs/proc
sudo mount -t sysfs sysfs ${WORK}/rootfs/sys
sudo mount -o bind /run ${WORK}/rootfs/run


########### ENTER CHROOT ################

sudo cp ~/chroot-iso.sh  ${WORK}/rootfs/
sudo chroot ${WORK}/rootfs /bin/bash /chroot-iso.sh

########### LEAVE CHROOT ###############


export kversion=`cd ${WORK}/rootfs/boot && ls -1 vmlinuz-* | tail -1 | sed 's@vmlinuz-@@'`
sudo cp -vp ${WORK}/rootfs/boot/vmlinuz-${kversion} ${CD}/${FS_DIR}/vmlinuz
sudo cp -vp ${WORK}/rootfs/boot/initrd.img-${kversion} ${CD}/${FS_DIR}/initrd.img
sudo cp -vp ${WORK}/rootfs/boot/memtest86+.bin ${CD}/boot


sudo umount ${WORK}/rootfs/proc
sudo umount ${WORK}/rootfs/sys
sudo umount ${WORK}/rootfs/dev
sudo umount ${WORK}/rootfs/run

sudo mksquashfs ${WORK}/rootfs ${CD}/${FS_DIR}/filesystem.${FORMAT} -noappend

echo -n $(sudo du -s --block-size=1 ${WORK}/rootfs | tail -1 | awk '{print $1}') | sudo tee ${CD}/${FS_DIR}/filesystem.size

find ${CD} -type f -print0 | sudo xargs -0 md5sum | sed "s@${CD}@.@" | grep -v md5sum.txt | sudo tee ${CD}/md5sum.txt

cat << EOF | sudo tee ${CD}/boot/grub/grub.cfg
set default="0"
set timeout=10

menuentry "Instant GNU Radio" {
linux /casper/vmlinuz boot=casper liveimg noprompt noeject --
initrd /casper/initrd.img
}

EOF

sudo grub-mkrescue -o ~/instant-gnuradio.iso ${CD}
